package com.wit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.CalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.services.CalendarService;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

	@Autowired
	private CalendarService service;

	@Autowired
	private HttpSession session;

	// 캘린더 이동
	@RequestMapping("/calendar")
	public String calendar(Model model) {
		String empNo = (String) session.getAttribute("loginID");
		List<CalendarDTO> list = service.calendarList();
		
		EmployeeDTO employee = service.employeeInfo(empNo);
		
		model.addAttribute("list", list);
		model.addAttribute("employee", employee);
		return "/Calendar/calendar";
	}

	// 캘린더 추가
	@RequestMapping("/insertCalendar")
	public String insertCalendar(CalendarDTO dto) {
		// 임시 데이터 => 추후 수정 !!!!
		String emp_no = "2024-0101";
		dto.setEmp_no(emp_no);
		String dept_code = "B";
		dto.setDept_code(dept_code);
		String calendar_code = "M";
		dto.setCalendar_code(calendar_code);
		System.out.println(dto.getCalendar_name());

		service.insertCalendar(dto);
		return "redirect:/calendar/calendar";
	}

	// 캘린더 삭제
	@RequestMapping("/deleteCalendar")
	public String deleteCalendar(String calendarSeq) {
		System.out.println(calendarSeq);
		service.deleteCalendar(Integer.parseInt(calendarSeq));
		return "redirect:/calendar/calendar";
	}
}
