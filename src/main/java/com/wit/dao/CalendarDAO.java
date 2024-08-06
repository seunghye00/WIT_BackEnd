package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.CalendarDTO;

@Repository
public class CalendarDAO {

	
	@Autowired
	private SqlSession mybatis;
	
	public List<CalendarDTO>calendarList(){
		return mybatis.selectList("calendar.calendarList");
	}
	
	public int insertCalendar(CalendarDTO dto) {
		return mybatis.insert("calendar.insertCalendar", dto);
	}
	
	public int deleteCalendar(int calendarSeq) {
		return mybatis.insert("calendar.deleteCalendar", calendarSeq);
	}
	
}
