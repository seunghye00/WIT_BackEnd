package com.wit.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wit.commons.BoardConfig;
import com.wit.dto.ApprLineDTO;
import com.wit.dto.DocuDTO;
import com.wit.dto.DocuFilesDTO;
import com.wit.dto.DocuInfoListDTO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.LatenessDTO;
import com.wit.dto.LeaveRequestDTO;
import com.wit.dto.WorkPropDTO;
import com.wit.services.AnnualLeaveService;
import com.wit.services.EApprovalService;
import com.wit.services.EmployeeService;
import com.wit.services.FileService;

@Controller
@RequestMapping("/eApproval/")
public class EApprovalController {

	@Autowired
	private EApprovalService serv;

	@Autowired
	private EmployeeService eServ;

	@Autowired
	private FileService fServ;

	@Autowired
	private AnnualLeaveService aServ;

	@Autowired
	private HttpSession session;

	// 전자 결재 메인페이지로 이동 시 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("home")
	public String home(Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 결재 진행 중인 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("currentDocuList", serv.selectByStatus("진행중", empNo));
		// 결재 완료된 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("doneDocuList", serv.selectByStatus("완료", empNo));
		// 전자 결재 메인 화면으로 이동
		return "eApproval/home";
	}

	// 전자 결재 관리자 메인페이지로 이동 시 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("admin/home")
	public String adminHome(Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 결재 대기 중인 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("toDoList", serv.selectApprList(empNo, "결재 대기"));
		// 결재 예정인 문서 목록 최신순으로 5개만 받아와서 JSP로 전달
		model.addAttribute("upComingList", serv.selectApprList(empNo, "결재 예정"));
		// 전자 결재 메인 화면으로 이동
		return "Admin/eApproval/home";
	}

	// 해당 문서의 상세 정보를 열람하는데 필요한 정보들을 담아서 전달하는 메서드
	@RequestMapping("readDocu")
	public String readDocu(int docuSeq, @RequestParam(required = false) String type,
			@RequestParam(required = false) String readYN, Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 해당 문서의 내용, 기안자 정보, 결재 라인, 문서 열람 목적을 model 객체에 저장
		DocuDTO dto = serv.getDocuInfo(docuSeq);
		model.addAttribute("docuInfo", dto);
		model.addAttribute("writerInfo", eServ.getNameNDept(dto.getEmp_no()));
		model.addAttribute("apprList", serv.getApprLine(docuSeq));
		model.addAttribute("type", type);

		if (type == null) {
			type = "read";
		}
		// 임시 저장 페이지가 아닌 경우에만 해당 게시물에 등록된 파일 목록을 조회 후 존재한다면 model 객체에 저장
		if (!type.equals("saved")) {
			List<DocuFilesDTO> fileList = fServ.getList(docuSeq);
			if (fileList.size() > 0) {
				model.addAttribute("files", fileList);
			}
		}

		// 참조 문서함에서 문서 열람 시 문서 열람 여부와 열람 일시 업데이트 후 참조 라인 정보를 model 객체에 저장
		if (type.equals("read") && readYN != null) {
			serv.updateReadYN(docuSeq, empNo, readYN);
		}
		model.addAttribute("refeList", serv.getRefeLine(docuSeq));

		// 문서 양식에 따라 각 문서의 세부 정보를 받아오는 메서드 호출
		switch (dto.getDocu_code()) {
		case "M1":
			model.addAttribute("docuDetail", serv.getPropDetail(docuSeq));
			// 해당 문서를 열람하려는 목적에 따라 경로 설정
			if (type.equals("read")) {
				return "eApproval/read/readProp";
			} else if (type.equals("saved")) {
				return "eApproval/save/saveProp";
			} else if (type.equals("toAppr")) {
				return "eApproval/appr/apprProp";
			}
		case "M2":
			model.addAttribute("docuDetail", serv.getLeaveDetail(docuSeq));
			// 해당 사원의 잔여 연차 갯수 조회 후 전달
			model.addAttribute("remaingLeaves", aServ.getRemainingLeavesByEmpNo(empNo));
			// 해당 문서를 열람하려는 목적에 따라 경로 설정
			if (type.equals("read")) {
				return "eApproval/read/readLeave";
			} else if (type.equals("saved")) {
				return "eApproval/save/saveLeave";
			} else if (type.equals("toAppr")) {
				return "eApproval/appr/apprLeave";
			}
		case "M3":
			model.addAttribute("docuDetail", serv.getLatenessDetail(docuSeq));
			// 해당 문서를 열람하려는 목적에 따라 경로 설정
			if (type.equals("read")) {
				return "eApproval/read/readLateness";
			} else if (type.equals("saved")) {
				return "eApproval/save/saveLateness";
			} else if (type.equals("toAppr")) {
				return "eApproval/appr/apprLateness";
			}
		default:
			return "redirect:/error";
		}
	}

