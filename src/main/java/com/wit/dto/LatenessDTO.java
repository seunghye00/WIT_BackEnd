package com.wit.dto;

import java.sql.Date;

// 지각 사유서 문서의 세부 내용에 대한 데이터를 보관하기 위한 DTO
public class LatenessDTO {
	private int document_seq;
	private Date late_date;
	private String reason;
	public int getDocument_seq() {
		return document_seq;
	}
	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
	}
	public Date getLate_date() {
		return late_date;
	}
	public void setLate_date(Date late_date) {
		this.late_date = late_date;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public LatenessDTO(int document_seq, Date late_date, String reason) {
		super();
		this.document_seq = document_seq;
		this.late_date = late_date;
		this.reason = reason;
	}
	public LatenessDTO() {
		super();
	}
}
