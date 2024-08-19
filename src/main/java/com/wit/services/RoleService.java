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
	
	// 부서 목록을 넘겨주기 위한 메서드
	public List<RoleDTO> getList() {
		return dao.getList();
	}
}
