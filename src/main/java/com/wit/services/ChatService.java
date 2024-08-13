package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonObject;
import com.wit.dao.ChatDAO;
import com.wit.dao.NotificationDAO;
import com.wit.dto.ChatDTO;
import com.wit.endpoints.ChatEndpoint;

@Service
public class ChatService {

    @Autowired
    private ChatDAO dao;
    
    @Autowired
    private UserService userv;
    
    @Autowired
    private NotificationDAO notiDao;
    
    // 채팅 메시지 입력
    @Transactional
    public int insert(String chatRoomSeq, String name, String message) throws Exception {
        String sender = userv.getUserNameByLoginID(name);
        return dao.insertChat(new ChatDTO(0, Integer.parseInt(chatRoomSeq), name, sender, message, null));
    }
    
    // 특정 채팅방의 채팅 내역 출력
    @Transactional
    public List<ChatDTO> chatListByRoom(String chat_room_seq) throws Exception {
        return dao.chatListByRoom(Integer.parseInt(chat_room_seq));
    }
    
    // 로그인 ID로 사용자 이름 가져오기
    @Transactional
    public String getUserNameByLoginID(String loginID) {
        return userv.getUserNameByLoginID(loginID);
    }
    
    // 새로운 메시지가 도착했을 때 처리
    @Transactional
    public void handleNewMessage(int chatRoomSeq, String empNo, int chatSeq) {
        // 채팅방 읽음 상태를 1로 설정 (새 메시지 있음)
    	dao.updateChatRoomReadStatus(chatRoomSeq, 1);

        // 알림 생성
        notiDao.insertNotification(empNo, chatSeq);
    }

    // 사용자가 메시지를 읽었을 때 처리
    @Transactional
    public void markMessagesAsRead(int chatRoomSeq, String empNo) {
        // 채팅방 읽음 상태를 0으로 설정 (새 메시지 없음)
    	dao.updateChatRoomReadStatus(chatRoomSeq, 0);

        // 알림 삭제
        notiDao.deleteNotifications(chatRoomSeq, empNo);
    }
    
    // 사용자가 읽었는지 확인 처리 
    @Transactional
    public void markMessagesAsRead(String chatRoomSeq, String empNo) {
        dao.markMessagesAsRead(chatRoomSeq, empNo);
    }
    
    @Transactional
    public void broadcastUserLeft(int chatRoomSeq, String userName) {
        // 채팅방에 있는 모든 사용자에게 "사용자가 나갔습니다" 메시지를 보냄
        // 이 부분은 WebSocket을 통해 전송됩니다.
        // 예를 들어, WebSocket Endpoint에서 직접 처리할 수 있습니다.
        // ChatEndpoint의 broadcastUserStatus와 비슷한 로직을 사용하면 됩니다.
        
        // WebSocket을 통해 나갔다는 상태 메시지를 브로드캐스트
        JsonObject statusMessage = new JsonObject();
        statusMessage.addProperty("user", userName);
        statusMessage.addProperty("status", "left");
        statusMessage.addProperty("type", "status");

        // 여기서 실제 WebSocket 세션으로 메시지를 보내는 로직이 필요합니다.
        // 이는 ChatEndpoint 클래스에서 처리할 수 있습니다.
        ChatEndpoint chatEndpoint = new ChatEndpoint();
        chatEndpoint.broadcastUserStatus(String.valueOf(chatRoomSeq), userName, "left");
    }
}
