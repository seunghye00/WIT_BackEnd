package com.wit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.DeptDTO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.RecentDocuListDTO;
import com.wit.services.EApprovalService;

@Controller
@RequestMapping("/eApproval/")
public class EAppprovalController {

	@Autowired
	private EApprovalService serv;

	@Autowired
	private HttpSession session;

	// 전자 결재 메인페이지로 이동 시 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("home")
	public String home(Model model) throws Exception {

		String emp_no = (String) session.getAttribute("loginID");
		// 임시 데이터
		emp_no = "2024-0001";

		// 결재 진행 중인 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("currentDocuList", serv.selectByStatus("진행중", emp_no));
		// 결재 완료된 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("doneDocuList", serv.selectByStatus("완료", emp_no));
		// 전자 결재 메인 화면으로 이동
		return "eApproval/home";
	}

	// ajax로 문서 리스트를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "getDocuList", produces = "text/html;charset=utf8")
	public List<DocuListDTO> getDocuList() throws Exception {
		System.out.println("이동 확인");
		for (DocuListDTO dto : serv.getDocuList()) {
			System.out.println(dto.getDocu_code());
			System.out.println(dto.getName());
		}
		List<DocuListDTO> list = serv.getDocuList();
		return list;
	}
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
