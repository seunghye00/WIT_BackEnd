package com.wit.controllers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
import com.wit.dto.DocuInfoListDTO;
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

		String empNo = (String) session.getAttribute("loginID");
		// 임시 데이터
		empNo = "2024-0001";

		// 결재 진행 중인 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("currentDocuList", serv.selectByStatus("진행중", empNo));
		// 결재 완료된 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("doneDocuList", serv.selectByStatus("완료", empNo));
		// 전자 결재 메인 화면으로 이동
		return "eApproval/home";
	}

	// 브라우저에서 선택한 type에 따라 결재하기 페이지로 이동 시 해당 페이지에서 초기에 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("apprList")
	public String apprList(String type, Model model) throws Exception {

		String empNo = (String) session.getAttribute("loginID");
		// 임시 데이터
		empNo = "2024-0001";

		// 문서 정보를 저장할 변수 생성 후 type에 따라 해당하는 데이터를 변수에 저장
		List<DocuInfoListDTO> list = null;
		switch (type) {
		case "todo":
			list = serv.selectListByType(empNo, "결재 대기");
			break;
		case "upcoming":
			list = serv.selectListByType(empNo, "결재 예정");
			break;
		default:
			// 추후 에러 페이지로 변경
			return "redirect:/eApproval/home"; 	
		}

		// 작성자와 마지막 결재자의 사번 정보로 이름을 조회해서 dto에 저장 후 model 객체로 전달
		for (DocuInfoListDTO dto : list) {
			dto.setWriter(eServ.getName(dto.getEmp_no()));
			dto.setLast_appr_name(eServ.getName(dto.getLast_appr()));
		}
		model.addAttribute("docuList", list);

		// 해당 문서함 화면으로 이동
		return "eApproval/list/" + type + "List";
	}

	// 브라우저에서 선택한 type에 따라 개인 문서함 페이지로 이동 시 해당 페이지에서 초기에 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("privateList")
	public String privateList(String type, Model model) throws Exception {

		String empNo = (String) session.getAttribute("loginID");
		// 임시 데이터
		empNo = "2024-0001";

		// 문서 정보를 저장할 변수 생성 후 type에 따라 해당하는 데이터를 변수에 저장 후 model 객체로 전달
		List<DocuInfoListDTO> list = null;
		switch (type) {
		case "write":
			list = serv.selectWriteList(empNo);
			// 마지막 결재자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setLast_appr_name(eServ.getName(dto.getLast_appr()));
			}
			model.addAttribute("docuList", list);
			break;
		case "save":
			model.addAttribute("docuList", serv.selecSavetList(empNo));
			break;
		case "approved":
			model.addAttribute("docuList", serv.selectApprovedList(empNo));
			break;
		case "return":
			model.addAttribute("docuList", serv.selectReturnList(empNo));
			break;
		case "view":
			model.addAttribute("docuList", serv.selectViewList(empNo));
			break;
		default:
			// 추후 에러 페이지로 변경
			return "redirect:/eApproval/home"; 
		}

		// 해당 문서함 화면으로 이동
		return "eApproval/list/" + type + "List";
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

		String empNo = (String) session.getAttribute("loginID");
		// 임시 데이터
		empNo = "2024-0007";

		// 작성할 문서에 대한 임시 데이터 입력 후 해당 문서의 SEQ를 받아와서 변수에 저장
		int docuSeq = serv.insert(empNo, docuCode);

		// 현재 날짜를 객체로 생성 후 문자열로 변환
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formattedDate = today.format(formatter);

		// 클라이언트에서 사용할 데이터를 model 객체에 담아서 전달
		model.addAttribute("today", formattedDate);
		model.addAttribute("empInfo", eServ.getNameNDept(empNo));
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
			return "eApproval/writeProp";
		case "M2":
			return "eApproval/writeLeave";
		case "M3":
			return "eApproval/writeLateness";
		default:
			// 추후 에러 페이지로 변경
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
