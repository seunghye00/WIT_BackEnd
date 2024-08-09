package com.wit.dao;

import java.util.List;

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
	public List<ChatDTO> chatListByRoom(int chat_room_seq){
		return mybatis.selectList("chat.chatListByRoom", chat_room_seq);
	}
}
