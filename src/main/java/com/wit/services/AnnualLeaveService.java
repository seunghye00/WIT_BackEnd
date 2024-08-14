package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.AnnualLeaveDAO;
import com.wit.dto.EmployeeDTO;

@Service
public class AnnualLeaveService {
	
	@Autowired
	private AnnualLeaveDAO dao;
	
	public int getRemainingLeaves(String empNo) {
		return dao.getRemainingLeaves(empNo);
	}
	
	// 직원 정보 조회
	public EmployeeDTO employeeInfo(String emp_no) {
		return dao.employeeInfo(emp_no);
	}
}
