package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class ChatRoomDAO {
	@Autowired
	private SqlSession mybatis;
	// 회원가입
//	public int createRoom(String emp_no) {
//		return mybatis.insert("chatRoom.createRoom", emp_no);
//	}
}
