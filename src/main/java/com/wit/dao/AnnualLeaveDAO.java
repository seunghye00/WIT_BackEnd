package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;

import java.util.List;

@Repository
public class AnnualLeaveDAO {

	@Autowired
	private SqlSession mybatis;

	// 직원의 연차 정보를 조회
	public AnnualLeaveDTO getAnnualLeaveByEmpNo(String empNo) {
		AnnualLeaveDTO result = mybatis.selectOne("annualLeave.selectAnnualLeaveByEmpNo", empNo);
		System.out.println("DAO : AnnualLeaveDTO: " + result);
		return result;
	}

	// 연차 데이터가 없을 경우 초기화하는 메서드
	public void insertOrUpdateAnnualLeave(String empNo) {
		mybatis.insert("annualLeave.insertOrUpdateAnnualLeave", empNo);
	}

	// 상태가 완료된 직원의 휴가 신청 내역을 조회
	public List<LeaveRequestDTO> getApprovedLeaveRequestsByEmpNo(String empNo) {
		List<LeaveRequestDTO> result = mybatis.selectList("annualLeave.selectApprovedLeaveRequestsByEmpNo", empNo);
		System.out.println("DAO : LeaveRequestDTO List: " + result);
		return result;
	}

	// 직원 정보 조회
	public EmployeeDTO employeeInfo(String empNo) {
		return mybatis.selectOne("annualLeave.employeeInfo", empNo);
	}

}
