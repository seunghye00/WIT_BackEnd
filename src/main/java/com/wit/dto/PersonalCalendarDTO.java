package com.wit.dto;

public class PersonalCalendarDTO {
	
	private int calendar_seq;
	private String calendar_name;
	private String emp_no;
	private String default_yn;
	
	public int getCalendar_seq() {
		return calendar_seq;
	}
	public void setCalendar_seq(int calendar_seq) {
		this.calendar_seq = calendar_seq;
	}
	public String getCalendar_name() {
		return calendar_name;
	}
	public void setCalendar_name(String calendar_name) {
		this.calendar_name = calendar_name;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getDefault_yn() {
		return default_yn;
	}
	public void setDefault_yn(String default_yn) {
		this.default_yn = default_yn;
	}
	
	public PersonalCalendarDTO() {}
	
	public PersonalCalendarDTO(int calendar_seq, String calendar_name, String emp_no, String default_yn) {
		super();
		this.calendar_seq = calendar_seq;
		this.calendar_name = calendar_name;
		this.emp_no = emp_no;
		this.default_yn = default_yn;
	}
	
}
