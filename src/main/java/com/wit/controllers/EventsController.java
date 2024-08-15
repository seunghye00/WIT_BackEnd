package com.wit.controllers;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.EventsDTO;
import com.wit.services.EventsService;

@Controller
@RequestMapping("/events")
public class EventsController {

	@Autowired
	private EventsService service;

	@Autowired
	private HttpSession session;
		
	// 이벤트 저장
	@RequestMapping("/save_event")
	public String saveEvent(EventsDTO dto, @RequestParam("start_at") long startDate, @RequestParam("end_at") long endDate) {
		// 임시 데이터 => 추후 수정 !!!!
		String emp_no = (String)session.getAttribute("loginID");
		dto.setEmp_no(emp_no);
				
		// 밀리초 단위의 타임스탬프를 Timestamp 객체로 변환
		dto.setStart_date(new Timestamp(startDate));
		dto.setEnd_date(new Timestamp(endDate));
		int result = service.saveEvent(dto);
		
		if (result == 1) {
			return "redirect:/calendar/calendar";
		} else {
			return "redirect:/calendar/calendar";
		}
	}
	
	// 이벤트 조회
	@ResponseBody
	@GetMapping("/all_event")
	public List<EventsDTO> getEventsByCalendar(@RequestParam(value = "calendars[]", required = false) List<Integer> calendars){
	    if(calendars == null || calendars.isEmpty()) {
	        return new ArrayList<>();
	    }
	    return service.getEventsByCalendar(calendars);
	}
	
	// 이벤트 수정
	@RequestMapping("/editEvent")
	public String editEvent(EventsDTO dto, @RequestParam("editStartAt") long eventStartDate, @RequestParam("editEndAt") long eventEndDate) throws Exception{
		dto.setStart_date(new Timestamp(eventStartDate));
		System.out.println(eventStartDate);
		dto.setEnd_date(new Timestamp(eventEndDate));
		System.out.println(dto.getCalendar_seq());
		System.out.println(dto.getLocation());
		service.updateBySeq(dto);
		return "redirect:/calendar/calendar";
	}
		
	// 이벤트 삭제
	@RequestMapping("/del_event")
	public String delete(String eventSeq)throws Exception{
		service.delete(Integer.parseInt(eventSeq));
		return "redirect:/calendar/calendar";
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
