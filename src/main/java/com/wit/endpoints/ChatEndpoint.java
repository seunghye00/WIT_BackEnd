package com.wit.endpoints;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.HashMap;
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
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wit.configurators.SpringProvider;
import com.wit.configurators.WSHttpSessionConfigurator;
import com.wit.dto.ChatDTO;
import com.wit.services.ChatService;

@ServerEndpoint(value="/chat/{chatRoomSeq}", configurator = WSHttpSessionConfigurator.class)
public class ChatEndpoint {

    private static ConcurrentHashMap<String, Set<Session>> chatRooms = new ConcurrentHashMap<>();
    private static ConcurrentHashMap<Session, String> sessionUserMap = new ConcurrentHashMap<>();
    private HttpSession hSession;
    private ChatService cServ = SpringProvider.getSpring().getBean(ChatService.class);
    
    // Gson 객체를 생성하여 날짜 형식을 지정합니다.
    private static final Gson gson = new GsonBuilder()
            .setDateFormat("HH:mm")
            .create();

    @OnOpen
    public void onConnect(@PathParam("chatRoomSeq") String chatRoomSeq, EndpointConfig config, Session session) {
        // HttpSession을 가져와서 hSession 변수에 저장합니다.
        this.hSession = (HttpSession) config.getUserProperties().get("hSession");

        // 로그인 ID를 HttpSession에서 가져옵니다.
        String loginID = (String) this.hSession.getAttribute("loginID");

        // 현재 세션을 클라이언트 세트에 추가합니다.
        chatRooms.putIfAbsent(chatRoomSeq, Collections.synchronizedSet(new HashSet<>()));
        chatRooms.get(chatRoomSeq).add(session);

        // 세션과 로그인 ID를 맵에 저장합니다.
        sessionUserMap.put(session, loginID);
        // 사용자의 이름을 가져옴
        String userName = cServ.getUserNameByLoginID(loginID);
        
        // 클라이언트에게 이전 채팅 내역과 로그인 ID를 전송
        try {
            // 데이터베이스에서 채팅 내역을 가져옵니다.
            List<ChatDTO> chatList = cServ.chatListByRoom(chatRoomSeq);

            // JSON 응답 객체를 생성합니다.
            JsonObject response = new JsonObject();
            response.addProperty("loginID", userName);

            // 채팅 내역을 JSON으로 변환하여 응답에 추가합니다.
            response.add("chatHistory", gson.toJsonTree(chatList));

            // 클라이언트에게 JSON 응답을 전송합니다.
            session.getBasicRemote().sendText(response.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // 발신자와 로그인한 사용자가 동일하지 않을 때만 자동 읽음 처리
        if (!sessionUserMap.get(session).equals(loginID)) {
            cServ.markMessagesAsRead(chatRoomSeq, loginID);
        }
    }
    
    @OnMessage
    public void onMessage(@PathParam("chatRoomSeq") String chatRoomSeq, Session session, String message) {
        JsonObject jsonMessage = gson.fromJson(message, JsonObject.class);

        // 현재 시간 생성 (HH:mm 형식으로 변환)
        String currentTime = getCurrentTime();

        // 로그인 ID 가져오기
        String sender = sessionUserMap.get(session);
        String userName = cServ.getUserNameByLoginID(sender);

        // 메시지 DB에 저장 및 chat_seq 반환
        int chatSeq;
        try {
            chatSeq = cServ.insert(chatRoomSeq, sender, jsonMessage.get("message").getAsString(), 1);  // read_count를 1로 설정
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // 메시지 데이터 생성
        JsonObject data = new JsonObject();
        data.addProperty("chat_seq", chatSeq);  // chat_seq를 포함
        data.addProperty("chat_room_seq", chatRoomSeq);  // chat_room_seq를 포함
        data.addProperty("userName", userName);
        data.addProperty("sender", userName);
        data.addProperty("message", jsonMessage.get("message").getAsString());
        data.addProperty("send_time", currentTime);
        data.addProperty("type", "chat");
        data.addProperty("read_count", 1);  // 기본적으로 1로 설정

        // 메시지 전송
        synchronized (chatRooms.get(chatRoomSeq)) {
            for (Session client : chatRooms.get(chatRoomSeq)) {
                try {
                    String recipient = sessionUserMap.get(client);
                    if (recipient != null && !recipient.equals(sender)) {
                        // 읽음 처리는 여기서 하지 않고 클라이언트 측에서 메시지를 수신했을 때 처리
                        if (client.isOpen()) {
                            // 여전히 read_count를 1로 유지
                        	 JsonObject notification = new JsonObject();
                             notification.addProperty("type", "notification");
                             notification.addProperty("message", userName + "님이 메시지를 보냈습니다.");
                             client.getBasicRemote().sendText(notification.toString());
                        }
                    }
                    client.getBasicRemote().sendText(data.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        // 특정 사용자가 메시지를 받지 않았다면 글로벌 알림 전송
        try {
            int chatRoomSeqInt = Integer.parseInt(chatRoomSeq);
            List<Map<String, Object>> unreadUsers = cServ.getUnreadUsers(chatRoomSeqInt);
            
            for (Map<String, Object> user : unreadUsers) {
                String receiverName = (String) user.get("RECEIVER");
                String senderName = (String) user.get("SENDER");
                System.out.println(user);
                if (!sender.equals(receiverName)) { // 보낸 사람을 제외하고
                    GlobalChatEndpoint.notifyUnreadMessage(receiverName, senderName + "님이 새 메시지를 보냈습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @OnClose
    public void onClose(@PathParam("chatRoomSeq") String chatRoomSeq, Session session) {
        String loginID = sessionUserMap.get(session);
        chatRooms.get(chatRoomSeq).remove(session);
        sessionUserMap.remove(session);
    }
    
    @OnError
    public void onError(Throwable t, @PathParam("chatRoomSeq") String chatRoomSeq, Session session) {
        String loginID = sessionUserMap.get(session);
        chatRooms.get(chatRoomSeq).remove(session);
        sessionUserMap.remove(session);
        t.printStackTrace();

        // 에러 발생 시 사용자가 퇴장했다는 메시지를 해당 채팅방의 모든 클라이언트에게 전송합니다.
        broadcastUserStatus(chatRoomSeq, loginID, "left");
    }

    // 현재 시간을 HH:mm 형식
    // 현재 시간을 HH:mm 형식으로 반환하는 메소드
    private String getCurrentTime() {
        long currentTimeMillis = System.currentTimeMillis();
        return new SimpleDateFormat("HH:mm").format(currentTimeMillis);
    }

    // 사용자 상태 변경을 브로드캐스트하는 메소드
    public void broadcastUserStatus(String chatRoomSeq, String loginID, String status) {
        JsonObject statusMessage = new JsonObject();
        statusMessage.addProperty("user", loginID);
        statusMessage.addProperty("status", status);
        statusMessage.addProperty("type", "status");
        statusMessage.addProperty("send_time", getCurrentTime());

        synchronized (chatRooms.get(chatRoomSeq)) {
        	for (Session client : chatRooms.get(String.valueOf(chatRoomSeq))) {
                try {
                    client.getBasicRemote().sendText(statusMessage.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
