package com.wit.dao;

import java.util.HashMap;
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
    public List<Map<String, Object>> getDetailChatRooms(Map<String, Object> params) {
    	return mybatis.selectList("chatRoom.getDetailChatRooms", params);
    }
    
    // 채팅방 타이틀 수정
    public void updateChatRoomTitle(Map<String, Object> params) {
        mybatis.update("chatRoom.updateChatRoomTitle", params);
    }
    
    // 채팅방 코드 가져오기
    public String getChatRoomCode(Map<String, Object> params) {
        return mybatis.selectOne("chatRoom.getChatRoomCode", params);
    }

    // 채팅방 삭제
    public void deleteChatRoom(int chat_room_seq) {
        mybatis.delete("chatRoom.deleteChatRoom", chat_room_seq);
    }

    // 채팅방 멤버 삭제
    public void deleteChatRoomMember(int chat_room_seq, String emp_no) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", chat_room_seq);
        params.put("emp_no", emp_no);
        mybatis.delete("chatRoom.deleteChatRoomMember", params);
    }
}
