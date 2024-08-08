package com.wit.dto;

import java.sql.Timestamp;

//전자 결재 문서 양식의 공통으로 입력되는 데이터만 보관하는 DTO 
public class DocuDTO {
	private int document_seq;
	private String emp_no;
	private String title;
	private Timestamp write_date;
	private String status;
	private String emer_yn;
	private String docu_code;
	private String done_date;
	public int getDocument_seq() {
		return document_seq;
	}
	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
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
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEmer_yn() {
		return emer_yn;
	}
	public void setEmer_yn(String emer_yn) {
		this.emer_yn = emer_yn;
	}
	public String getDocu_code() {
		return docu_code;
	}
	public void setDocu_code(String docu_code) {
		this.docu_code = docu_code;
	}
	public String getDone_date() {
		return done_date;
	}
	public void setDone_date(String done_date) {
		this.done_date = done_date;
	}
	public DocuDTO(int document_seq, String emp_no, String title, Timestamp write_date, String status, String emer_yn,
			String docu_code, String done_date) {
		super();
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.title = title;
		this.write_date = write_date;
		this.status = status;
		this.emer_yn = emer_yn;
		this.docu_code = docu_code;
		this.done_date = done_date;
	}
	public DocuDTO() {
		super();
	}
}
