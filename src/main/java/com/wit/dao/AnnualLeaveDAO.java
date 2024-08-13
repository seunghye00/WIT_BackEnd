package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}