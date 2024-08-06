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

	// ajax로 부서별 사원 목록를 요청했을 때 서버로 보내기 위한 메서드
	@ResponseBody
	@RequestMapping(value = "/getListByDept", produces = "application/json;charset=utf8")
	public List<EmployeeDTO> getListByDept(String deptCode) throws Exception {
		return service.getListByDept(deptCode);
	}
	
	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
