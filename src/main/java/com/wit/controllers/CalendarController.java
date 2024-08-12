package com.wit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.DepartmentCalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.PersonalCalendarDTO;
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
		List<PersonalCalendarDTO> plist = service.perCalendarList(empNo);
		List<DepartmentCalendarDTO> dlist = service.depCalendarList(empNo);
		EmployeeDTO employee = service.employeeInfo(empNo);

		model.addAttribute("plist", plist);
		model.addAttribute("dlist", dlist);
		model.addAttribute("employee", employee);
		return "/Calendar/calendar";
	}

	// 개인 캘린더 추가
	@RequestMapping("/insertPerCalendar")
	public String insertPerCalendar(PersonalCalendarDTO dto) {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		service.insertPerCalendar(dto);
		return "redirect:/calendar/calendar";
	}

	// 개인 캘린더 삭제
	@RequestMapping("/deletePerCalendar")
	public String deletePerCalendar(String calendarSeq) {
		service.deletePerCalendar(Integer.parseInt(calendarSeq));
		return "redirect:/calendar/calendar";
	}

	// 부서 캘린더 추가
	@RequestMapping("/insertDepCalendar")
	public String insertDepCalendar(DepartmentCalendarDTO dto) {
		service.insertDepCalendar(dto);
		return "redirect:/calendar/calendar";
	}

	// 부서 캘린더 삭제
	@RequestMapping("/deleteDepCalendar")
	public String deleteDepCalendar(String calendarSeq) {
		service.deleteDepCalendar(Integer.parseInt(calendarSeq));
		return "redirect:/calendar/calendar";
	}
}
