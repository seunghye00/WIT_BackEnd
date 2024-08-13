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
    
    // 메시지를 읽음 처리
    @Transactional
    public void markMessagesAsRead(String chatRoomSeq, String name) {
        dao.updateReadCount(chatRoomSeq, name);
    }
    // 채팅 메시지 입력
    @Transactional
    public int insert(String chatRoomSeq, String name, String message, int read_count) throws Exception {
    	System.out.println(read_count);
        String sender = userv.getUserNameByLoginID(name);
        return dao.insertChat(new ChatDTO(0, Integer.parseInt(chatRoomSeq), name, sender, message, null, read_count));
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
}
