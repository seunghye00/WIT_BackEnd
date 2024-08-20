package com.wit.controllers;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.commons.BoardConfig;
import com.wit.dto.BoardReportDTO;
import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.RoleDTO;
import com.wit.services.BoardService;
import com.wit.services.CalendarService;
import com.wit.services.DeptService;
import com.wit.services.EmployeeService;
import com.wit.services.RoleService;

import oracle.sql.TIMESTAMP;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	private EmployeeService service;
	
	// 생성된 사번으로 사원의 기본 캘린더를 생성시켜주기 위해 불러옴.
	@Autowired
	private CalendarService cService;

	@Autowired
	private HttpSession session;
	
	@Autowired
	private BoardService bserv;
	
	@Autowired
	private DeptService deptServ;
	
	@Autowired
	private RoleService roleServ;

	// 관리자 회원가입 폼으로 이동
	@RequestMapping("/register_form")
	public String registerForm(Model model) {
		List<RoleDTO> roleList = service.AllRoles();
		List<DeptDTO> deptList = service.AllDepts();
		model.addAttribute("roleList", roleList);
		model.addAttribute("deptList", deptList);
		return "/Management/register";
	}

	// 입사 순서대로 부서코드 생성을 위한 DB 조회 (사번 조회)
	@ResponseBody
	@RequestMapping("/highestEmployeeID")
	public String getHighestEmployeeID(String dept) throws Exception {
		return service.getHighestEmployeeIDByDept(dept);
	}

	// 회원가입
	@RequestMapping("/register")
	public String register(EmployeeDTO dto) throws Exception {
		int result = service.register(dto);
		if (result == 1) {
			// 회원가입 성공 시 해당 회원의 기본 개인 캘린더 추가 
			cService.insertPerDefaultCalendar(dto.getEmp_no());
			return "redirect:/";
		} else {
			return "/Management/register";
		}
	}

	// 로그인
	@ResponseBody
	@RequestMapping("/login")
	public Map<String, Object> login(String emp_no, String pw, HttpSession session) throws Exception {
		EmployeeDTO employee = service.login(emp_no, pw);
		Map<String, Object> response = new HashMap<>();
		if (employee != null) {
			// 세션에 로그인 ID 저장
			session.setAttribute("loginID", emp_no);

			// 첫 로그인시 추가 정보 입력을 위한 코드
			boolean isFirstLogin = service.FirstLogin(emp_no);
			session.setAttribute("FirstLogin", isFirstLogin);

			// 로그인 성공 처리
			response.put("success", true);
		} else {
			// 로그인 실패 처리
			response.put("success", false);
		}
		return response;
	}

	// 메인 페이지로 이동
	@RequestMapping("/main")
	public String main(Model model,
			@RequestParam(defaultValue = "") String searchTarget,
			@RequestParam(defaultValue = "views") String sortTarget,
			@RequestParam(defaultValue = "") String searchTxt,
			@RequestParam(defaultValue = "0") int cpage,
			@RequestParam(defaultValue = "false") String bookmark,
			@RequestParam(defaultValue = "false") String report)throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		List<BoardReportDTO> boardList = bserv.list(searchTxt, searchTarget, sortTarget, cpage,empNo,bookmark,1,report);
		List<BoardReportDTO> noticeList = bserv.list(searchTxt, searchTarget, sortTarget, cpage,empNo,bookmark,2,report);
		System.out.println(empNo);
		model.addAttribute("boardList",boardList);
		model.addAttribute("noticeList",noticeList);
		
	    // 직원 정보 가져오기
	    EmployeeDTO employee = service.employeeInfo(empNo);

	    if (employee != null) {
	        model.addAttribute("employee", employee);

	        // 사장님(CEO)이라면 Admin 페이지로 이동
	        if ("사장".equals(employee.getRole_code())) {
	            return "Admin/main";
	        } else {
	            // 다른 직급이라면 User 페이지로 이동
	            return "User/main";
	        }
	    } else {
	        return "redirect:/";
	    }
	}

	// 추가 정보 업데이트
	@RequestMapping("/update_info")
	public String updateInfo(EmployeeDTO dto, HttpSession session) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		service.updateInfo(dto);
		session.setAttribute("FirstLogin", false);
		return "redirect:/";
	}

	// ID 찾기 폼으로 이동
	@RequestMapping("/find_ID")
	public String findID() {
		return "findID";
	}

	// ID찾기
	@ResponseBody
	@RequestMapping("/findID")
	public Map<String, Object> findID(String name, String ssn) throws Exception {
		String empNo = service.findID(name, ssn);
		Map<String, Object> response = new HashMap<>();
		if (empNo != null) {
			response.put("success", true);
			response.put("empNo", empNo);
		} else {
			response.put("success", false);
		}
		return response;
	}

	// PW 찾기 폼으로 이동
	@RequestMapping("/find_PW")
	public String findPW() {
		return "findPW";
	}

	// PW찾기(수정) 을 위한 직원 정보 확인
	@ResponseBody
	@RequestMapping("/verifyEmployee")
	public Map<String, Object> verifyEmployee(String emp_no, String name, String ssn) throws Exception {
		boolean employeeExists = service.verifyEmployee(emp_no, name, ssn);
		Map<String, Object> response = new HashMap<>();
		response.put("success", employeeExists);
		return response;
	}

	// PW찾기 (수정)
	@ResponseBody
	@RequestMapping("/modifyPassword")
	public Map<String, Object> modifyPassword(String emp_no, String newPassword) throws Exception {
		boolean isUpdated = service.modifyPassword(emp_no, newPassword);
		Map<String, Object> response = new HashMap<>();
		response.put("success", isUpdated);
		return response;
	}

	// 마이페이지로 이동
	@RequestMapping("/mypage")
	public String mypage(Model model) {
		String empNo = (String) session.getAttribute("loginID");
		EmployeeDTO employee = service.findByEmpNo(empNo);
		session.setAttribute("loginName", employee.getName());
		session.setAttribute("loginRole", employee.getRole_code());
		session.setAttribute("loginPhoto", employee.getPhoto());
		model.addAttribute("employee", employee);
		return "/Management/mypage";
	}

	// 닉네임 중복 체크(마이페이지)
	@ResponseBody
	@RequestMapping("/check_nickname")
	public Map<String, Object> checkNickname(String nickname) {
		boolean value = service.checkNickname(nickname);
		Map<String, Object> response = new HashMap<>();
		response.put("value", value);
		return response;
	}

	// 주소록 전체 데이터 조회
	@RequestMapping("/addressList")
	public String getEmployeeAddressList(String chosung, String cpage, String category, Model model) {
		String emp_no = (String) session.getAttribute("loginID");

		if (cpage == null) {
			cpage = "1";
		}

		int cpage_num = Integer.parseInt(cpage);

		if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
			chosung = "";
		}

		if (category == null || category.isEmpty() || "전체".equals(category)) {
			category = "";
		}

		List<Map<String, Object>> list = service.getEmployeeList(chosung, category, cpage_num);

		//List<Map<String, Object>> categoryList = service.getCategories();

		int totPage = service.CountPageAddress(chosung, category, cpage_num);
		// List<Map<String, Object>> categoryList = service.getCategories(emp_no);
		model.addAttribute("totPage", totPage);
		model.addAttribute("cpage", cpage_num);
		model.addAttribute("addressBookGroupList", list);
		return "AddressBook/addressBookGroup";
	}

	// 주소록 ajax 요청 회신
	@RequestMapping("/groupAddressTool")
	@ResponseBody
	public Map<String, Object> addressBookGroupAjax(String chosung, String cpage, String category, Model model) {
		String emp_no = (String) session.getAttribute("loginID");

		if (cpage == null) {
			cpage = "1";
		}

		int cpage_num = Integer.parseInt(cpage);

		if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
			chosung = "";
		}

		if (category == null || category.isEmpty() || "전체".equals(category)) {
			category = "";
		}

		List<Map<String, Object>> list = service.getEmployeeList(chosung, category, cpage_num);

		List<Map<String, Object>> categoryList = service.getCategories();
		int totPage = service.CountPageAddress(chosung, category, cpage_num);
		System.out.println(totPage);
		Map<String, Object> response = new HashMap<>();
		response.put("totPage", totPage);
		response.put("cpage", cpage_num);
		response.put("addressBookGroupList", list);
		response.put("categoryList", categoryList);
		return response;
	}

	// 주소록 카테고리 조회
	@RequestMapping("getCategories")
	@ResponseBody
	public List<Map<String, Object>> getCategories() {
		return service.getCategories();
	}

	// 주소록 상세 데이터 조회
	@RequestMapping("getContactDetails")
	@ResponseBody
	public Map<String, Object> getContactDetails(String emp_no) {
		Map<String, Object> contact = service.getContactByEmp_no(emp_no);
		return contact;
	}

	// 주소록 검색
	@RequestMapping("search")
	@ResponseBody
	public Map<String, Object> search(String keyword, String cpage) {
		if (cpage == null) {
			cpage = "1";
		}
		int cpage_num = Integer.parseInt(cpage);
		List<Map<String, Object>> list = service.selectByCon(keyword, cpage_num);
		int totPage = service.totalCountPageSearch(keyword);

		Map<String, Object> response = new HashMap<>();
		response.put("totPage", totPage);
		response.put("cpage", cpage_num);
		response.put("addressBookGroupList", list);
		return response;
	}

	// 채팅 메신저 주소록 출력
	@ResponseBody
	@RequestMapping("/getEmployeeList")
	public List<Map<String, Object>> getAllMessengerEmp() {
		String emp_no = (String) session.getAttribute("loginID");
		return service.getAllMessengerEmp(emp_no);
	}

	// 채팅 메신저 상세 디테일
	@ResponseBody
	@RequestMapping("/getEmployeeDetails")
	public Map<String, Object> getEmployeeDetails(String emp_no) {
		return service.getContactByEmpNo(emp_no);
	}

	// 마이페이지 정보 업데이트
	@RequestMapping("/update_mypage")
	public String updateMyPage(EmployeeDTO dto, HttpSession session) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		service.updateMyPage(dto);
		return "/Management/mypage";
	}

	// 로그아웃
	@RequestMapping("/logout")
	public String logout() throws Exception {
		session.invalidate();
		return "redirect:/";
	}

	// 회원탈퇴
	@RequestMapping("/delete")
	public String delete() throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		if (empNo != null) {
			service.delete(empNo);
			session.invalidate();
		}
		return "redirect:/";
	}

	// ajax로 부서별 사원 목록를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "/getListByDept", produces = "application/json;charset=utf8")
	public List<EmployeeDTO> getListByDept(String deptCode) throws Exception {
		return service.getListByDept(deptCode);
	}
	
	//  메신저 emp_no 이름으로 변경
	@ResponseBody
	@RequestMapping("/getEmployeeName")
	public String getEmployeeName(String emp_no) throws Exception {
		return service.getEmployeeName(emp_no);
	}
	
	// 관리자 사원 관리
	@RequestMapping("/management")
	public String management(Model model, String cpage) throws Exception {
		return "Management/management";
	}
	
	// 관리자 사원 관리
	@ResponseBody
	@RequestMapping("/manageLoad")
	public Map<String, Object> getManagement(Model model, String cpage) throws Exception {
		String emp_no = (String) session.getAttribute("loginID");

		if (cpage == null) {
			cpage = "1";
		}

		int cpage_num = Integer.parseInt(cpage);

		List<Map<String, Object>> list = service.getManagementList(emp_no, cpage_num);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

		for (Map<String, Object> item : list) {
			TIMESTAMP joinTimestamp = (TIMESTAMP) item.get("JOIN_DATE");
			TIMESTAMP quitTimestamp = (TIMESTAMP) item.get("QUIT_DATE");

			if (joinTimestamp != null) {
				Timestamp joinDate = joinTimestamp.timestampValue();
				item.put("JOIN_DATE", sdf.format(joinDate));
			}
			if (quitTimestamp != null) {
				Timestamp quitDate = quitTimestamp.timestampValue();
				item.put("QUIT_DATE", sdf.format(quitDate));
			}
		}
		int totPage = service.totalCountPage(emp_no);
		Map<String, Object> response = new HashMap<>();
		response.put("totPage", totPage);
		response.put("cpage", cpage_num);
		response.put("naviCountPerPage", BoardConfig.naviCountPerPage);
		response.put("recordCountPerPage",  BoardConfig.recordCountPerPage);
		response.put("manageList", list);
		return response;
	}
	
	// 관리자 검색 검색
	@ResponseBody
	@RequestMapping("/manageSearch") 
	public Map<String, Object> manageSearch(String column, String keyword, Model model, String cpage) throws Exception {
		String emp_no = (String) session.getAttribute("loginID");
		
		if (cpage == null) {
			cpage = "1";
		}
		int cpage_num = Integer.parseInt(cpage);
		
		List<Map<String, Object>> list = service.selectByManage(emp_no, column, keyword, cpage_num);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		for (Map<String, Object> item : list) {
			TIMESTAMP joinTimestamp = (TIMESTAMP) item.get("JOIN_DATE");
			TIMESTAMP quitTimestamp = (TIMESTAMP) item.get("QUIT_DATE");

			if (joinTimestamp != null) {
				Timestamp joinDate = joinTimestamp.timestampValue();
				item.put("JOIN_DATE", sdf.format(joinDate));
			}
			if (quitTimestamp != null) {
				Timestamp quitDate = quitTimestamp.timestampValue();
				item.put("QUIT_DATE", sdf.format(quitDate));
			}
		}
		int totPage = service.totalCountManageSearch(emp_no, column, keyword);
		
		Map<String, Object> response = new HashMap<>();
		response.put("totPage", totPage);
		response.put("cpage", cpage_num);
		response.put("naviCountPerPage", BoardConfig.naviCountPerPage);
		response.put("recordCountPerPage",  BoardConfig.recordCountPerPage);
		response.put("manageList", list);
//		List<EmployeeDTO> list = serv.selectByCon(column,keyword,cpage_num);
//		int totPage = serv.totalCountPageSearch(column,keyword);
//		model.addAttribute("list", list);
//		model.addAttribute("totPage", totPage);
//		model.addAttribute("cpage", cpage_num);
		return response;
	}
	
	// 관리자 사원 관리 상세
	@RequestMapping("/managementDetail")
	public String managementDetail(Model model, String empNo) throws Exception {
		
		Map<String, Object> manageDetail = service.managementDetail(empNo);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		List<DeptDTO> departments = deptServ.getList();
		List<RoleDTO> roles = roleServ.getList();
		// 날짜 형식 변환
		TIMESTAMP joinTimestamp = (TIMESTAMP) manageDetail.get("JOIN_DATE");
		TIMESTAMP quitTimestamp = (TIMESTAMP) manageDetail.get("QUIT_DATE");

		if (joinTimestamp != null) {
			Timestamp joinDate = joinTimestamp.timestampValue();
			manageDetail.put("JOIN_DATE", sdf.format(joinDate));
		}
		if (quitTimestamp != null) {
			Timestamp quitDate = quitTimestamp.timestampValue();
			manageDetail.put("QUIT_DATE", sdf.format(quitDate));
		}
		
		model.addAttribute("employee", manageDetail);
		model.addAttribute("departments", departments);
		model.addAttribute("roles", roles);
		return "Management/managementDetail";
	}
	
	// 관리자 사원 관리 상세
	@RequestMapping("/updateManage")
	public String updateManage(Map<String, Object> params) throws Exception {
		
        String empNo = (String) params.get("empNo");
        String photoUrl = (String) params.get("photoUrl");
        // 기타 다른 파라미터들 처리

        //employeeService.updateEmployeePhoto(empNo, photoUrl);
        
		return "redirect:/employee/managementDetail?empNo=" + empNo;
	}
	
	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
	
}
