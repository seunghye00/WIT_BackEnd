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

import com.wit.dto.DocuDTO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.workPropDTO;
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
	public String writeProc(String docuCode, @RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, Model model) throws Exception {

		String emp_no = (String) session.getAttribute("loginID");
		// 임시 데이터
		emp_no = "2024-0007";

		// 작성할 문서에 대한 임시 데이터 입력 후 해당 문서의 SEQ를 받아와서 변수에 저장
		int docuSeq = serv.insert(emp_no, docuCode);

		// 현재 날짜를 객체로 생성 후 문자열로 변환
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formattedDate = today.format(formatter);

		// 클라이언트에서 사용할 데이터를 model 객체에 담아서 전달
		model.addAttribute("today", formattedDate);
		model.addAttribute("empInfo", eServ.getNameNDept(emp_no));
		model.addAttribute("docuSeq", docuSeq);
		model.addAttribute("docuCode", docuCode);
		model.addAttribute("apprList", apprList);

		// 참조 라인이 존재한다면 model 객체를 통해 클라이언트로 전달
		if (refeList != null) {
			model.addAttribute("refeList", refeList);
		}

		// 선택한 문서에 따라 해당 전자 결재 작성 화면으로 이동
		switch (docuCode) {
		case "M1":
			return "eApproval/write_prop";
		case "M2":
			System.out.println("휴가 신청");
			return "eApproval/write_leave";
		case "M3":
			System.out.println("지각 사유");
			return "eApproval/write_lateness";
		default:
			return "redirect:/eApproval/home";
		}
	}

	// 업무 기안 문서 임시 저장 시 해당 데이터를 업데이트하기 위한 메서드
	@RequestMapping(value = "docuProp/save", method = RequestMethod.POST)
	public String saveDocuProp(DocuDTO docuDTO, workPropDTO workPropDTO, @RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList) throws Exception {

		serv.updateBySave(docuDTO.getDocument_seq(), docuDTO.getTitle(), docuDTO.getEmer_yn());
		serv.insertPropDocu(workPropDTO);
		
		for (int i = 0; i < 3; i++) {
			serv.createApprLine(docuDTO.getDocument_seq(), apprList[i], (i + 1));
		}
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(docuDTO.getDocument_seq(), refe);
			}
		}
		return "redirect:/eApproval/home";
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
