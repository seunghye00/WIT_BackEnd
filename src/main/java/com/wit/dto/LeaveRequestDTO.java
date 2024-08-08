package com.wit.dto;

import java.sql.Date;

public class LeaveRequestDTO {
	private int document_seq;
	private String leave_type;
	private Date start_date;
	private Date end_date;
	private String half_day_yn;
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
	public String getHalf_day_yn() {
		return half_day_yn;
	}
	public void setHalf_day_yn(String half_day_yn) {
		this.half_day_yn = half_day_yn;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public LeaveRequestDTO(int document_seq, String leave_type, Date start_date, Date end_date, String half_day_yn,
			String reason) {
		super();
		this.document_seq = document_seq;
		this.leave_type = leave_type;
		this.start_date = start_date;
		this.end_date = end_date;
		this.half_day_yn = half_day_yn;
		this.reason = reason;
	}
	public LeaveRequestDTO() {
		super();
	}
}
