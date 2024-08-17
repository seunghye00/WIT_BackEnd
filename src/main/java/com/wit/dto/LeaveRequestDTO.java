package com.wit.dto;

import java.sql.Date;

// 휴가 신청서 문서의 세부 내용에 대한 데이터를 보관하기 위한 DTO
public class LeaveRequestDTO {
	private int document_seq;
	private String leave_type;
	private Date start_date;
	private Date end_date;
	private String start_day_checked;
	private String start_day_am_checked;
	private String start_day_pm_checked;
	private String end_day_checked;
	private String end_day_am_checked;
	private String end_day_pm_checked;
	private float request_leave_days;
	private String reason;

	public int getDocument_seq() {
		return document_seq;
	}

	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
	}

	public String getLeave_type() {
		return leave_type;
	}

	public void setLeave_type(String leave_type) {
		this.leave_type = leave_type;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	public String getStart_day_checked() {
		return start_day_checked;
	}

	public void setStart_day_checked(String start_day_checked) {
		this.start_day_checked = start_day_checked;
	}

	public String getStart_day_am_checked() {
		return start_day_am_checked;
	}

	public void setStart_day_am_checked(String start_day_am_checked) {
		this.start_day_am_checked = start_day_am_checked;
	}

	public String getStart_day_pm_checked() {
		return start_day_pm_checked;
	}

	public void setStart_day_pm_checked(String start_day_pm_checked) {
		this.start_day_pm_checked = start_day_pm_checked;
	}

	public String getEnd_day_checked() {
		return end_day_checked;
	}

	public void setEnd_day_checked(String end_day_checked) {
		this.end_day_checked = end_day_checked;
	}

	public String getEnd_day_am_checked() {
		return end_day_am_checked;
	}

	public void setEnd_day_am_checked(String end_day_am_checked) {
		this.end_day_am_checked = end_day_am_checked;
	}

	public String getEnd_day_pm_checked() {
		return end_day_pm_checked;
	}

	public void setEnd_day_pm_checked(String end_day_pm_checked) {
		this.end_day_pm_checked = end_day_pm_checked;
	}

	public float getRequest_leave_days() {
		return request_leave_days;
	}

	public void setRequest_leave_days(float request_leave_days) {
		this.request_leave_days = request_leave_days;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public LeaveRequestDTO(int document_seq, String leave_type, Date start_date, Date end_date,
			String start_day_checked, String start_day_am_checked, String start_day_pm_checked, String end_day_checked,
			String end_day_am_checked, String end_day_pm_checked, float request_leave_days, String reason) {
		super();
		this.document_seq = document_seq;
		this.leave_type = leave_type;
		this.start_date = start_date;
		this.end_date = end_date;
		this.start_day_checked = start_day_checked;
		this.start_day_am_checked = start_day_am_checked;
		this.start_day_pm_checked = start_day_pm_checked;
		this.end_day_checked = end_day_checked;
		this.end_day_am_checked = end_day_am_checked;
		this.end_day_pm_checked = end_day_pm_checked;
		this.request_leave_days = request_leave_days;
		this.reason = reason;
	}

	public LeaveRequestDTO() {
		super();
	}
}
