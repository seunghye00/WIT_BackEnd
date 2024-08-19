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
import com.wit.dto.LeaveRequestDTO;

import java.util.List;

@Controller
@RequestMapping("/annualLeave")
public class AnnualLeaveController {

    @Autowired
    private AnnualLeaveService service;

    @Autowired
    private HttpSession session;

    @RequestMapping("/attendanceVacation")
    public String attendanceVacation(Model model, @RequestParam(defaultValue = "1") int cpage) {

        String empNo = (String) session.getAttribute("loginID");
        
        // 연간 휴가 보유 현황을 가져옴
        AnnualLeaveDTO annualLeave = service.getAnnualLeaveByEmpNo(empNo);
        model.addAttribute("annualLeave", annualLeave);

        // 연간 휴가 내역의 총 레코드 수를 가져옴
        int recordTotalCount = service.annualLeaveRecordCount(empNo);

        // 페이징 처리 로직
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

        // 연간 휴가 내역 조회 (페이징 적용)
        List<LeaveRequestDTO> leaveRequests = service.selectAnnualLeaveRequests(empNo, cpage);
        model.addAttribute("leaveRequests", leaveRequests);

        return "Attendance/attendanceVacation";
    }
    
    // 부서별 휴가현황 (관리자)
    @RequestMapping("/attendanceDeptVacation")
    public String attendance_vaction() {
    	return "Admin/Attendance/attendanceDeptVacation";
    }
}
