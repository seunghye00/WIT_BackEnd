package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.RoleDAO;
import com.wit.dto.RoleDTO;
@Service
public class RoleService {
	@Autowired
	private RoleDAO dao;
	
	// 직급 목록을 넘겨주기 위한 메서드
	public List<RoleDTO> getList() {
		return dao.getList();
	}
	
	// 직급 타이틀 직급 코드로 변경
	public String getRoleCode(String roleTitle) {
		return dao.getRoleCode(roleTitle);
	}
}
