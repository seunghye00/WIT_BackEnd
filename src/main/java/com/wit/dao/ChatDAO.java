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
    public boolean checkIfAlreadyRead(String chatRoomSeq, int messageSeq, String name) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_seq", Integer.parseInt(chatRoomSeq));
        params.put("message_seq", messageSeq);
        params.put("name", name);
        // selectOne의 결과를 Integer로 캐스팅
        Integer count = (Integer) mybatis.selectOne("chat.checkIfAlreadyRead", params);
        
        // count가 null이 아니고 0보다 큰지 확인
        return count != null && count > 0;    
    }
    
    // 채팅 내역 출력
    public List<ChatDTO> chatListByRoom(int chat_room_seq) {
        return mybatis.selectList("chat.chatListByRoom", chat_room_seq);
    }
    
    // 읽지 않은 사용자 목록 조회
    public List<Map<String, Object>> getUnreadUsers(int chatRoomSeq) {
        return mybatis.selectList("chat.getUnreadUsers", chatRoomSeq);
    }
    
    // 채팅방 멤버 수 조회
    public int getChatRoomMemberCount(int chat_room_seq) {
        return mybatis.selectOne("chatRoom.getChatRoomMemberCount", chat_room_seq);
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
}
