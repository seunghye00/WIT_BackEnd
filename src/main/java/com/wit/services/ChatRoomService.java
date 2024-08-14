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
    
    @Autowired
    private UserService userv;
    
    // 개인 채팅방 생성
    @Transactional
    public String createPrivateChat(String emp_no1, String empNo2) {
    	// 채팅방 생성
        Map<String, Object> params = new HashMap<>();
        params.put("roomType", "1:1");
        dao.createChatRoom(params);
        int chatRoomSeq = dao.getLastChatRoomSeq();

        // emp_no1 이름 가져오기
        String empNo1Name = userv.getUserNameByLoginID(emp_no1);
        // emp_no2 이름 가져오기
        String empNo2Name = userv.getUserNameByLoginID(empNo2);

        // 멤버 추가
        addChatRoomMember(chatRoomSeq, emp_no1, empNo2Name);
        addChatRoomMember(chatRoomSeq, empNo2, empNo1Name);

        return "success";
    }

    // 그룹 채팅방 생성
    @Transactional
    public void createGroupChat(String chatRoomName, List<String> empNos, String creatorEmpNo) {
        // 그룹 채팅방 생성
        dao.createGroupChat();
        
        // 채팅방 시퀀스 가져오기
        int chatRoomSeq = dao.getLastChatRoomSeq();
        System.out.println(chatRoomSeq);

        // 생성자를 그룹 채팅방에 추가
        String creatorName = userv.getUserNameByLoginID(creatorEmpNo);
        addChatRoomMember(chatRoomSeq, creatorEmpNo, chatRoomName);

        // 다른 멤버들을 추가
        for (String empNo : empNos) {
            String empName = userv.getUserNameByLoginID(empNo); // 멤버의 이름을 가져옴
            addChatRoomMember(chatRoomSeq, empNo, chatRoomName);
        }
    }

    // 멤버 추가 메서드
    @Transactional
    private void addChatRoomMember(int chatRoomSeq, String empNo, String chatRoomName) {
        Map<String, Object> memberParams = new HashMap<>();
        memberParams.put("chatRoomSeq", chatRoomSeq);
        memberParams.put("empNo", empNo);
        memberParams.put("chatRoomName", chatRoomName);
        dao.addChatRoomMember(memberParams);
    }
    
    // 채팅방 목록 조회
    @Transactional
    public List<Map<String, Object>> getChatRoomsByUserId(String empNo) {
        return dao.getChatRoomsByUserId(empNo);
    }

    // 채팅방 상세 조회
    @Transactional
    public List<Map<String, Object>> getDetailChatRooms(int chatRoomSeq, String empNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("empNo", empNo);
        return dao.getDetailChatRooms(params);
    }

    // 채팅방 제목 수정
    @Transactional
    public void updateChatRoomTitle(int chat_room_seq, String new_title, String empNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chat_room_seq);
        params.put("newTitle", new_title);
        params.put("empNo", empNo);
        dao.updateChatRoomTitle(params);
    }

    // 채팅방 나가기
    @Transactional
    public String exitChatRoom(int chatRoomSeq, String empNo) {
        // 1:1 채팅방인지 확인
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("empNo", empNo);
        String chatRoomCode = dao.getChatRoomCode(params);

        if ("1:1".equals(chatRoomCode)) {
            dao.deleteChatRoom(chatRoomSeq);
        }
        dao.deleteChatRoomMember(chatRoomSeq, empNo);
        return "success";
    }
}
