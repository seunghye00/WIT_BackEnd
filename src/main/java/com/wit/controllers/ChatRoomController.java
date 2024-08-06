package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.services.ChatRoomService;

@Controller
@RequestMapping("/chatroom/")
public class ChatRoomController {
	
	@Autowired
	private ChatRoomService serv;

	@Autowired
	private HttpSession session;
	
	// 채팅방 생성
	@RequestMapping("create")
	@ResponseBody
	public void createRoom(Model model, String emp_no, String emp_name) throws Exception {
//		return serv.createRoom(emp_no, emp_name);
	}
	
	
}
