package com.wit.dto;

public class ExecutiveCalendarDTO {
	private int calendar_seq;
	private String calendar_name;
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
	public String getDefault_yn() {
		return default_yn;
	}
	public void setDefault_yn(String default_yn) {
		this.default_yn = default_yn;
	}
	
	public ExecutiveCalendarDTO() {}
	
	public ExecutiveCalendarDTO(int calendar_seq, String calendar_name, String default_yn) {
		super();
		this.calendar_seq = calendar_seq;
		this.calendar_name = calendar_name;
		this.default_yn = default_yn;
	}
	
	
}
