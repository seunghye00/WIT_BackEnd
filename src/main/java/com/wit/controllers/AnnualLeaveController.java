package com.wit.controllers;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.wit.services.AnnualLeaveService;
import com.wit.commons.AttendanceConfig;
import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

		EmployeeDTO employee = service.employeeInfo(empNo);
		model.addAttribute("employee", employee);

		// 연간 휴가 보유 현황을 가져옴
		AnnualLeaveDTO annualLeave = service.getAnnualLeaveByEmpNo(empNo);
		model.addAttribute("annualLeave", annualLeave);

		// 연간 휴가 내역의 총 레코드 수를 가져옴
		int recordTotalCount = service.annualLeaveRecordCount(empNo);

		// 페이징 처리 로직
		int recordCountPerPage = AttendanceConfig.recordCountPerPage;
		int pageTotalCount = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);

		if (cpage > pageTotalCount) {
			return "redirect:/annualLeave/attendanceVacation?cpage=" + pageTotalCount;
		}

		int startNavi = 1;
		int endNavi = pageTotalCount;

		boolean needPrev = cpage > 1;
		boolean needNext = cpage < pageTotalCount;

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

		String empNo = (String) session.getAttribute("loginID");

		EmployeeDTO employee = service.employeeInfo(empNo);
		model.addAttribute("employee", employee);

		// 부서 리스트 가져오기
		List<DeptDTO> departments = service.getDepartments();
		model.addAttribute("departments", departments);

		// 부서별 연간 휴가 내역 조회 (페이징 및 검색 적용)
		int recordTotalCount = service.annualLeaveRecordCountByDept(deptTitle, searchTxt);
		int recordCountPerPage = AttendanceConfig.recordCountPerPage;
		int pageTotalCount = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);

		if (cpage > pageTotalCount) {
			try {
				String encodedDeptTitle = URLEncoder.encode(deptTitle, "UTF-8");
				String encodedSearchTxt = searchTxt != null ? URLEncoder.encode(searchTxt, "UTF-8") : "";
				return "redirect:/annualLeave/attendanceDeptVacation?deptTitle=" + encodedDeptTitle + "&searchTxt="
						+ encodedSearchTxt + "&cpage=" + pageTotalCount;
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}

		int startNavi = 1;
		int endNavi = pageTotalCount;

		boolean needPrev = cpage > 1;
		boolean needNext = cpage < pageTotalCount;

		model.addAttribute("cpage", cpage);
		model.addAttribute("startNavi", startNavi);
		model.addAttribute("endNavi", endNavi);
		model.addAttribute("needPrev", needPrev);
		model.addAttribute("needNext", needNext);

		// 부서별 연간 휴가 내역 조회 (페이징 및 검색 적용)
		List<Map<String, Object>> leaveRequests = service.selectAnnualLeaveRequestsByDept(deptTitle, searchTxt, cpage);

		model.addAttribute("deptTitle", deptTitle);
		model.addAttribute("searchTxt", searchTxt);
		model.addAttribute("leaveRequests", leaveRequests);

		return "Admin/Attendance/attendanceDeptVacation";
	}

}
