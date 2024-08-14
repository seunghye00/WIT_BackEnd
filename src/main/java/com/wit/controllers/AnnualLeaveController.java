package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.EmployeeDTO;
import com.wit.services.AnnualLeaveService;

@Controller
@RequestMapping("/annualLeave")
public class AnnualLeaveController {

	@Autowired
	private AnnualLeaveService service;

	@Autowired
	private HttpSession session;

	// 휴가관리 페이지로 이동
	@RequestMapping("/attendance_vacation")
	public String attendance_vacation(Model model) {
		String empNo = (String) session.getAttribute("loginID");

		EmployeeDTO employee = service.employeeInfo(empNo);

		model.addAttribute("employee", employee);

		return "Attendance/attendanceVacation";
	}
}
