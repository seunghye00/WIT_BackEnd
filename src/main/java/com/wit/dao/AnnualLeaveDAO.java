package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;

@Repository
public class AnnualLeaveDAO {

    @Autowired
    private SqlSession mybatis;

    // 직원의 연차 정보를 조회
    public AnnualLeaveDTO getAnnualLeaveByEmpNo(String empNo) {
        return mybatis.selectOne("annualLeave.selectAnnualLeaveByEmpNo", empNo);
    }

    // 연차 데이터 삽입 또는 업데이트 (MERGE INTO 사용)
    public void insertOrUpdateAnnualLeave(String empNo) {
        mybatis.insert("annualLeave.insertOrUpdateAnnualLeave", empNo);
    }

    // 연차 데이터 업데이트 (사용량 증가)
    public void updateAnnualLeaveUsage(String empNo, int useNum) {
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("useNum", useNum);
        mybatis.update("annualLeave.updateAnnualLeaveUsage", params);
    }

    // 상태가 완료된 직원의 휴가 신청 내역을 조회
    public List<LeaveRequestDTO> selectApprovedLeave(String empNo) {
        return mybatis.selectList("annualLeave.selectApprovedLeave", empNo);
    }

    // 직원 정보 조회
    public EmployeeDTO employeeInfo(String empNo) {
        return mybatis.selectOne("annualLeave.employeeInfo", empNo);
    }

    // document_seq로 emp_no를 조회하는 메서드 추가
    public String getEmpNoByDocumentSeq(int documentSeq) {
        return mybatis.selectOne("annualLeave.selectEmpNoByDocumentSeq", documentSeq);
    }
    
	// 해당 직원의 남은 연차 갯수 조회
	public int getRemainingLeavesByEmpNo(String empNo) {
		return mybatis.selectOne("annualLeave.getRemainingLeaves", empNo);
	}
	
	// 해당 직원의 연차 정보 업데이트
	public void updateByAnnualLeave(String empNo, float useNum) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("useNum", useNum);
		mybatis.update("annualLeave.updateByAnnualLeave", params);
	}
	
	// 연차 사용 정보 기록
	public void insertAnnualLeaveLog(String empNo, int docuSeq) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuSeq", docuSeq);
		mybatis.insert("annualLeave.insertAnnualLeaveLog", params);
	}
}
