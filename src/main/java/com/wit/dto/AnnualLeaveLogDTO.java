package com.wit.dto;

// 연차 사용 내역에 대한 데이터를 보관하기 위한 DTO
public class AnnualLeaveLogDTO {
	private int log_seq;
	private String emp_no;
	private int annual_leave_seq;
	private int document_seq;

	public AnnualLeaveLogDTO(int log_seq, String emp_no, int annual_leave_seq, int document_seq) {
		super();
		this.log_seq = log_seq;
		this.emp_no = emp_no;
		this.annual_leave_seq = annual_leave_seq;
		this.document_seq = document_seq;
	}

	public AnnualLeaveLogDTO() {
		super();
	}

	public int getLog_seq() {
		return log_seq;
	}

	public void setLog_seq(int log_seq) {
		this.log_seq = log_seq;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public int getAnnual_leave_seq() {
		return annual_leave_seq;
	}

	public void setAnnual_leave_seq(int annual_leave_seq) {
		this.annual_leave_seq = annual_leave_seq;
	}

	public int getDocument_seq() {
		return document_seq;
	}

	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
	}
}