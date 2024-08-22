package com.wit.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.wit.services.AnnualLeaveService;
import com.wit.commons.AttendanceConfig;
import com.wit.commons.AttendanceVactionConfig;
import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/annualLeave")
public class AnnualLeaveController {

	@Autowired
	private AnnualLeaveService service;

	@Autowired
	private HttpSession session;

	// 연간 휴가현황 (사용자)
	@RequestMapping("/attendanceVacation")
	public String attendanceVacation(Model model, @RequestParam(defaultValue = "1") int cpage) {

		String empNo = (String) session.getAttribute("loginID");
		
		// 직원 정보 조회
		EmployeeDTO employee = service.employeeInfo(empNo);
		model.addAttribute("employee", employee);

		// 연간 휴가 보유 현황을 가져옴
		AnnualLeaveDTO annualLeave = service.getAnnualLeaveByEmpNo(empNo);
		model.addAttribute("annualLeave", annualLeave);

		// 연간 휴가 내역의 총 레코드 수를 가져옴
		int recordTotalCount = service.annualLeaveRecordCount(empNo);

		// 페이징 처리 로직
		int recordCountPerPage = AttendanceVactionConfig.recordCountPerPage;
		System.out.println("레코드 카운트 펄페이지 : " + recordCountPerPage);
		int naviCountPerPage = AttendanceVactionConfig.naviCountPerPage;
		System.out.println("네비 카운트 펄페이지 : " + naviCountPerPage);

		int pageTotalCount = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);
		System.out.println("페이지 토탈 카운트 : " + pageTotalCount);

		if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = ((cpage - 1) / naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = startNavi + naviCountPerPage - 1;

		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = startNavi > 1;
		boolean needNext = endNavi < pageTotalCount;

		model.addAttribute("cpage", cpage);
		model.addAttribute("startNavi", startNavi);
		model.addAttribute("endNavi", endNavi);
		model.addAttribute("needPrev", needPrev);
		model.addAttribute("needNext", needNext);

		// 연간 휴가 내역 조회 (페이징 적용)
		List<LeaveRequestDTO> leaveRequests = service.selectAnnualLeaveRequests(empNo, cpage);
		model.addAttribute("leaveRequests", leaveRequests);

		return "Attendance/attendanceVacation";
	}

	// 부서별 휴가현황 (관리자)
	@RequestMapping("/attendanceDeptVacation")
	public String attendanceDeptVacation(@RequestParam(value = "deptTitle", defaultValue = "인사부") String deptTitle,
			@RequestParam(value = "searchTxt", required = false) String searchTxt,
			@RequestParam(defaultValue = "1") int cpage, Model model) {

		// 로그인한 직원의 ID를 세션에서 가져오기
		String empNo = (String) session.getAttribute("loginID");

		// 직원 정보 조회
		EmployeeDTO employee = service.employeeInfo(empNo);
		model.addAttribute("employee", employee);

		// 부서 리스트 가져오기
		List<DeptDTO> departments = service.getDepartments();
		model.addAttribute("departments", departments);

		// 부서별 연간 휴가 내역 조회 (페이징 및 검색 적용)
		int recordTotalCount = service.annualLeaveRecordCountByDept(deptTitle, searchTxt);

		int recordCountPerPage = AttendanceConfig.recordCountPerPage;
		System.out.println("레코드 카운트 펄페이지 : " + recordCountPerPage);
		int naviCountPerPage = AttendanceConfig.naviCountPerPage;
		System.out.println("네비 카운트 펄페이지 : " + naviCountPerPage);

		int pageTotalCount = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);
		System.out.println("페이지 토탈 카운트 : " + pageTotalCount);

		if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = ((cpage - 1) / naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = startNavi + naviCountPerPage - 1;

		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = startNavi > 1;
		boolean needNext = endNavi < pageTotalCount;

		model.addAttribute("cpage", cpage);
		model.addAttribute("startNavi", startNavi);
		model.addAttribute("endNavi", endNavi);
		model.addAttribute("needPrev", needPrev);
		model.addAttribute("needNext", needNext);

		// 부서별 연간 휴가 내역 조회 (페이징 및 검색 적용)
		List<Map<String, Object>> leaveRequests = service.selectAnnualLeaveRequestsByDept(deptTitle, searchTxt, cpage);
		System.out.println(leaveRequests);

		model.addAttribute("deptTitle", deptTitle);
		model.addAttribute("searchTxt", searchTxt);
		model.addAttribute("leaveRequests", leaveRequests);

		return "Admin/Attendance/attendanceDeptVacation";

	}
}
