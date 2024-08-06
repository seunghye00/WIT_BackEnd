package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.DeptDTO;

@Repository
public class DeptDAO {

	@Autowired
	private SqlSession mybatis;
	
	// 부서 목록을 받아오기 위한 메서드
	public List<DeptDTO> getList() {
		return mybatis.selectList("dept.selectAll");
	}

}
