package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.EventsDTO;

@Repository
public class EventsDAO {
	
	
	@Autowired
    private SqlSession mybatis;
	
	// 등록
	public int saveEvent(EventsDTO dto) {
		return mybatis.insert("events.insert", dto);
	}
	
	// 조회
	public List<EventsDTO> selectList(){
		return mybatis.selectList("events.select");
	}
	
	// 수정
	public int updateBySeq(EventsDTO dto) {
		return mybatis.update("events.updateBySeq", dto);
	}
		
	// 삭제
	public int delete(int eventSeq) {
		return mybatis.delete("events.delete", eventSeq);
	}
	
}
