package com.wit.dto;

import java.sql.Date;

// 업무 기안 문서의 세부 내용에 대한 데이터를 보관하기 위한 DTO
public class WorkPropDTO {
	private int document_seq;
	private Date eff_date;
	private String dept_title;
	private String contents;

	public int getDocument_seq() {
		return document_seq;
	}

	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
	}

	public Date getEff_date() {
		return eff_date;
	}

	public void setEff_date(Date eff_date) {
		this.eff_date = eff_date;
	}

	public String getDept_title() {
		return dept_title;
	}

	public void setDept_title(String dept_title) {
		this.dept_title = dept_title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public WorkPropDTO(int document_seq, Date eff_date, String dept_title, String contents) {
		super();
		this.document_seq = document_seq;
		this.eff_date = eff_date;
		this.dept_title = dept_title;
		this.contents = contents;
	}

	public WorkPropDTO() {
		super();
	}
}
