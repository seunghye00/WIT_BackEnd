package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.AnnualLeaveDAO;
import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;

import java.util.List;

@Service
public class AnnualLeaveService {

    @Autowired
    private AnnualLeaveDAO dao;

    // 직원의 연차 정보를 가져옴
    public AnnualLeaveDTO getAnnualLeaveByEmpNo(String empNo) {
        return dao.getAnnualLeaveByEmpNo(empNo);
    }

    // 상태가 완료된 직원의 휴가 신청 내역을 반환
    public List<LeaveRequestDTO> getApprovedLeaveRequestsByEmpNo(String empNo) {
        return dao.getApprovedLeaveRequestsByEmpNo(empNo);
    }

    // 직원 정보 조회
    public EmployeeDTO employeeInfo(String empNo) {
        return dao.employeeInfo(empNo);
    }
}
