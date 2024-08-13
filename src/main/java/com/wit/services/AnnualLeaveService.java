package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.AnnualLeaveDAO;

@Service
public class AnnualLeaveService {
	
	@Autowired
	private AnnualLeaveDAO dao;
	
	public int getRemainingLeaves(String empNo) {
		return dao.getRemainingLeaves(empNo);
	}
}
