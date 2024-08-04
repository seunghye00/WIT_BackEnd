package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.DocuListDTO;
import com.wit.dto.RecentDocuListDTO;

@Repository
public class EApprovalDAO {
	
	@Autowired
	private SqlSession mybatis;

	// 문서 상태에 따라 해당 사원이 작성한 문서 목록을 5개까지 받아오기 위한 메서드
	public List<RecentDocuListDTO> selectByStatus(String status, String emp_no) {
		// 두 개의 변수( 문서 상태 & 사번 )를 넘겨주기 위해 HashMap 생성
		Map<String, String> params = new HashMap<>();
		params.put("status", status);
		params.put("emp_no", emp_no);
		return mybatis.selectList("eApproval.selectByStatus", params);
	}

	// 문서 양식 목록을 받아오기 위한 메서드
	public List<DocuListDTO> getDocuList() {
		return mybatis.selectList("eApproval.getDocuList");
	}
	

}
