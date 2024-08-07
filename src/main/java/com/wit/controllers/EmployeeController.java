package com.wit.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.RoleDTO;
import com.wit.services.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	private EmployeeService service;

	@Autowired
	private HttpSession session;

	// 관리자 회원가입 폼으로 이동
	@RequestMapping("/register_form")
	public String registerForm(Model model) {
		List<RoleDTO> roleList = service.AllRoles();
		List<DeptDTO> deptList = service.AllDepts();
		model.addAttribute("roleList", roleList);
		model.addAttribute("deptList", deptList);
		return "register";
	}

	// 입사 순서대로 부서코드 생성을 위한 DB 조회 (사번 생성)
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
			return "redirect:/";
		} else {
			return "register";
		}
	}

	// 로그인
	@ResponseBody
	@RequestMapping("/login")
	public Map<String, Object> login(String emp_no, String pw, HttpSession session) throws Exception {
		EmployeeDTO employee = service.login(emp_no, pw);
		Map<String, Object> response = new HashMap<>();
		if (employee != null) {
			session.setAttribute("loginID", emp_no);
			// 우측상단 이름 및 직급 조회를 위한 코드!
			session.setAttribute("loginName", employee.getName());
			session.setAttribute("loginRole", employee.getRole_code());
			// 첫 로그인시 추가 정보 입력을 위한 코드!
			boolean isFirstLogin = service.FirstLogin(emp_no);
			// FirstLogin 값을 세션에 저장
			session.setAttribute("FirstLogin", isFirstLogin);
			response.put("success", true);
		} else {
			response.put("success", false);
		}
		return response;
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
		model.addAttribute("employee", employee);
		return "mypage";
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
        
        List<Map<String, Object>> categoryList = service.getCategories();
        
        int totPage = service.totalCountPage();
        //List<Map<String, Object>> categoryList = service.getCategories(emp_no);
        model.addAttribute("totPage", totPage);
        model.addAttribute("cpage", cpage_num);
        model.addAttribute("addressBookGroupList", list);
        return "AddressBook/addressBookGroup";
	}
	
	// 주소록 ajax 요청 회신
	@RequestMapping("/groupAddressTool")
	@ResponseBody
	public Map<String, Object> addressBookGroupAjax(String chosung, String cpage, String category,  Model model) {
		String emp_no = (String) session.getAttribute("loginID");
		
		if (cpage == null) {
			cpage = "1";
		}
		
		int cpage_num = Integer.parseInt(cpage);
		
		if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
			chosung = "";
		}
		
		System.out.println(category);
		if (category == null || category.isEmpty() || "전체".equals(category)) {
            category = "";
        }
		
		List<Map<String, Object>> list = service.getEmployeeList(chosung, category, cpage_num);
		
		List<Map<String, Object>> categoryList = service.getCategories();
		int totPage = service.totalCountPage();
		
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
    public List<Map<String, Object>> getAllMessengerEmp () {
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
		return "mypage";
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

	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
