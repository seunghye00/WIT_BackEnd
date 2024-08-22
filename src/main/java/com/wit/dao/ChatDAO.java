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
        mybatis.insert("chat.insertChat", dto);
        return dto.getChat_seq();
    }
    
    // 메시지를 읽음 처리
    public int getUpdatedReadCount(Map<String, Object> params) {
        return mybatis.selectOne("chat.getUpdatedReadCount", params);
    }
    
    // 채팅 내역 출력
    public List<ChatDTO> chatListByRoom(int chat_room_seq) {
        return mybatis.selectList("chat.chatListByRoom", chat_room_seq);
    }
    
    // 읽지 않은 사용자 목록 조회
    public List<Map<String, Object>> getUnreadUsers(Map<String, Object> params) {
        return mybatis.selectList("chat.getUnreadUsers", params);
    }
    
    // 채팅방 멤버 수 조회
    public int getChatRoomMemberCount(int chat_room_seq) {
        return mybatis.selectOne("chat.getChatRoomMemberCount", chat_room_seq);
    }
    
    // read_count 감소
    public int decreaseReadCount(int chatRoomSeq, int chatSeq, String userName) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", chatRoomSeq);
        params.put("chat_seq", chatSeq);
        params.put("user_name", userName);
        mybatis.update("chat.decreaseReadCount", params);
        return mybatis.selectOne("chat.getReadCount", chatSeq); // 감소된 read_count 값을 반환
    }
    
    // 메시지를 읽음 처리
    public boolean checkIfAlreadyRead(String chatRoomSeq, int messageSeq, String name) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", Integer.parseInt(chatRoomSeq));
        params.put("message_seq", messageSeq);
        params.put("name", name);
        int count = mybatis.selectOne("chat.checkIfAlreadyRead", params);
        return count > 0;
    }
    
    // 메시지를 읽음 처리
    public List<ChatDTO> getUnreadMessages(int chatRoomSeq, String userName) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("userName", userName);
        return mybatis.selectList("chat.getUnreadMessages", params);
    }
    
    // 특정 메시지의 현재 read_count 값을 반환
    public int getReadCount(int chatSeq) {
        return mybatis.selectOne("chat.getReadCount", chatSeq);
    }
    
    // read_receivers 필드에 사용자 ID를 추가하는 메서드 (DAO에서 처리)
    public void addReaderToMessage(String chatRoomSeq, int chatSeq, String userName) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", chatRoomSeq);
        params.put("chat_seq", chatSeq);
        params.put("userName", userName);
        mybatis.update("chat.addReaderToMessage", params);
    }
    
    // 메시지내역 처리 null인지 값 확인
    public boolean isReadReceiversNull(String chatRoomSeq, int chatSeq) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", chatRoomSeq);
        params.put("chat_seq", chatSeq);
        int result = mybatis.selectOne("chat.isReadReceiversNull", params);
        return result == 1;
    }
    
    // 메시지내역 처리 null 통과 이후 처리
    public boolean isUserInReadReceivers(String chatRoomSeq, int chatSeq, String userName) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", chatRoomSeq);
        params.put("chat_seq", chatSeq);
        params.put("userName", userName);
        int result = mybatis.selectOne("chat.isUserInReadReceivers", params);
        return result == 1;
    }
}