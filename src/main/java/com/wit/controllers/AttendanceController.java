package com.wit.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.EmployeeDTO;
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
	@RequestMapping(value = "/start", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String startAttendance() {
		String empNo = (String) session.getAttribute("loginID");
		try {
			service.startAtd(empNo);

			// 이전 날이 결근인지 확인하고 결근으로 처리
			LocalDate previousDay = LocalDate.now().minusDays(1);
			java.sql.Date previousDate = java.sql.Date.valueOf(previousDay);
			service.markAbsence(empNo, previousDate);
			System.out.println("결근 처리 완료: " + empNo + ", 날짜: " + previousDate);

			return "출근 처리 완료";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	// 퇴근시간
	@RequestMapping(value = "/end", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String endAttendance() {
		String empNo = (String) session.getAttribute("loginID");
		try {
			service.endAtd(empNo);

			// 이전 날이 결근인지 확인하고 결근으로 처리
			LocalDate previousDay = LocalDate.now().minusDays(1);
			java.sql.Date previousDate = java.sql.Date.valueOf(previousDay);
			service.markAbsence(empNo, previousDate);

			System.out.println("결근 처리 완료: " + empNo + ", 날짜: " + previousDate);

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

		// 직원 정보 가져오기
		EmployeeDTO employeeInfo = service.getEmployeeInfo(empNo);
		System.out.println("Employee Info: " + employeeInfo); // 로그 추가

		model.addAttribute("monthlyStatus", monthlyStatus);
		model.addAttribute("monthlyWorkHours", monthlyWorkHours);
		model.addAttribute("weeklyStatus", weeklyStatus);
		model.addAttribute("employeeInfo", employeeInfo); // 직원 정보 모델에 추가

		return "Attendance/attendance";
	}

	// 월간 근태현황 이동
	@RequestMapping("/attendance_month")
	public String attendanceMonth(Model model) {
		String empNo = (String) session.getAttribute("loginID");

		// 현재 월을 가져옵니다. 예: "2024-08"
		String month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));

		List<Map<String, Object>> monthlyWorkStatus = service.getMonthlyWorkStatus(empNo, month);
		
		// 직원 정보 가져오기
		EmployeeDTO employeeInfo = service.getEmployeeInfo(empNo);
		
		model.addAttribute("monthlyWorkStatus", monthlyWorkStatus);
		model.addAttribute("employeeInfo", employeeInfo); // 직원 정보 모델에 추가
		return "Attendance/attendanceMonth";
	}

	// 휴가관리 이동
	@RequestMapping("/attendance_vacation")
	public String attendance_vacation(Model model) {
		String empNo = (String) session.getAttribute("loginID");
		
		// 직원 정보 가져오기
		EmployeeDTO employeeInfo = service.getEmployeeInfo(empNo);
		
		model.addAttribute("employeeInfo", employeeInfo); // 직원 정보 모델에 추가
		
		return "Attendance/attendanceVacation";
	}
}
