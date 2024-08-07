package com.wit.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.dao.ChatRoomDAO;

@Service
public class ChatRoomService {
    @Autowired
    private ChatRoomDAO dao;

    // 개인 채팅방 생성
    @Transactional
    public String createPrivateChat(String emp_no1, String emp_no2, String chat_room_name) {
        Map<String, Object> params = new HashMap<>();
        params.put("emp_no1", emp_no1);
        params.put("emp_no2", emp_no2);
        params.put("chat_room_name", chat_room_name);
        params.put("chat_room_code", "P");

        // 중복 확인
        int count = dao.isPrivateChatRoomExists(params);
        if (count == 0) {
            dao.createChatRoom(params);
            int chatRoomSeq = dao.getLastChatRoomSeq();

            // 멤버 추가
            Map<String, Object> memberParams1 = new HashMap<>();
            memberParams1.put("chat_room_seq", chatRoomSeq);
            memberParams1.put("emp_no", emp_no1);
            dao.insertChatRoomMember(memberParams1);

            Map<String, Object> memberParams2 = new HashMap<>();
            memberParams2.put("chat_room_seq", chatRoomSeq);
            memberParams2.put("emp_no", emp_no2);
            dao.insertChatRoomMember(memberParams2);
            return "success";
        } else {
            // 이미 존재하는 경우 처리
            // 예를 들어, 이미 존재하는 채팅방의 정보를 반환하거나 처리합니다.
        	return "false";
        }
    }

    // 그룹 채팅방 생성
    @Transactional
    public void createGroupChat(String chatRoomName, List<String> empNos, String creater) {
        Map<String, Object> params = new HashMap<>();
        params.put("chat_room_name", chatRoomName);
        params.put("creater", creater);
        dao.createGroupChat(params);

        int chatRoomSeq = dao.getLastChatRoomSeq();

        for (String empNo : empNos) {
            Map<String, Object> memberParams = new HashMap<>();
            memberParams.put("chat_room_seq", chatRoomSeq);
            memberParams.put("emp_no", empNo);
            dao.insertChatRoomMember(memberParams);
        }
    }
    
    // 채팅방 목록 조회
    @Transactional
    public List<Map<String, Object>> getChatRoomsByUserId(String loginUserId) {
        return dao.getChatRoomsByUserId(loginUserId);
    }
    
    // 채팅방 상세 조회
    @Transactional
    public List<Map<String, Object>> getDetailChatRooms(int chat_room_seq) {
    	return dao.getDetailChatRooms(chat_room_seq);
    }
}
