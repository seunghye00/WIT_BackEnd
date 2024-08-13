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
    
    // 메시지를 읽음 처리
    public void updateReadCount(String chatRoomSeq, String name) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", Integer.parseInt(chatRoomSeq));
        params.put("name", name);
        mybatis.update("chat.updateReadCount", params);
    }
    
    // 채팅 내역 출력
    public List<ChatDTO> chatListByRoom(int chat_room_seq) {
        return mybatis.selectList("chat.chatListByRoom", chat_room_seq);
    }

}
