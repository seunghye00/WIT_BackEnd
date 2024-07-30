package com.wit.dto;

public class DeptDTO {
	private String dept_code;
	private String dept_title;

	public DeptDTO() {

	}

	public DeptDTO(String dept_code, String dept_title) {
		super();
		this.dept_code = dept_code;
		this.dept_title = dept_title;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getDept_title() {
		return dept_title;
	}

	public void setDept_title(String dept_title) {
		this.dept_title = dept_title;
	}
}
