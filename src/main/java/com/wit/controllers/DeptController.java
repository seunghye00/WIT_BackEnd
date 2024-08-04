package com.wit.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.DeptDTO;
import com.wit.services.DeptService;

@Controller
@RequestMapping("/dept")
public class DeptController {

	@Autowired
	private DeptService serv;
	
	// ajax로 부서 리스트를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "getList", produces = "text/html;charset=utf8")
	public List<DeptDTO> getList() throws Exception {
		return serv.getList();
	}
}
