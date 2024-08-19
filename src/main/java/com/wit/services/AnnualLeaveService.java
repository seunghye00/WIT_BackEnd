package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
    public void updateAnnualLeave(String empNo, float useNum) {
		dao.updateByAnnualLeave(empNo, useNum);
	}
	
	// 연차 사용 정보 기록
	public void insertAnnualLeaveLog(String empNo, int docuSeq) {
		dao.insertAnnualLeaveLog(empNo, docuSeq);
	}

	// 휴가 승인 처리 (연차 차감 및 로그 기록)
	@Transactional
	public void processLeaveApproval(LeaveRequestDTO leaveRequest) {
		int documentSeq = leaveRequest.getDocument_seq();

		// document_seq를 통해 emp_no를 조회
		String empNo = dao.getEmpNoByDocumentSeq(documentSeq);

		int daysUsed = Math.round(leaveRequest.getRequest_leave_days());

		// 연차 정보 가져오기
		AnnualLeaveDTO annualLeave = dao.getAnnualLeaveByEmpNo(empNo);

		if (annualLeave != null) {
			// 사용한 연차 차감
			int updatedUseNum = annualLeave.getUse_num() + daysUsed;
			dao.updateAnnualLeaveUsage(empNo, updatedUseNum);

			// 연차 로그 기록
			dao.insertAnnualLeaveLog(empNo, annualLeave.getAnnual_leave_seq(), leaveRequest.getDocument_seq());
		}
	}
}