	// 관리자가 해당 문서의 상세 정보를 열람하는데 필요한 정보들을 담아서 전달하는 메서드
	@RequestMapping("admin/readDocu")
	public String adminReadDocu(int docuSeq, @RequestParam(required = false) String type,
			@RequestParam(required = false) String readYN, Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 해당 문서의 내용, 기안자 정보, 결재 라인, 문서 열람 목적을 model 객체에 저장
		DocuDTO dto = serv.getDocuInfo(docuSeq);
		model.addAttribute("docuInfo", dto);
		model.addAttribute("writerInfo", eServ.getNameNDept(dto.getEmp_no()));
		model.addAttribute("apprList", serv.getApprLine(docuSeq));
		model.addAttribute("type", type);

		if (type == null) {
			type = "read";
		}
		// 참조 문서함에서 문서 열람 시 문서 열람 여부와 열람 일시 업데이트 후 참조 라인 정보를 model 객체에 저장
		if (type.equals("read") && readYN != null) {
			serv.updateReadYN(docuSeq, empNo, readYN);
		}
		model.addAttribute("refeList", serv.getRefeLine(docuSeq));

		// 문서 양식에 따라 각 문서의 세부 정보를 받아오는 메서드 호출
		switch (dto.getDocu_code()) {
		case "M1":
			model.addAttribute("docuDetail", serv.getPropDetail(docuSeq));
			if (type.equals("read")) {
				return "Admin/eApproval/read/readProp";
			} else if (type.equals("toAppr")) {
				return "Admin/eApproval/appr/apprProp";
			}
		case "M2":
			model.addAttribute("docuDetail", serv.getLeaveDetail(docuSeq));
			// 해당 사원의 잔여 연차 갯수 조회 후 전달
			model.addAttribute("remaingLeaves", aServ.getRemainingLeavesByEmpNo(empNo));
			if (type.equals("read")) {
				return "Admin/eApproval/read/readLeave";
			} else if (type.equals("toAppr")) {
				return "Admin/eApproval/appr/apprLeave";
			}
		case "M3":
			model.addAttribute("docuDetail", serv.getLatenessDetail(docuSeq));
			if (type.equals("read")) {
				return "Admin/eApproval/read/readLateness";
			} else if (type.equals("toAppr")) {
				return "Admin/eApproval/appr/apprLateness";
			}
		default:
			return "redirect:/error";
		}
	}

	// 해당 문서를 반려 처리하기 위한 메서드
	@Transactional
	@RequestMapping(value = { "admin/returnDocu", "returnDocu" })
	public String returnDocu(int docuSeq, String comments, HttpServletRequest request) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		List<ApprLineDTO> list = serv.getApprLine(docuSeq);

