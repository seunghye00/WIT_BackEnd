package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.RoleDTO;

@Repository
public class RoleDAO {
	@Autowired
	private SqlSession mybatis;
	
	// 직급 목록을 받아오기 위한 메서드
	public List<RoleDTO> getList() {
		return mybatis.selectList("role.selectAll");
	}
	
	// 직급 타이틀 직급 코드로 변환
	public String getRoleCode(String roleTitle) {
		return mybatis.selectOne("role.getRoleCode", roleTitle);
	}
}
