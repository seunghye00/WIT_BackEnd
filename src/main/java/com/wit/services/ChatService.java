package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.dao.ChatDAO;
import com.wit.dto.ChatDTO;

@Service
public class ChatService {
	@Autowired
	private ChatDAO dao;
	
	@Autowired
    private UserService userv;
	
    @Transactional
    public int insert(String chatRoomSeq, String name, String message) throws Exception {
    	String sender = userv.getUserNameByLoginID(name);
        return dao.insertChat(new ChatDTO(0, Integer.parseInt(chatRoomSeq), name, sender, message, null));
    }
    
    @Transactional
    public List<ChatDTO> chatListByRoom(String chat_room_seq) throws Exception {
        return dao.chatListByRoom(Integer.parseInt(chat_room_seq));
    }
    
    @Transactional
    public String getUserNameByLoginID(String loginID) {
        return userv.getUserNameByLoginID(loginID);
    }
}
