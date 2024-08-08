package com.wit.endpoints;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

@ServerEndpoint("/chat")
public class ChatEndpoint {

    // 연결된 각 클라이언트의 sessionID와 session을 저장하는 스레드 안전한 Map
    private static final Map<String, Session> clients = Collections.synchronizedMap(new HashMap<>());

    // 연결 확인 (onConnect)
    @OnOpen
    public void onConnect(Session session) {
        String sessionId = session.getId();
        clients.put(sessionId, session);
        System.out.println("[연결됨] " + sessionId);
    }

    // 메시지 (onMessage)
    @OnMessage
    public void onMessage(Session session, String message) {
        // Gson 객체 생성
        Gson gson = new Gson();

        // JSON 객체 생성
        MessageObject messageObject = new MessageObject(session.getId(), message);
        String jsonString = gson.toJson(messageObject);

        // 모든 클라이언트에게 메시지 전송
        for (Map.Entry<String, Session> entry : clients.entrySet()) {
            try {
                entry.getValue().getBasicRemote().sendText(jsonString);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 메시지 전송 확인 출력
        System.out.println("[메시지 전송] " + message);
    }

    @OnClose
    public void onClose(Session session) {
        String sessionId = session.getId();
        clients.remove(sessionId);
        System.out.println("[연결 해제] " + sessionId);
    }

    @OnError
    public void onError(Throwable t, Session session) {
        String sessionId = session.getId();
        clients.remove(sessionId);
        System.out.println("[오류 발생] " + sessionId + ", 오류: " + t.getMessage());
    }
    
    class MessageObject {
        private String sessionId;
        private String message;

        public MessageObject(String sessionId, String message) {
            this.sessionId = sessionId;
            this.message = message;
        }

        // Getter, Setter (필요시 추가)
    }
}