package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.RecentDocuListDTO;
import com.wit.services.EApprovalService;

@Controller
@RequestMapping("/eApproval")
public class EAppprovalController {

	@Autowired
	private EApprovalService serv;
	
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/home")
	public String home(Model model) {
		
		String emp_no = (String)session.getAttribute("loginID");
		// 임시 데이터 
		emp_no = "2024-0001";
		
		// 결재 진행 중인 문서 목록 최신순으로 5개만 받아와서 JSP로 전달  
		model.addAttribute("currentDocuList", serv.selectByStatus("진행중", emp_no));
		// 결재 완료된 문서 목록 최신순으로 5개만 받아와서 JSP로 전달  
		model.addAttribute("doneDocuList", serv.selectByStatus("완료", emp_no));
		// 전자 결재 메인 화면으로 이동
		return "eApproval/home";
	}
}
