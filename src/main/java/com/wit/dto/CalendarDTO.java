package com.wit.dto;

public class CalendarDTO {
	private int calendar_seq;
	private String emp_no;
	private String dept_code;
	private String calendar_name;
	private String calendar_code;
	
	
	public int getCalendar_seq() {
		return calendar_seq;
	}
	public void setCalendar_seq(int calendar_seq) {
		this.calendar_seq = calendar_seq;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getCalendar_name() {
		return calendar_name;
	}
	public void setCalendar_name(String calendar_name) {
		this.calendar_name = calendar_name;
	}
	public String getCalendar_code() {
		return calendar_code;
	}
	public void setCalendar_code(String calendar_code) {
		this.calendar_code = calendar_code;
	}
	
	public CalendarDTO() {}
	
	public CalendarDTO(int calendar_seq, String emp_no, String dept_code, String calendar_name, String calendar_code) {
		super();
		this.calendar_seq = calendar_seq;
		this.emp_no = emp_no;
		this.dept_code = dept_code;
		this.calendar_name = calendar_name;
		this.calendar_code = calendar_code;
	}
	
	
}
