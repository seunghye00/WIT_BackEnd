package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.EmployeeDTO;

@Repository
public class AnnualLeaveDAO {

	@Autowired
	private SqlSession mybatis;

	// 해당 직원의 연차 갯수를 넘겨주기 위한 메서드
	public int getRemainingLeaves(String empNo) {
		mybatis.selectOne("annualLeave.selectRemaingLeaves", empNo);
		// 임시 데이터
		return 15;
	}
	
	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String emp_no) {
		return mybatis.selectOne("attendance.employeeInfo", emp_no);
	}
}