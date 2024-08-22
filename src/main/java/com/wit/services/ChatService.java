package com.wit.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.dao.ChatDAO;
import com.wit.dto.ChatDTO;
import com.wit.endpoints.ChatEndpoint;

@Service
public class ChatService {

    @Autowired
    private ChatDAO dao;
    
    @Autowired
    private UserService userv;
    
    // 로그인 ID로 사용자 이름 가져오기
    @Transactional
    public String getUserNameByLoginID(String loginID) {
        return userv.getUserNameByLoginID(loginID);
    }

    // 이미 메시지를 읽었는지 확인하는 메서드
    @Transactional
    public boolean checkIfAlreadyRead(String chatRoomSeq, int messageSeq, String userName) {
        return dao.checkIfAlreadyRead(chatRoomSeq, messageSeq, userName);
    }

    // 메시지의 현재 읽음 수를 반환하는 메서드
    @Transactional
    public int getReadCount(int chatSeq) {
        return dao.getReadCount(chatSeq);
    }
    
    // 메시지를 읽음 처리
    @Transactional
    public int getUpdatedReadCount(String chatRoomSeq, int chatSeq) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", chatRoomSeq);
        params.put("chat_seq", chatSeq);
        return dao.getUpdatedReadCount(params);
    }
    
    // 채팅 메시지 입력
    @Transactional
    public int insert(String chatRoomSeq, String name, String message, int read_count) {
        String sender = userv.getUserNameByLoginID(name);
        ChatDTO chatDTO = new ChatDTO(0, Integer.parseInt(chatRoomSeq), name, sender, message, null, read_count, " ");
        return dao.insertChat(chatDTO);
    }

    // 특정 채팅방의 채팅 내역 출력
    @Transactional
    public List<ChatDTO> chatListByRoom(String chatRoomSeq) {
        return dao.chatListByRoom(Integer.parseInt(chatRoomSeq));
    }
    
    // 채팅방 멤버 수 조회
    @Transactional
    public int getChatRoomMemberCount(String chatRoomSeq) {
        return dao.getChatRoomMemberCount(Integer.parseInt(chatRoomSeq));
    }
    
    // read_count 감소 및 읽음 처리
    @Transactional
    public int decreaseReadCount(String chatRoomSeq, int chatSeq, String userName) {
        if (userName == null || chatRoomSeq == null) {
            throw new IllegalArgumentException("Invalid input parameters");
        }

        boolean alreadyRead = dao.checkIfAlreadyRead(chatRoomSeq, chatSeq, userName);
        System.out.println(alreadyRead);
        if (!alreadyRead) {
            // 메시지를 읽은 사용자를 `read_receivers`에 추가하고 read_count를 감소시킵니다.
            dao.addReaderToMessage(chatRoomSeq, chatSeq, userName);
            int updatedReadCount = dao.decreaseReadCount(Integer.parseInt(chatRoomSeq), chatSeq, userName);
            return updatedReadCount;
        } else {
            return 0;
        }
    }
}

