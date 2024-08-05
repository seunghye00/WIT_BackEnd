package com.wit.controllers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.DocuListDTO;
import com.wit.services.EApprovalService;
import com.wit.services.EmployeeService;

@Controller
@RequestMapping("/eApproval/")
public class EAppprovalController {

	@Autowired
	private EApprovalService serv;
	
	@Autowired
	private EmployeeService eServ;

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

	// ajax로 문서 양식 리스트를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "getDocuList", produces = "application/json;charset=utf8")
	public List<DocuListDTO> getDocuList() throws Exception {
		List<DocuListDTO> list = serv.getDocuList();
		return list;
	}
	
	// 전자 결재 작성페이지로 이동 시 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping(value = "writeProc", method = RequestMethod.POST)
	public String writeProc(String docuCode, @RequestParam("apprList") String[] apprList, @RequestParam(value = "refeList", required = false) String[] refeList, Model model) throws Exception {

		String emp_no = (String) session.getAttribute("loginID");
		// 임시 데이터
		emp_no = "2024-0007";

		LocalDate today = LocalDate.now(); // 현재 날짜를 얻습니다.
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); // 원하는 형식으로 포맷터를 정의합니다.
        String formattedDate = today.format(formatter); // 현재 날짜를 포맷팅합니다.
		
        model.addAttribute("today", formattedDate);
		model.addAttribute("empInfo", eServ.getNameNDept(emp_no));
		
		Map<String, String> apprInfoList = new HashMap<>();
		for(String str : apprList) {
			apprInfoList.put(str.split(" ")[0], str.split(" ")[1]);
		}
		model.addAttribute("apprList", apprInfoList);
		
		if (refeList != null) {
			model.addAttribute("refeList", refeList);	
		}
		
		// 전자 결재 작성 화면으로 이동
		switch(docuCode) {
			case "M1":
				return "eApproval/write_prop";
			case "M2":
				System.out.println("휴가 신청");
				return "eApproval/write_leave";
			case "M3":
				System.out.println("지각 사유");
				return "eApproval/write_lateness";
			default:
				return "redirect:eApproval/home";
		}
	}
	
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
