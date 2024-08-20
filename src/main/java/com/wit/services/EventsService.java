package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.EventsDAO;
import com.wit.dto.EventsDTO;

@Service
public class EventsService {

	@Autowired
	private EventsDAO dao;

	// 이벤트 생성
	public int saveEvent(EventsDTO dto) {
		return dao.saveEvent(dto);
	}
		
	// 이벤트 출력
	public List<EventsDTO> getEventsByCalendar(List<Integer> calendarSeq){
	    return dao.getEventsByCalendar(calendarSeq);
	}
	
	// 이벤트 수정
	public int updateBySeq(EventsDTO dto) {
		return dao.updateBySeq(dto);
	}
	
	// 이벤트 삭제
	public int delete(int eventSeq) {
		return dao.delete(eventSeq);
	}
}
