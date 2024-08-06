package com.wit.dto;

// 사원의 정보 중 사번, 이름, 부서코드, 부서명, 직급코드, 직급명, 퇴사 여부만 담아서 보관하기 위한 DTO
public class EmployeeInfoDTO {
	private String emp_no;
	private String name;
	private String dept_code;
	private String dept_title;
	private String role_code;
	private String role_title;
	private String quit_yn;

	public String getDept_title() {
		return dept_title;
	}

	public void setDept_title(String dept_title) {
		this.dept_title = dept_title;
	}

	public String getRole_code() {
		return role_code;
	}

	public void setRole_code(String role_code) {
		this.role_code = role_code;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getRole_title() {
		return role_title;
	}

	public void setRole_title(String role_title) {
		this.role_title = role_title;
	}

	public String getQuit_yn() {
		return quit_yn;
	}

	public void setQuit_yn(String quit_yn) {
		this.quit_yn = quit_yn;
	}

	public EmployeeInfoDTO(String name, String dept_title) {
		super();
		this.name = name;
		this.dept_title = dept_title;
	}

	public EmployeeInfoDTO(String emp_no, String name, String role_code, String role_title) {
		super();
		this.emp_no = emp_no;
		this.name = name;
		this.role_code = role_code;
		this.role_title = role_title;
	}

	public EmployeeInfoDTO(String emp_no, String name, String dept_code, String dept_title, String role_code,
			String role_title, String quit_yn) {
		super();
		this.emp_no = emp_no;
		this.name = name;
		this.dept_code = dept_code;
		this.dept_title = dept_title;
		this.role_code = role_code;
		this.role_title = role_title;
		this.quit_yn = quit_yn;
	}

	public EmployeeInfoDTO() {
		super();
	}
}