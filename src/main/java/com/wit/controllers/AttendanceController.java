package com.wit.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.AttendanceDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.services.AttendanceService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
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

			// 이게 이제 출퇴근 버튼 눌렀을떄 메인 화면에 버튼 클릭 한 시간 나오게 하는거!
			return LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
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

			// 이게 이제 출퇴근 버튼 눌렀을떄 메인 화면에 버튼 클릭 한 시간 나오게 하는거!
			return LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
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
		Map<String, Integer> monthlyStatus = service.monthlyStatus(empNo);
		Map<String, Object> monthlyWorkHours = service.monthlyWorkHours(empNo);
		List<Map<String, Object>> weeklyStatus = service.weeklyStatus(empNo);

		// 직원 정보 가져오기
		EmployeeDTO employee = service.employeeInfo(empNo);

		model.addAttribute("monthlyStatus", monthlyStatus);
		model.addAttribute("monthlyWorkHours", monthlyWorkHours);
		model.addAttribute("weeklyStatus", weeklyStatus);
		model.addAttribute("employee", employee);

		return "Attendance/attendance";
	}

	// 월간 근태현황 이동
	@RequestMapping("/attendance_month")
	public String attendanceMonth(Model model) {
		String empNo = (String) session.getAttribute("loginID");

		// 현재 월을 가져옵니다. 예: "2024-08"
		String month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));

		List<Map<String, Object>> monthlyWorkStatus = service.monthlyWorkStatus(empNo, month);

		// 직원 정보 가져오기
		EmployeeDTO employee = service.employeeInfo(empNo);

		model.addAttribute("monthlyWorkStatus", monthlyWorkStatus);
		model.addAttribute("employee", employee);
		return "Attendance/attendanceMonth";
	}

	// 휴가관리 이동
	@RequestMapping("/attendance_vacation")
	public String attendance_vacation(Model model) {
		String empNo = (String) session.getAttribute("loginID");

		// 직원 정보 가져오기
		EmployeeDTO employee = service.employeeInfo(empNo);

		model.addAttribute("employee", employee);

		return "Attendance/attendanceVacation";
	}

	// 출근 및 퇴근 시간 조회(메인 페이지)
	@RequestMapping(value = "/times", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> getAttendanceTimes() {
		String empNo = (String) session.getAttribute("loginID");
		Map<String, String> times = new HashMap<>();

		// 현재 날짜의 출근 기록 조회
		AttendanceDTO record = service.getTodayAttendance(empNo);

		if (record != null) {
			times.put("startTime", record.getStart_time() != null ? record.getStart_time() : "00:00");
			times.put("endTime", record.getEnd_time() != null ? record.getEnd_time() : "00:00");
		} else {
			times.put("startTime", "00:00");
			times.put("endTime", "00:00");
		}

		return times;
	}
}
