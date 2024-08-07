package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.DeptDAO;
import com.wit.dto.DeptDTO;

@Service
public class DeptService {

	@Autowired
	private DeptDAO dao;
	
	// 부서 목록을 넘겨주기 위한 메서드
	public List<DeptDTO> getList() {
		return dao.getList();
	}

}
