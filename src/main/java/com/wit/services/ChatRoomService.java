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
        // 채팅방이 이미 존재하는지 확인
        int chatRoomCount = dao.isPrivateChatRoomExists(emp_no1, empNo2);
        
        if (chatRoomCount > 0) {
            return "chat_room_exists";  // 이미 채팅방이 존재하면, 별도의 처리로 넘어갈 수 있습니다.
        }
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
    
    // 채팅방 상세 조회
    @Transactional
    public Map<String, Object> getDetailChatRooms(int chatRoomSeq, String empNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("empNo", empNo);

        // 채팅방 이름 조회
        List<Map<String, Object>> roomNameResult = dao.getChatRoomName(params);

        // 채팅방 멤버 조회
        List<Map<String, Object>> membersResult = dao.getChatRoomMembers(params);

        Map<String, Object> result = new HashMap<>();
        if (!roomNameResult.isEmpty()) {
            result.put("chatRoomName", roomNameResult.get(0).get("chat_room_name"));
        }
        result.put("chatName", roomNameResult);
        result.put("members", membersResult);
        return result;
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
    	// 채팅방 멤버 삭제
        dao.deleteChatRoomMember(chatRoomSeq, empNo);

        // 채팅방에 남아 있는 멤버 수 확인
        int memberCount = dao.getChatRoomMemberCount(chatRoomSeq);
        if (memberCount <= 1) {
            // 채팅방에 남은 멤버가 1명 이하인 경우, 채팅방과 모든 멤버 삭제
            // 남아 있는 멤버가 있는지 확인하고 있으면 삭제
            if (memberCount == 1) {
                dao.deleteChatRoomMember(chatRoomSeq, dao.getLastRemainingMember(chatRoomSeq));
            }
            dao.deleteChatRoom(chatRoomSeq);
            return "success";
        }

        return "success";
    }
}
