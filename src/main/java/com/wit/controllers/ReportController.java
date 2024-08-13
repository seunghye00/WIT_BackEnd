package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.ReportDTO;
import com.wit.services.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {
	@Autowired
	private HttpSession session;
	
	@Autowired
	private ReportService rserv;
	
	@RequestMapping("insert")
	public String writeProc(ReportDTO dto, String target) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		rserv.insert(dto, target);
		
		return "redirect:/board/detail?board_seq="+dto.getBoard_seq();
	}
}
