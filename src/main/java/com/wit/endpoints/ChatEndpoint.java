package com.wit.endpoints;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.wit.configurators.SpringProvider;
import com.wit.configurators.WSHttpSessionConfigurator;
import com.wit.dto.ChatDTO;
import com.wit.services.ChatService;

@ServerEndpoint(value = "/chat", configurator = WSHttpSessionConfigurator.class)
public class ChatEndpoint {

    // 전체 세션을 관리하는 Set
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    // 각 세션과 해당 세션의 사용자 로그인 ID를 매핑하는 맵
    private static final ConcurrentHashMap<Session, String> sessionUserMap = new ConcurrentHashMap<>();

    // 각 세션과 해당 세션이 속한 채팅방의 chatRoomSeq를 매핑하는 맵
    private static final ConcurrentHashMap<Session, String> sessionChatRoomMap = new ConcurrentHashMap<>();

    // ChatService 인스턴스 - Spring에서 관리
    private final ChatService cServ = SpringProvider.getSpring().getBean(ChatService.class);

    // Gson 객체 - 날짜 형식 지정
    private static final Gson gson = new GsonBuilder().setDateFormat("HH:mm").create();

    // HttpSession 객체 - WebSocket에서 사용자 세션 관리
    private HttpSession hSession;

    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        // WebSocket 연결이 열리면 HttpSession을 가져와서 사용자 로그인 ID를 저장
        this.hSession = (HttpSession) config.getUserProperties().get("hSession");
        String loginID = (String) this.hSession.getAttribute("loginID");

