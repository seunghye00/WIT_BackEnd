package com.wit.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.RoleDTO;
import com.wit.services.RoleService;

@Controller
@RequestMapping("/role/")
public class RoleController {

	@Autowired
	private RoleService serv;
	
	// ajax로 부서 리스트를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "getList", produces = "application/json;charset=utf8")
	public List<RoleDTO> getList() throws Exception {
		return serv.getList();
	}
}