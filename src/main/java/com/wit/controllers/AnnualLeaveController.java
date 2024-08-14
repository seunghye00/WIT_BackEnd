package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;
import com.wit.services.AnnualLeaveService;

import java.util.List;

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

        // 직원의 연차 정보 조회
        AnnualLeaveDTO annualLeave = service.getAnnualLeaveByEmpNo(empNo);
        
        // 상태가 완료된 직원의 휴가 신청 내역 조회
        List<LeaveRequestDTO> leaveRequests = service.getApprovedLeaveRequestsByEmpNo(empNo);

        model.addAttribute("employee", employee);
        model.addAttribute("annualLeave", annualLeave);
        model.addAttribute("leaveRequests", leaveRequests);

        return "Attendance/attendanceVacation";
    }
}
