package com.wit.endpoints;

import java.util.Collections;
import java.util.HashSet;
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

import com.google.gson.JsonObject;
import com.wit.configurators.WSHttpSessionConfigurator;

@ServerEndpoint(value="/global_chat", configurator = WSHttpSessionConfigurator.class)
public class GlobalChatEndpoint {

    // 세션 관리: 동기화된 Set과 ConcurrentHashMap 사용
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());
    private static Map<Session, String> sessionUserMap = new ConcurrentHashMap<>();
    private HttpSession hSession;

    // WebSocket 연결이 열릴 때 호출
    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        this.hSession = (HttpSession) config.getUserProperties().get("hSession");
        String loginID = (String) this.hSession.getAttribute("loginID");

        // 세션을 동기화된 Set에 추가하고 로그인 ID를 매핑
        sessions.add(session);
        sessionUserMap.put(session, loginID);

        System.out.println("Session opened for user: " + loginID);
    }

    // 클라이언트로부터 메시지를 수신할 때 호출
    @OnMessage
    public void onMessage(String message, Session session) {
        // 모든 세션에 메시지를 브로드캐스트 (기존 로직)
        synchronized (sessions) {
            sessions.forEach(client -> {
                try {
                    if (client.isOpen()) {
                        client.getBasicRemote().sendText(message);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
        }

        // 추가된 로직: 특정 클라이언트에게 알림 전송
        // 여기서는 메시지에서 특정 정보를 추출해 알림을 보낼 대상을 결정할 수 있습니다.
        String notificationMessage = "새로운 메시지가 도착했습니다.";
        String loginID = "특정_클라이언트_ID";  // 예를 들어, 특정 클라이언트의 ID
        GlobalChatEndpoint.notifyUnreadMessage(loginID, notificationMessage);
    }

    // WebSocket 연결이 닫힐 때 호출
    @OnClose
    public void onClose(Session session) {
        // 세션과 로그인 ID 매핑 제거
        sessions.remove(session);
        sessionUserMap.remove(session);

        System.out.println("Session closed for user: " + sessionUserMap.get(session));
    }

    // WebSocket 연결에서 에러가 발생할 때 호출
    @OnError
    public void onError(Throwable throwable, Session session) {
        // 에러 발생 시 세션과 로그인 ID 매핑 제거
        sessions.remove(session);
        sessionUserMap.remove(session);
        throwable.printStackTrace();
    }

    // 특정 사용자에게 알림을 전송하는 메서드
//    public static void notifyUnreadMessage(String loginID, String notificationMessage) {
//        System.out.println("Attempting to notify user: " + loginID);
//        synchronized (sessions) {
//            sessions.forEach(session -> {
//                String sessionLoginID = sessionUserMap.get(session);
//                System.out.println("Checking session for loginID: " + sessionLoginID);
//                if (loginID.equals(sessionLoginID)) {
//                    try {
//                        JsonObject notification = new JsonObject();
//                        notification.addProperty("type", "notification");
//                        notification.addProperty("message", notificationMessage);
//                        System.out.println("Sending notification to " + loginID + ": " + notificationMessage);
//                        session.getBasicRemote().sendText(notification.toString());
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                    }
//                }
//            });
//        }
//    }
    public static void notifyUnreadMessage(String loginID, String notificationMessage) {
        if (loginID == null) {
            System.out.println("Error: loginID is null, cannot send notification.");
            return;  // loginID가 null이면 알림을 보내지 않음
        }

        System.out.println("Attempting to notify user: " + loginID);
        synchronized (sessions) {
            sessions.forEach(session -> {
                String sessionLoginID = sessionUserMap.get(session);
                System.out.println("Checking session for loginID: " + sessionLoginID);
                if (sessionLoginID != null && loginID.equals(sessionLoginID)) {
                    try {
                        JsonObject notification = new JsonObject();
                        notification.addProperty("type", "notification");
                        notification.addProperty("message", notificationMessage);
                        System.out.println("Sending notification to " + loginID + ": " + notificationMessage);
                        session.getBasicRemote().sendText(notification.toString());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });
        }
    }
}
