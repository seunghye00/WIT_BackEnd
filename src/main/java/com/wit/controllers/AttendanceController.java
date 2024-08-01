package com.wit.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.services.AttendanceService;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import com.wit.dto.AttendanceDTO;

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

		// 주간 근무현황 조회 (현재 주)
		String startDate = getStartOfWeek();
		String endDate = getEndOfWeek();
		List<AttendanceDTO> weeklyWorkStatus = service.getWeeklyWorkStatus(empNo, startDate, endDate);

		model.addAttribute("monthlyStatus", monthlyStatus);
		model.addAttribute("monthlyWorkHours", monthlyWorkHours);
		model.addAttribute("weeklyWorkStatus", weeklyWorkStatus);
		System.out.println("컨트롤러 : " + weeklyWorkStatus);
		return "Attendance/attendance";
	}

	// 주의 시작 날짜 계산
	private String getStartOfWeek() {
		LocalDate now = LocalDate.now();
		LocalDate startOfWeek = now.with(DayOfWeek.MONDAY);
		return startOfWeek.toString();
	}

	// 주의 종료 날짜 계산
	private String getEndOfWeek() {
		LocalDate now = LocalDate.now();
		LocalDate endOfWeek = now.with(DayOfWeek.SUNDAY);
		return endOfWeek.toString();
	}

	// 월간 근태현황 이동
	@RequestMapping("/attendance_month")
	public String attendance_month() {
		return "Attendance/attendanceMonth";
	}

	// 휴가관리 이동
	@RequestMapping("/attendance_vacation")
	public String attendance_vacation() {
		return "Attendance/attendanceVacation";
	}
}
