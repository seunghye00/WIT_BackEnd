package com.wit.dto;

import java.sql.Timestamp;


public class EventsDTO {
	private int events_seq;
	private String emp_no;
	private String title;
//	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private Timestamp start_date;
//	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private Timestamp end_date;
	private String calendar_name;
	private String location;
	private String content;
	public int getEvents_seq() {
		return events_seq;
	}
	public void setEvents_seq(int events_seq) {
		this.events_seq = events_seq;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getStart_date() {
		return start_date;
	}
	public void setStart_date(Timestamp start_date) {
		this.start_date = start_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
	public String getCalendar_name() {
		return calendar_name;
	}
	public void setCalendar_name(String calendar_name) {
		this.calendar_name = calendar_name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public EventsDTO() {}
	
	public EventsDTO(int events_seq, String emp_no, String title, Timestamp start_date, Timestamp end_date,
			String calendar_name, String location, String content) {
		super();
		this.events_seq = events_seq;
		this.emp_no = emp_no;
		this.title = title;
		this.start_date = start_date;
		this.end_date = end_date;
		this.calendar_name = calendar_name;
		this.location = location;
		this.content = content;
	}
	
	
	
	
	
}
