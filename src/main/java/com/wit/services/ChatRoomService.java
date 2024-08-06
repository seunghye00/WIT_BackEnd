package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.dao.ChatRoomDAO;
import com.wit.dto.AddressBookDTO;


@Service
public class ChatRoomService {
	@Autowired
	private ChatRoomDAO dao;
	
	// 채팅방 생성
//	@Transactional
//	public void addContact(String emp_no) {
//	    //dao.createRoom(emp_no);
//	}
}