		// 해당 사원의 결재 순서에 따라 결재 라인 정보 업데이트
		for (int i = 0; i < 3; i++) {
			ApprLineDTO dto = list.get(i);
			if (dto.getEmp_no().equals(empNo)) {
				dto.setComments(comments);
				if (comments == null) {
					dto.setComments("반려로 인해 자동 결재 처리되었습니다.");
				}
				serv.insertComments(dto);
				serv.updateApprLineAll(docuSeq, i + 1, "반려");
				// 문서 상태 업데이트
				serv.updateDocuStatus(docuSeq, "반려");
				break;
			}
		}
		// 현재 요청된 URL & 직급 정보를 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/eApproval/admin/returnDocu") && eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/eApproval/admin/apprList?type=todo&cPage=1";
		} else if (currentUrl.equals("/eApproval/returnDocu") && !eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/eApproval/apprList?type=todo&cPage=1";
		} else {
			return "redirect:/error";
		}
	}

	// 관리자가 해당 문서를 결재 처리하기 위한 메서드
	@Transactional
	@RequestMapping(value = { "admin/apprDocu", "apprDocu" })
	public String adminApprDocu(int docuSeq, String comments, @RequestParam(required = false) String applyLeaves,
			HttpServletRequest request) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");

		// 해당 문서의 결재 라인과 해당 사원의 결재 순서 조회 후 변수에 저장
		int apprOrder = 0;
		for (ApprLineDTO dto : serv.getApprLine(docuSeq)) {
			if (empNo.equals(dto.getEmp_no())) {
				apprOrder = dto.getApproval_order();
				break;
			}
		}
		// 해당 사원의 결재 순서에 따라 결재 라인 정보 업데이트
		switch (apprOrder) {
		case 1:
			serv.updateApprLine(docuSeq, 1, "결재 완료");
			serv.updateApprLine(docuSeq, 2, "결재 대기");
			serv.updateApprLine(docuSeq, 3, "결재 예정");
			break;
		case 2:
			serv.updateApprLine(docuSeq, 2, "결재 완료");
			serv.updateApprLine(docuSeq, 3, "결재 대기");
			break;
		case 3:
			serv.updateApprLine(docuSeq, 3, "결재 완료");
			serv.updateDocuStatus(docuSeq, "완료");
			if (applyLeaves != null) {
				float useNum = Float.parseFloat(applyLeaves);
				aServ.updateAnnualLeave(docuSeq, useNum);
				aServ.insertAnnualLeaveLog(docuSeq);
			}
			break;
		default:
			return "redirect:/error";
		}
		// 현재 요청된 URL & 직급 정보를 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/eApproval/admin/apprDocu") && eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/eApproval/admin/apprList?type=todo&cPage=1";
		} else if (currentUrl.equals("/eApproval/apprDocu") && !eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/eApproval/apprList?type=todo&cPage=1";
		} else {
			return "redirect:/error";
		}
	}

	// 해당 문서를 전결 처리하기 위한 메서드
	@Transactional
	@RequestMapping(value = { "admin/apprAllDocu", "apprAllDocu" })
	public String apprAllDocu(int docuSeq, String comments, @RequestParam(required = false) String applyLeaves,
			HttpServletRequest request) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		List<ApprLineDTO> list = serv.getApprLine(docuSeq);

		// 해당 사원의 결재 순서에 따라 결재 라인 정보 업데이트
		for (int i = 0; i < 3; i++) {
			ApprLineDTO dto = list.get(i);
			if (dto.getEmp_no().equals(empNo)) {
				dto.setComments(comments);
				serv.insertComments(dto);
				serv.updateApprLineAll(docuSeq, i + 1, "전결");
				// 문서 상태 업데이트
				serv.updateDocuStatus(docuSeq, "완료");
				if (applyLeaves != null) {
					float useNum = Float.parseFloat(applyLeaves);
					aServ.updateAnnualLeave(docuSeq, useNum);
					aServ.insertAnnualLeaveLog(docuSeq);
				}
				break;
			}
		}
		// 현재 요청된 URL & 직급 정보를 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/eApproval/admin/apprAllDocu") && eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/eApproval/admin/apprList?type=todo&cPage=1";
		} else if (currentUrl.equals("/eApproval/apprAllDocu") && !eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/eApproval/apprList?type=todo&cPage=1";
		} else {
			return "redirect:/error";
		}
	}

	// 임시 저장 페이지에서 다시 임시 저장을 하거나 결재 요청을 했을 시 처리하기 위한 메서드
	@Transactional
	@RequestMapping(value = { "reSaveDocu", "update" })
	public String reSaveDocu(DocuDTO dto, WorkPropDTO wDTO, LatenessDTO lnDTO, LeaveRequestDTO lrDTO,
			HttpServletRequest request) throws Exception {

		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();
		String type = null;

		// 요청된 URL에 따라 문서 상태 변경 및 이동 경로 설정
		if (currentUrl.equals("/eApproval/reSaveDocu")) {
			dto.setStatus("임시 저장");
			type = "saved";
		} else {
			dto.setStatus("진행중");
		}
		// 문서 정보 업데이트 ( 작성일, 제목, 상태 )
		serv.updateDocu(dto);

		// 문서 양식에 따라 해당 문서의 세부 정보 업데이트
		switch (dto.getDocu_code()) {
		case "M1":
			serv.updatePropDocu(wDTO);
			break;
		case "M2":
			// 문자열을 Date 타입으로 변환 후 저장
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			if (lrDTO.getStartDate() != "") {
				Date startDate = new Date(format.parse(lrDTO.getStartDate()).getTime());
				lrDTO.setStart_date(startDate);
			}
			if (lrDTO.getEndDate() != "") {
				Date endDate = new Date(format.parse(lrDTO.getEndDate()).getTime());
				lrDTO.setEnd_date(endDate);
			}
			serv.updateLeaveDocu(lrDTO);
			break;
		case "M3":
			serv.updateLatenessDocu(lnDTO);
			break;
		default:
			return "redirect:/error";
		}
		return "redirect:/eApproval/readDocu?docuSeq=" + dto.getDocument_seq() + "&type=" + type;
	}

	// 관리자가 결재 대기 or 결재 예정 문서함으로 이동할 때 필요한 데이터를 담아서 전달하는 메서드
	@RequestMapping("admin/apprList")
	public String apprList(String type, String docuCode, @RequestParam(required = false) String keyword, int cPage,
			Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}

		// 문서 상태를 변수에 저장
		String status = "";
		switch (type) {
		case "todo":
			status = "결재 대기";
			break;
		case "upcoming":
			status = "결재 예정";
			break;
		default:
			return "redirect:/error";
		}

		// 문서 정보를 저장할 변수 생성 후 검색 여부에 따라 해당하는 데이터를 변수에 저장
		List<DocuInfoListDTO> list = serv.searchListByType(empNo, status, docuCode, keyword, cPage);
		model.addAttribute("totalCount", serv.getCountSearchListByType(empNo, status, docuCode, keyword));

		// 작성자와 마지막 결재자의 사번 정보로 이름을 조회해서 dto에 저장 후 model 객체로 전달
		for (DocuInfoListDTO dto : list) {
			dto.setWriter(eServ.getName(dto.getEmp_no()));
			dto.setLast_appr_name(eServ.getName(dto.getLast_appr()));
		}
		model.addAttribute("docuCode", docuCode);
		model.addAttribute("docuList", list);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("cPage", cPage);
		model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
		model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);

		// 해당 문서함 화면으로 이동
		return "Admin/eApproval/list/" + type + "List";
	}

	// 브라우저에서 선택한 type에 따라 결재하기 페이지로 이동 시 해당 페이지에서 초기에 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("apprList")
	public String adminApprList(String type, String docuCode, @RequestParam(required = false) String keyword, int cPage,
			Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}

		// 문서 상태를 변수에 저장
		String status = "";
		switch (type) {
		case "todo":
			status = "결재 대기";
			break;
		case "upcoming":
			status = "결재 예정";
			break;
		default:
			return "redirect:/error";
		}

		// 문서 정보를 저장할 변수 생성 후 검색 여부에 따라 해당하는 데이터를 변수에 저장
		List<DocuInfoListDTO> list = serv.searchListByType(empNo, status, docuCode, keyword, cPage);
		model.addAttribute("totalCount", serv.getCountSearchListByType(empNo, status, docuCode, keyword));

		// 작성자와 마지막 결재자의 사번 정보로 이름을 조회해서 dto에 저장 후 model 객체로 전달
		for (DocuInfoListDTO dto : list) {
			dto.setWriter(eServ.getName(dto.getEmp_no()));
			dto.setLast_appr_name(eServ.getName(dto.getLast_appr()));
		}
		model.addAttribute("docuCode", docuCode);
		model.addAttribute("docuList", list);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("cPage", cPage);
		model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
		model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);

		// 해당 문서함 화면으로 이동
		return "eApproval/list/" + type + "List";
	}

	// 브라우저에서 선택한 type에 따라 개인 문서함 페이지로 이동 시 해당 페이지에서 초기에 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping("privateList")
	public String privateList(String type, String docuCode, @RequestParam(required = false) String keyword, int cPage,
			Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 문서 정보를 저장할 변수 생성 후 type에 따라 해당하는 데이터를 변수에 저장 후 model 객체로 전달
		List<DocuInfoListDTO> list = null;
		model.addAttribute("type", type);

		switch (type) {
		case "write":
			list = serv.searchWriteList(empNo, docuCode, keyword, cPage);
			// 마지막 결재자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setLast_appr_name(eServ.getName(dto.getLast_appr()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchWriteList(empNo, docuCode, keyword));
			break;
		case "save":
			model.addAttribute("docuList", serv.searchSavetList(empNo, docuCode, keyword, cPage));
			model.addAttribute("totalCount", serv.getCountSearchSaveList(empNo, docuCode, keyword));
			break;
		case "approved":
			list = serv.searchApprovedList(empNo, docuCode, keyword, cPage);
			// 기안자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setWriter(eServ.getName(dto.getEmp_no()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchApprovedList(empNo, docuCode, keyword));
			break;
		case "return":
			list = serv.searchReturnList(empNo, docuCode, keyword, cPage);
			// 기안자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setWriter(eServ.getName(dto.getEmp_no()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchReturnList(empNo, docuCode, keyword));
			break;
		case "view":
			list = serv.searchViewList(empNo, docuCode, keyword, cPage);
			// 기안자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setWriter(eServ.getName(dto.getEmp_no()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchViewList(empNo, docuCode, keyword));
			break;
		default:
			return "redirect:/error";
		}
		model.addAttribute("keyword", keyword);
		model.addAttribute("cPage", cPage);
		model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
		model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);
		model.addAttribute("docuCode", docuCode);

		// 해당 문서함 화면으로 이동
		return "eApproval/list/" + type + "List";
	}

	// 관리자가 개인 문서함 페이지로 이동 시 필요한 데이터를 담아서 전달하는 메서드
	@RequestMapping("admin/privateList")
	public String adminPrivateList(String type, String docuCode, @RequestParam(required = false) String keyword,
			int cPage, Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 문서 정보를 저장할 변수 생성 후 type에 따라 해당하는 데이터를 변수에 저장 후 model 객체로 전달
		List<DocuInfoListDTO> list = null;
		model.addAttribute("type", type);

		switch (type) {
		case "approved":
			list = serv.searchApprovedList(empNo, docuCode, keyword, cPage);
			// 기안자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setWriter(eServ.getName(dto.getEmp_no()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchApprovedList(empNo, docuCode, keyword));
			break;
		case "return":
			list = serv.searchReturnList(empNo, docuCode, keyword, cPage);
			// 기안자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setWriter(eServ.getName(dto.getEmp_no()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchReturnList(empNo, docuCode, keyword));
			break;
		case "view":
			list = serv.searchViewList(empNo, docuCode, keyword, cPage);
			// 기안자의 사번 정보로 이름을 조회해서 dto에 저장 후 전달
			for (DocuInfoListDTO dto : list) {
				dto.setWriter(eServ.getName(dto.getEmp_no()));
			}
			model.addAttribute("docuList", list);
			model.addAttribute("totalCount", serv.getCountSearchViewList(empNo, docuCode, keyword));
			break;
		default:
			return "redirect:/error";
		}
		model.addAttribute("keyword", keyword);
		model.addAttribute("cPage", cPage);
		model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
		model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);
		model.addAttribute("docuCode", docuCode);

		// 해당 문서함 화면으로 이동
		return "Admin/eApproval/list/" + type + "List";
	}

	// 관리자가 개인 문서함 페이지로 이동 시 필요한 데이터를 담아서 전달하는 메서드
	@RequestMapping("admin/docuList")
	public String adminDocuList(String type, String status, @RequestParam(required = false) String keyword, int cPage,
			Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 문서 정보를 저장할 변수 생성 후 type에 따라 해당하는 데이터를 변수에 저장 후 model 객체로 전달
		model.addAttribute("type", type);

		String docuCode = "";
		switch (type) {
		case "appr":
			docuCode = "M1";
			break;
		case "leave":
			docuCode = "M2";
			break;
		case "lateness":
			docuCode = "M3";
			break;
		default:
			// 추후 에러 페이지로 변경
			return "redirect:/error";
		}
		List<DocuInfoListDTO> list = serv.searchDocuListByDocuCode(docuCode, status, keyword, cPage);
		for (DocuInfoListDTO dto : list) {
			dto.setWriter(eServ.getName(dto.getEmp_no()));
		}
		model.addAttribute("totalCount", serv.getCountSearchDocuList(docuCode, status, keyword));
		model.addAttribute("docuList", list);
		model.addAttribute("keyword", keyword);
		model.addAttribute("cPage", cPage);
		model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
		model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);
		model.addAttribute("status", status);

		// 해당 문서함 화면으로 이동
		return "Admin/eApproval/list/" + type + "DocuList";
	}

	// ajax로 문서 양식 리스트를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "getDocuList", produces = "application/json;charset=utf8")
	public List<DocuListDTO> getDocuList() throws Exception {
		List<DocuListDTO> list = serv.getDocuList();
		return list;
	}

	// 임시 저장 상태인 해당 문서를 삭제하기 위한 메서드
	@RequestMapping("delDocu")
	public String delDocu(int docuSeq) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		serv.delDocu(docuSeq);
		return "redirect:/eApproval/privateList?type=save&cPage=1";
	}

	// 전자 결재 작성페이지로 이동 시 노출할 데이터를 담아서 전달하는 메서드
	@RequestMapping(value = "writeProc", method = RequestMethod.POST)
	public String writeProc(String docuCode, @RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, Model model) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정으로 접속 시 일반 사용자 경로 접속 불가
		if (eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 현재 날짜를 객체로 생성 후 문자열로 변환
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formattedDate = today.format(formatter);

		// model에 클라이언트에서 필요한 데이터 추가
		model.addAttribute("today", formattedDate);
		model.addAttribute("empInfo", eServ.getNameNDept(empNo));
		model.addAttribute("apprList", apprList);
		if (refeList != null) {
			model.addAttribute("refeList", refeList);
		}
		// 선택한 문서에 따라 해당 전자 결재 작성 화면으로 이동
		switch (docuCode) {
		case "M1":
			return "eApproval/write/writeProp";
		case "M2":
			// 해당 사원의 잔여 연차 갯수 조회 후 전달
			model.addAttribute("remaingLeaves", aServ.getRemainingLeavesByEmpNo(empNo));
			return "eApproval/write/writeLeave";
		case "M3":
			return "eApproval/write/writeLateness";
		default:
			return "redirect:/error";
		}
	}

	// 업무 기안 문서를 작성 완료 or 임시 저장했을 경우 정보를 저장하기 위한 메서드
	@ResponseBody
	@RequestMapping(value = { "write/Prop", "write/tempProp" }, produces = "application/json;charset=utf8")
	public int writeProp(@RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, DocuDTO dto, WorkPropDTO subDTO,
			HttpServletRequest request) throws Exception {

		// 세션에서 접속자 정보를 꺼내 저장
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();

		// 요청된 URL에 따라 분기 처리
		if (currentUrl.equals("/eApproval/write/Prop")) {

			// 문서 상태 설정
			dto.setStatus("진행중");
			// 문서 정보 입력 후 문서 번호를 저장
			int docuSeq = serv.insertDocu(dto);
			dto.setDocument_seq(docuSeq);

			// 결재 라인에 대한 정보를 순서에 따라서 전달
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[0], "결재 대기", 1));
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[1], "결재 예정", 2));
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[2], "결재 예정", 3));

		} else if (currentUrl.equals("/eApproval/write/tempProp")) {

			// 문서 상태 설정
			dto.setStatus("임시 저장");
			// 문서 정보 입력 후 문서 번호를 변수에 저장
			int docuSeq = serv.insertDocu(dto);
			dto.setDocument_seq(docuSeq);

			// 결재 라인에 대한 정보를 순서대로 전달
			for (int i = 0; i < 3; i++) {
				serv.setApprLine(new ApprLineDTO(docuSeq, apprList[i], "임시 라인", (i + 1)));
			}
		}
		// 문서의 세부 정보 입력
		subDTO.setDocument_seq(dto.getDocument_seq());
		serv.insertPropDocu(subDTO);

		// 참조 라인이 존재한다면 정보를 전달
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(dto.getDocument_seq(), refe);
			}
		}
		// 문서 번호를 반환
		return dto.getDocument_seq();
	}

	// 지각 사유서 문서를 작성 완료 or 임시 저장했을 경우 정보를 저장하기 위한 메서드
	@ResponseBody
	@RequestMapping(value = { "write/Lateness", "write/tempLateness" }, produces = "application/json;charset=utf8")
	public int writeLateness(@RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, DocuDTO dto, LatenessDTO subDTO,
			HttpServletRequest request) throws Exception {

		// 세션에서 접속자 정보를 꺼내 저장
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();

		// 요청된 URL에 따라 분기 처리
		if (currentUrl.equals("/eApproval/write/Lateness")) {

			// 문서 상태 설정
			dto.setStatus("진행중");
			// 문서 정보 입력 후 문서 번호를 저장
			int docuSeq = serv.insertDocu(dto);
			dto.setDocument_seq(docuSeq);

			// 결재 라인에 대한 정보를 순서에 따라서 전달
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[0], "결재 대기", 1));
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[1], "결재 예정", 2));
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[2], "결재 예정", 3));

		} else if (currentUrl.equals("/eApproval/write/tempLateness")) {

			// 문서 상태 설정
			dto.setStatus("임시 저장");
			// 문서 정보 입력 후 문서 번호를 변수에 저장
			int docuSeq = serv.insertDocu(dto);
			dto.setDocument_seq(docuSeq);

			// 결재 라인에 대한 정보를 순서대로 전달
			for (int i = 0; i < 3; i++) {
				serv.setApprLine(new ApprLineDTO(docuSeq, apprList[i], "임시 라인", (i + 1)));
			}
		}
		// 문서의 세부 정보 입력
		subDTO.setDocument_seq(dto.getDocument_seq());
		serv.insertLateDocu(subDTO);

		// 참조 라인이 존재한다면 정보를 전달
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(dto.getDocument_seq(), refe);
			}
		}
		// 문서 번호를 반환
		return dto.getDocument_seq();
	}

	// 휴가 신청서 문서를 작성 완료 or 임시 저장했을 경우 정보를 저장하기 위한 메서드
	@ResponseBody
	@RequestMapping(value = { "write/Leave", "write/tempLeave" }, produces = "application/json;charset=utf8")
	public int writeLeave(@RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, DocuDTO dto, LeaveRequestDTO subDTO,
			HttpServletRequest request) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);

		// 문자열을 Date 타입으로 변환 후 저장
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (subDTO.getStartDate() != "") {
			Date startDate = new Date(format.parse(subDTO.getStartDate()).getTime());
			subDTO.setStart_date(startDate);
		}
		if (subDTO.getEndDate() != "") {
			Date endDate = new Date(format.parse(subDTO.getEndDate()).getTime());
			subDTO.setEnd_date(endDate);
		}

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();

		// 요청된 URL에 따라 분기 처리
		if (currentUrl.equals("/eApproval/write/Leave")) {

			// 문서 상태 설정
			dto.setStatus("진행중");
			// 문서 정보 입력 후 문서 번호를 저장
			int docuSeq = serv.insertDocu(dto);
			dto.setDocument_seq(docuSeq);

			// 결재 라인에 대한 정보를 순서에 따라서 전달
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[0], "결재 대기", 1));
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[1], "결재 예정", 2));
			serv.setApprLine(new ApprLineDTO(docuSeq, apprList[2], "결재 예정", 3));

		} else if (currentUrl.equals("/eApproval/write/tempLeave")) {

			// 문서 상태 설정
			dto.setStatus("임시 저장");
			// 문서 정보 입력 후 문서 번호를 변수에 저장
			int docuSeq = serv.insertDocu(dto);
			dto.setDocument_seq(docuSeq);

			// 결재 라인에 대한 정보를 순서대로 전달
			for (int i = 0; i < 3; i++) {
				serv.setApprLine(new ApprLineDTO(docuSeq, apprList[i], "임시 라인", (i + 1)));
			}
		}
		// 문서의 세부 정보 입력
		subDTO.setDocument_seq(dto.getDocument_seq());
		serv.insertLeaveDocu(subDTO);

		// 참조 라인이 존재한다면 정보를 전달
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(dto.getDocument_seq(), refe);
			}
		}
		return dto.getDocument_seq();
	}

	// 결재 문서 작성 완료 시 파일을 업로드 하기 위한 메서드
	@ResponseBody
	@RequestMapping("uploadFiles")
	public Map<String, String> upload(int docuSeq, MultipartFile[] file) throws Exception {

		// 파일을 저장할 서버 경로 설정 및 파일 업로드
		String realPath = session.getServletContext().getRealPath("eApproval/upload");
		System.out.println(realPath);

		fServ.uploadDocuFile(docuSeq, realPath, file);

		Map<String, String> result = new HashMap<>();
		result.put("hrefUrl", "/eApproval/readDocu?docuSeq=" + docuSeq);

		return result;
	}

	// 해당 파일을 다운로드하기 위한 메서드
	@RequestMapping("downloadFiles")
	public void download(int fileSeq, HttpServletResponse response) throws Exception {
		// 파일 SEQ로 파일 정보 조회 후 변수에 저장
		DocuFilesDTO dto = fServ.getFileBySeq(fileSeq);
		String sysname = dto.getSysname();
		String oriname = dto.getOriname();

		String realPath = session.getServletContext().getRealPath("eApproval/upload");
		File target = new File(realPath + "/" + sysname);

		oriname = new String(oriname.getBytes(), "ISO-8859-1");
		response.setHeader("content-Disposition", "attachment;filename=\"" + oriname + "\"");

		try (DataInputStream dis = new DataInputStream(new FileInputStream(target)); // 파일에서 내용 뽑아오기
				DataOutputStream dos = new DataOutputStream(response.getOutputStream()); // 네트워크 방향으로 출력하기
		) {
			byte[] fileContents = new byte[(int) target.length()];
			dis.readFully(fileContents);
			dos.write(fileContents);
			dos.flush();
		}
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/error";
	}
}