        // 세션을 전체 세션 Set에 추가하고, 사용자 맵에 로그인 ID 매핑
        sessions.add(session);
        sessionUserMap.put(session, loginID);
    }

    @OnMessage
    public void onMessage(Session session, String message) {
        JsonObject jsonMessage = gson.fromJson(message, JsonObject.class);
        String type = jsonMessage.get("type").getAsString();

        if ("join".equals(type)) {
            String chatRoomSeq = jsonMessage.get("chatRoomSeq").getAsString();
            sessionChatRoomMap.put(session, chatRoomSeq);

            // 먼저 loginID 메시지를 보냅니다.
            JsonObject loginIDResponse = new JsonObject();
            String loginID = sessionUserMap.get(session);
            loginIDResponse.addProperty("type", "loginID");
            loginIDResponse.addProperty("loginID", loginID);
            try {
                session.getBasicRemote().sendText(loginIDResponse.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }

            // 그 후 chatHistory 메시지를 보냅니다.
            List<ChatDTO> chatList = cServ.chatListByRoom(chatRoomSeq);
            JsonObject response = new JsonObject();
            response.addProperty("type", "chatHistory");
            response.add("chatHistory", gson.toJsonTree(chatList));
            try {
                session.getBasicRemote().sendText(response.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if ("chat".equals(type)) {
            String chatRoomSeq = sessionChatRoomMap.get(session);
            processChatMessage(session, chatRoomSeq, jsonMessage);
        }
    }

    private void processChatMessage(Session session, String chatRoomSeq, JsonObject jsonMessage) {
    	// 로그인 ID 가져오기
        String sender = sessionUserMap.get(session);
        if (sender == null) {
            System.out.println("Sender is null. Session: " + session);
            return;
        }

        // 사용자의 이름 가져오기
        String userName = cServ.getUserNameByLoginID(sender);
        if (userName == null) {
            System.out.println("UserName is null. Sender: " + sender);
            return;
        }

        // 채팅방 멤버 수 가져오기
        int memberCount;
        try {
            memberCount = cServ.getChatRoomMemberCount(chatRoomSeq);
            if (memberCount == 0) {
                System.out.println("Member count is zero or invalid for chatRoomSeq: " + chatRoomSeq);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        
        // 메시지를 DB에 저장하고 chat_seq를 반환받음
        int chatSeq;
        try {
            String messageContent = jsonMessage.get("message").getAsString();
            if (messageContent == null || messageContent.isEmpty()) {
                System.out.println("Message content is null or empty.");
                return;
            }

            chatSeq = cServ.insert(chatRoomSeq, sender, messageContent, memberCount - 1);
            if (chatSeq <= 0) {
                System.out.println("Failed to insert chat message. ChatSeq: " + chatSeq);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // 클라이언트로 보낼 데이터 생성
        JsonObject data = new JsonObject();
        data.addProperty("chat_seq", chatSeq);
        data.addProperty("chat_room_seq", chatRoomSeq);
        data.addProperty("sender", userName);
        data.addProperty("message", jsonMessage.get("message").getAsString());
        data.addProperty("send_time", getCurrentTime());
        data.addProperty("type", "chat");
        data.addProperty("name", sender);
        data.addProperty("read_count", memberCount - 1);
        // 해당 채팅방에 있는 모든 세션에 메시지 전송
        synchronized (sessions) {
            for (Session client : sessions) {
                String recipientChatRoomSeq = sessionChatRoomMap.get(client);
                if (chatRoomSeq.equals(recipientChatRoomSeq)) {
                    try {
                        String recipient = sessionUserMap.get(client);
                        if (recipient != null && !recipient.equals(sender)) {
                            int updatedReadCount = cServ.decreaseReadCount(chatRoomSeq, chatSeq, recipient);
                            broadcastReadCountUpdate(chatRoomSeq, chatSeq, updatedReadCount);
                        }
                        if (client.isOpen()) {
                            client.getBasicRemote().sendText(data.toString());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        // 메시지를 받지 않은 사용자에게 알림 전송
        if (!sender.equals(userName)) {  // 이 조건 추가
            sendUnreadNotifications(chatRoomSeq, userName);
        }    
    }

    private void sendUnreadNotifications(String chatRoomSeq, String sender) {
        try {
            int chatRoomSeqInt = Integer.parseInt(chatRoomSeq);
            List<Map<String, Object>> unreadUsers = cServ.getUnreadUsers(chatRoomSeqInt);

            for (Map<String, Object> user : unreadUsers) {
                String receiverName = (String) user.get("RECEIVER");
                System.out.println(receiverName.equals(sender));
                if (!sender.equals(receiverName)) {
                    notifyUnreadMessage(receiverName, sender + "님이 새 메시지를 보냈습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        // WebSocket 연결이 닫힐 때, 세션을 제거
        sessions.remove(session);
        sessionUserMap.remove(session);
        sessionChatRoomMap.remove(session);
    }

    @OnError
    public void onError(Throwable t, Session session) {
        // WebSocket 연결 중 에러 발생 시, 해당 세션을 제거
        sessions.remove(session);
        sessionUserMap.remove(session);
        sessionChatRoomMap.remove(session);
        t.printStackTrace();
    }

    // 현재 시간을 HH:mm 형식으로 반환하는 유틸리티 메서드
    private String getCurrentTime() {
        long currentTimeMillis = System.currentTimeMillis();
        return new SimpleDateFormat("HH:mm").format(currentTimeMillis);
    }

    // 특정 사용자에게 알림 메시지를 전송하는 메서드
    public static void notifyUnreadMessage(String loginID, String notificationMessage) {
        if (loginID == null) {
            return;
        }

        synchronized (sessions) {
            for (Session session : sessions) {
                String sessionLoginID = sessionUserMap.get(session);
                if (sessionLoginID != null && loginID.equals(sessionLoginID)) {
                    try {
                        JsonObject notification = new JsonObject();
                        notification.addProperty("type", "notification");
                        notification.addProperty("message", notificationMessage);
                        session.getBasicRemote().sendText(notification.toString());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
    
    private void broadcastReadCountUpdate(String chatRoomSeq, int chatSeq, int updatedReadCount) {
        JsonObject data = new JsonObject();
        data.addProperty("type", "readCountUpdate");
        data.addProperty("chatRoomSeq", chatRoomSeq);
        data.addProperty("chatSeq", chatSeq);
        data.addProperty("updatedReadCount", updatedReadCount);

        synchronized (sessions) {
            for (Session client : sessions) {
                String recipientChatRoomSeq = sessionChatRoomMap.get(client);
                if (chatRoomSeq.equals(recipientChatRoomSeq) && client.isOpen()) {
                    try {
                        client.getBasicRemote().sendText(data.toString());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
