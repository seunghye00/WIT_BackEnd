package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.NoticeDTO;

@Repository
public class NoticeDAO {
	@Autowired
	private SqlSession mybatis;
	
	public List<NoticeDTO> noticeList() throws Exception{
		return mybatis.selectList("notice.noticeList");
	}
}
