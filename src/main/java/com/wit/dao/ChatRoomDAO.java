package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatRoomDAO {
    @Autowired
    private SqlSession mybatis;

    // 개인 채팅방 생성
    public void createChatRoom(Map<String, Object> params) {
        mybatis.insert("chatRoom.createChatRoom", params);
    }

    // 그룹 채팅방 생성
    public void createGroupChat(Map<String, Object> params) {
        mybatis.insert("chatRoom.createGroupChat", params);
    }

    // 채팅방 멤버 추가
    public void insertChatRoomMember(Map<String, Object> params) {
        mybatis.insert("chatRoom.insertChatRoomMember", params);
    }

    // 개인 채팅방 존재 여부 확인
    public int isPrivateChatRoomExists(Map<String, Object> params) {
        return mybatis.selectOne("chatRoom.isPrivateChatRoomExists", params);
    }

    // 최근 생성된 채팅방 시퀀스 조회
    public int getLastChatRoomSeq() {
        return mybatis.selectOne("chatRoom.getLastChatRoomSeq");
    }
    
    // 특정 사용자가 속한 채팅방 조회
    public List<Map<String, Object>> getChatRoomsByUserId(String loginUserId) {
        return mybatis.selectList("chatRoom.getChatRoomsByUserId", loginUserId);
    }
    
    // 채팅방 상세 조회
    public List<Map<String, Object>> getDetailChatRooms(int chat_room_seq) {
    	return mybatis.selectList("chatRoom.getDetailChatRooms", chat_room_seq);
    }
}
