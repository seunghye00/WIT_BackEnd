package com.wit.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.services.ChatRoomService;

@Controller
@RequestMapping("/chatroom/")
public class ChatRoomController {
    @Autowired
    private ChatRoomService serv;
    
    @Autowired
    private HttpSession session;
    
    // 개인 채팅방 생성
    @RequestMapping("create")
    @ResponseBody
    public String createPrivateChat(String emp_no1, String chat_room_name) {
    	String emp_no2 = (String) session.getAttribute("loginID");
    	String result = serv.createPrivateChat(emp_no1, emp_no2, chat_room_name);
    	if(result.equals("success")) {
    		return "success";
    	}
    	return "false";
    }

    // 그룹 채팅방 생성
    @RequestMapping("createGroup")
    @ResponseBody
    public String createGroupChat(String chatRoomName, @RequestParam("empNos") List<String> empNos) {
    	String emp_no = (String) session.getAttribute("loginID");
    	serv.createGroupChat(chatRoomName, empNos , emp_no);
        return "success";
    }
    
    // 채팅방 목록 조회
    @RequestMapping("myChatRooms")
    @ResponseBody
    public List<Map<String, Object>> getMyChatRooms() {
    	String loginUserId = (String) session.getAttribute("loginID");
    	
        return serv.getChatRoomsByUserId(loginUserId);
    }
    
    // 채팅방 목록 상세
    @RequestMapping("details")
    @ResponseBody
    public List<Map<String, Object>> getDetailChatRooms(int chat_room_seq) {
    	return serv.getDetailChatRooms(chat_room_seq);
    }
}
