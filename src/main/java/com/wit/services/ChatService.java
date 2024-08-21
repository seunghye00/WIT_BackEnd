package com.wit.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonObject;
import com.wit.dao.ChatDAO;
import com.wit.dto.ChatDTO;
import com.wit.endpoints.ChatEndpoint;

@Service
public class ChatService {

    @Autowired
    private ChatDAO dao;
    
    @Autowired
    private UserService userv;
    
    // 메시지를 읽음 처리
    @Transactional
    public boolean markMessagesAsRead(String chatRoomSeq,int messageSeq, String name) {
        return dao.checkIfAlreadyRead(chatRoomSeq, messageSeq, name);
    }
    
    // 채팅 메시지 입력
    @Transactional
    public int insert(String chatRoomSeq, String name, String message, int read_count)  {
        String sender = userv.getUserNameByLoginID(name);
        return dao.insertChat(new ChatDTO(0, Integer.parseInt(chatRoomSeq), name, sender, message, null, read_count));
    }
    
    // 특정 채팅방의 채팅 내역 출력
    @Transactional
    public List<ChatDTO> chatListByRoom(String chat_room_seq) {
        return dao.chatListByRoom(Integer.parseInt(chat_room_seq));
    }
    
    // 로그인 ID로 사용자 이름 가져오기
    @Transactional
    public String getUserNameByLoginID(String loginID) {
        return userv.getUserNameByLoginID(loginID);
    }
    
     // 읽지 않은 사용자 목록 조회
    @Transactional
    public List<Map<String, Object>> getUnreadUsers(int chatRoomSeq) {
        return dao.getUnreadUsers(chatRoomSeq);
    }
    
    // 채팅방 멤버 수 조회
    @Transactional
    public int getChatRoomMemberCount(String chat_room_seq) {
    	return dao.getChatRoomMemberCount(Integer.parseInt(chat_room_seq));
    }
    
    // read_count 감소
    @Transactional
    public int decreaseReadCount(String chatRoomSeq, int chatSeq, String userName) {
        int result = dao.decreaseReadCount(Integer.parseInt(chatRoomSeq), chatSeq, userName);
        System.out.println("Decreased read count for chatSeq " + chatSeq + ": " + result);
        return result;
    }
}
