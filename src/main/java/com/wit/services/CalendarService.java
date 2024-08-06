package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CalendarDAO;
import com.wit.dto.CalendarDTO;

@Service
public class CalendarService {
	
	@Autowired
	private CalendarDAO dao;
	
	
	
	// 캘린더 목록 출력
	public List<CalendarDTO> calendarList(){
		return dao.calendarList();
	}
	
	// 캘린더 추가
	public int insertCalendar(CalendarDTO dto) {
		return dao.insertCalendar(dto);
	}
	
	// 캘린더 삭제
	public int deleteCalendar(int calendarSeq) {
		return dao.deleteCalendar(calendarSeq);
	}
	
	
	
}
