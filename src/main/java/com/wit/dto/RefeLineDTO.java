package com.wit.dto;

import java.sql.Timestamp;

public class RefeLineDTO {
	private int r_line_seq;
	private int document_seq;
	private String emp_no;
	private String name;
	private String role_title;
	private String read_yn;
	private Timestamp read_date;
	public int getR_line_seq() {
		return r_line_seq;
	}
	public void setR_line_seq(int r_line_seq) {
		this.r_line_seq = r_line_seq;
	}
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRole_title() {
		return role_title;
	}
	public void setRole_title(String role_title) {
		this.role_title = role_title;
	}
	public String getRead_yn() {
		return read_yn;
	}
	public void setRead_yn(String read_yn) {
		this.read_yn = read_yn;
	}
	public Timestamp getRead_date() {
		return read_date;
	}
	public void setRead_date(Timestamp read_date) {
		this.read_date = read_date;
	}	
	public RefeLineDTO(int r_line_seq, int document_seq, String emp_no, String name, String role_title, String read_yn,
			Timestamp read_date) {
		super();
		this.r_line_seq = r_line_seq;
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.name = name;
		this.role_title = role_title;
		this.read_yn = read_yn;
		this.read_date = read_date;
	}
	public RefeLineDTO() {
		super();
	}
}
