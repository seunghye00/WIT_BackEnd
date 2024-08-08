package com.wit.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wit.dto.DocuDTO;
import com.wit.dto.DocuFilesDTO;
import com.wit.dto.DocuInfoListDTO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.LatenessDTO;
import com.wit.dto.LeaveRequestDTO;
import com.wit.dto.WorkPropDTO;
import com.wit.services.EApprovalService;
import com.wit.services.EmployeeService;
import com.wit.services.FileService;

@Controller
@RequestMapping("/eApproval/")
public class EAppprovalController {

	@Autowired
	private EApprovalService serv;

	@Autowired
	private EmployeeService eServ;

	@Autowired
	private FileService fServ;

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

	// 업무 기안 문서를 작성 완료했을 경우 문서 정보 & 결재 라인 & 참조 라인을 저장하기 위한 메서드
	@ResponseBody
	@RequestMapping(value = { "/write/Prop", "/write/tempProp" }, produces = "application/json;charset=utf8")
	public int writeProp(@RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, DocuDTO dto, WorkPropDTO subDTO,
			HttpServletRequest request) throws Exception {

		// 작성자 정보 저장
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();

		// 요청된 URL에 따라 분기 처리
		if ("/write/Prop".equals(currentUrl)) {
			dto.setStatus("진행중");
		} else if ("/write/tempProp".equals(currentUrl)) {
			dto.setStatus("임시 저장");
		}

		// 문서 정보 입력 후 문서 번호를 변수에 저장
		int docuSeq = serv.insertDocu(dto);

		// 문서 세부 정보 입력
		subDTO.setDocument_seq(docuSeq);
		serv.insertPropDocu(subDTO);

		// 결재 라인에 대한 정보를 순서대로 전달
		for (int i = 0; i < 3; i++) {
			serv.createApprLine(docuSeq, apprList[i], (i + 1));
		}
		// 참조 라인이 존재한다면 정보를 전달
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(docuSeq, refe);
			}
		}
		return docuSeq;
	}

	// 지각 사유서 문서를 작성 완료했을 경우 문서 정보 & 결재 라인 & 참조 라인을 저장하기 위한 메서드
	@ResponseBody
	@RequestMapping(value = { "/write/Lateness", "/write/tempLateness" }, produces = "application/json;charset=utf8")
	public int writeLateness(@RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, DocuDTO dto, LatenessDTO subDTO,
			HttpServletRequest request) throws Exception {

		// 작성자 정보 저장
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();

		// 요청된 URL에 따라 분기 처리
		if ("/write/Lateness".equals(currentUrl)) {
			dto.setStatus("진행중");
		} else if ("/write/tempLateness".equals(currentUrl)) {
			dto.setStatus("임시 저장");
		}

		// 문서 정보 입력 후 문서 번호를 변수에 저장
		int docuSeq = serv.insertDocu(dto);

		// 문서 세부 정보 입력
		subDTO.setDocument_seq(docuSeq);
		serv.insertLateDocu(subDTO);

		// 결재 라인에 대한 정보를 순서대로 전달
		for (int i = 0; i < 3; i++) {
			serv.createApprLine(docuSeq, apprList[i], (i + 1));
		}
		// 참조 라인이 존재한다면 정보를 전달
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(docuSeq, refe);
			}
		}
		return docuSeq;
	}

	// 휴가 신청서 문서를 작성 완료했을 경우 문서 정보 & 결재 라인 & 참조 라인을 저장하기 위한 메서드
	@ResponseBody
	@RequestMapping(value = { "/write/Leave", "/write/tempLeave" }, produces = "application/json;charset=utf8")
	public int writeLeave(@RequestParam("apprList") String[] apprList,
			@RequestParam(value = "refeList", required = false) String[] refeList, DocuDTO dto, LeaveRequestDTO subDTO,
			HttpServletRequest request) throws Exception {

		// 작성자 정보 저장
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);

		// 현재 요청된 URL을 확인
		String currentUrl = request.getRequestURI();

		// 요청된 URL에 따라 분기 처리
		if ("/write/Leave".equals(currentUrl)) {
			dto.setStatus("진행중");
		} else if ("/write/tempLeave".equals(currentUrl)) {
			dto.setStatus("임시 저장");
		}

		// 문서 정보 입력 후 문서 번호를 변수에 저장
		int docuSeq = serv.insertDocu(dto);

		// 문서 세부 정보 입력
		subDTO.setDocument_seq(docuSeq);
		serv.insertLeaveDocu(subDTO);

		// 결재 라인에 대한 정보를 순서대로 전달
		for (int i = 0; i < 3; i++) {
			serv.createApprLine(docuSeq, apprList[i], (i + 1));
		}
		// 참조 라인이 존재한다면 정보를 전달
		if (refeList != null) {
			for (String refe : refeList) {
				serv.createRefeLine(docuSeq, refe);
			}
		}
		return docuSeq;
	}

	@RequestMapping("uploadFiles")
	public String upload(int docuSeq, MultipartFile[] file) throws Exception {

		String realPath = session.getServletContext().getRealPath("eApproval/upload");
		System.out.println(realPath);
		fServ.uploadDocuFile(docuSeq, realPath, file);

		return "redirect:/eApproval/home";
	}

	@RequestMapping("downloadFiles")
	public void download(String oriname, String sysname, HttpServletResponse response) throws Exception {

		// 굳이 컨트롤러(경로)를 통해 다운로드를 하는 이유는
		// 누군가의 기록을 남기거나 권한을 통제하는 코드 작성이 가능하기 때문이다.

		String realPath = session.getServletContext().getRealPath("upload");
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

	@ResponseBody
	@RequestMapping("list")
	public List<DocuFilesDTO> list(int docuSeq) throws Exception {
		return fServ.getList(docuSeq);
	}

	// 업무 기안 문서 작성 시 데이터를 받아와서 저장 후 기안 문서함 페이지로 이동하는 메서드
	/*
	 * @RequestMapping(value = "write/docuProp", method = RequestMethod.POST) public
	 * String writeProc(@RequestParam("apprList") String[] apprList,
	 * 
	 * @RequestParam(value = "refeList", required = false) String[] refeList,
	 * 
	 * @RequestParam(value = "files", required = false) MultipartFile[] files,
	 * DocuDTO dto, WorkPropDTO wpDTO) throws Exception {
	 * 
	 * String empNo = (String) session.getAttribute("loginID"); // 임시 데이터 empNo =
	 * "2024-0001"; dto.setEmp_no(empNo);
	 * 
	 * // 작성한 문서에 대한 데이터를 업데이트 serv.insertByWrite(dto); serv.insertPropDocu(wpDTO);
	 * return "redirect:/eApproval/home"; }
	 * 
	 * // 업무 기안 문서 임시 저장 시 해당 데이터를 업데이트하기 위한 메서드
	 * 
	 * @RequestMapping(value = "save/docuProp", method = RequestMethod.POST) public
	 * String saveDocuProp(DocuDTO docuDTO, WorkPropDTO
	 * workPropDTO, @RequestParam("apprList") String[] apprList,
	 * 
	 * @RequestParam(value = "refeList", required = false) String[] refeList) throws
	 * Exception {
	 * 
	 * serv.insertBySave(docuDTO); serv.insertPropDocu(workPropDTO);
	 * 
	 * for (int i = 0; i < 3; i++) { serv.createApprLine(docuDTO.getDocument_seq(),
	 * apprList[i], (i + 1)); } if (refeList != null) { for (String refe : refeList)
	 * { serv.createRefeLine(docuDTO.getDocument_seq(), refe); } } return
	 * "redirect:/eApproval/home"; }
	 */

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
