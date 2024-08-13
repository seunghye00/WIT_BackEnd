package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.ChatDTO;

@Repository
public class ChatDAO {

    @Autowired
    private SqlSession mybatis;

    // 채팅 입력
    public int insertChat(ChatDTO dto) {
        return mybatis.insert("chat.insertChat", dto);
    }

    // 채팅 내역 출력
    public List<ChatDTO> chatListByRoom(int chat_room_seq) {
        return mybatis.selectList("chat.chatListByRoom", chat_room_seq);
    }

    // 채팅방의 읽음 상태 업데이트
    public void updateChatRoomReadStatus(int chatRoomSeq, int isRead) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("isRead", isRead);
        mybatis.update("chat.updateChatRoomReadStatus", params);
    }
    
    // 채팅 읽음 상태 업데이트
    public void markMessagesAsRead(String chatRoomSeq, String empNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("empNo", empNo);

        mybatis.update("chat.markMessagesAsRead", params);
    }

}
