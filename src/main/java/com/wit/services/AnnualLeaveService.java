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
	public List<LeaveRequestDTO> selectApprovedLeave(String empNo) {
		return dao.selectApprovedLeave(empNo);
	}

    // 직원 정보 조회
    public EmployeeDTO employeeInfo(String empNo) {
        return dao.employeeInfo(empNo);
    }
    
    // 해당 직원의 남은 연차 갯수 조회
    public int getRemainingLeavesByEmpNo(String empNo) {
        return dao.getRemainingLeavesByEmpNo(empNo);
    }

    // 해당 직원의 연차 정보 업데이트
    public void updateAnnualLeave(String empNo, float useNum) {
    	System.out.println("서비스 : " + empNo +  "사용한 휴가 : " + useNum);
		dao.updateByAnnualLeave(empNo, useNum);
	}
	
	// 연차 사용 정보 기록
	public void insertAnnualLeaveLog(String empNo, int docuSeq) {
		System.out.println("서비스 : " + empNo +  " 로그: " + docuSeq);
		dao.insertAnnualLeaveLog(empNo, docuSeq);
	}
}
