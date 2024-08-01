package com.wit.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.services.AttendanceService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

	@Autowired
	private AttendanceService service;

	@Autowired
	private HttpSession session;

	// 출근시간
	@RequestMapping(value = "/start", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String startAttendance() {
		String empNo = (String) session.getAttribute("loginID");
		try {
			service.startAtd(empNo);
			return "출근 처리 완료";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	// 퇴근시간
	@RequestMapping(value = "/end", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String endAttendance() {
		String empNo = (String) session.getAttribute("loginID");
		try {
			service.endAtd(empNo);
			return "퇴근 처리 완료";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	// 근태관리 이동
	@RequestMapping("/attendance")
	public String attendance(Model model) {
		// 세션에서 로그인 ID를 가져옵니다.
		String empNo = (String) session.getAttribute("loginID");

		// 월간 근태현황과 근무시간을 조회하여 모델에 추가합니다.
		Map<String, Integer> monthlyStatus = service.getMonthlyStatus(empNo);
		Map<String, Object> monthlyWorkHours = service.getMonthlyWorkHours(empNo);
		List<Map<String, Object>> weeklyStatus = service.getWeeklyStatus(empNo);

		model.addAttribute("monthlyStatus", monthlyStatus);
		model.addAttribute("monthlyWorkHours", monthlyWorkHours);
		model.addAttribute("weeklyStatus", weeklyStatus);
		System.out.println("컨트롤러:" + weeklyStatus);

		return "Attendance/attendance";
	}

	// 월간 근태현황 이동
	@RequestMapping("/attendance_month")
	public String attendanceMonth(Model model) {
		String empNo = (String) session.getAttribute("loginID");
		
		// 현재 월을 가져옵니다. 예: "2024-08"
		String month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
		
		List<Map<String, Object>> monthlyWorkStatus = service.getMonthlyWorkStatus(empNo, month);
		model.addAttribute("monthlyWorkStatus", monthlyWorkStatus);
		return "Attendance/attendanceMonth";
	}

	// 휴가관리 이동
	@RequestMapping("/attendance_vacation")
	public String attendance_vacation() {
		return "Attendance/attendanceVacation";
	}
}
