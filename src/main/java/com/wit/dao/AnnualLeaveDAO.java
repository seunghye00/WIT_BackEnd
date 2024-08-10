package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AnnualLeaveDAO {
	
	@Autowired
	private SqlSession mybatis;

	public int getRemainingLeaves(String empNo) {
		return mybatis.selectOne("annualLeave.selectRemaingLeaves", empNo);
	}
}