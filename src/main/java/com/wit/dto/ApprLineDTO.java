package com.wit.dto;

import java.sql.Timestamp;

// 각 결재자에 대한 정보를 보관하기 위한 DTO
public class ApprLineDTO {
	private int a_line_seq;
	private int document_seq;
	private String emp_no;
	private String comments;
	private String status;
	private int approval_order;
	private Timestamp approval_date;
	public int getA_line_seq() {
		return a_line_seq;
	}
	public void setA_line_seq(int a_line_seq) {
		this.a_line_seq = a_line_seq;
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
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getApproval_order() {
		return approval_order;
	}
	public void setApproval_order(int approval_order) {
		this.approval_order = approval_order;
	}
	public Timestamp getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(Timestamp approval_date) {
		this.approval_date = approval_date;
	}
	public ApprLineDTO(int a_line_seq, int document_seq, String emp_no, String comments, String status,
			int approval_order, Timestamp approval_date) {
		super();
		this.a_line_seq = a_line_seq;
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.comments = comments;
		this.status = status;
		this.approval_order = approval_order;
		this.approval_date = approval_date;
	}
	public ApprLineDTO(int document_seq, String emp_no, String status, int approval_order) {
		super();
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.status = status;
		this.approval_order = approval_order;
	}
	public ApprLineDTO() {
		super();
	}
}
