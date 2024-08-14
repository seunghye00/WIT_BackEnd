package com.wit.dto;

import java.sql.Date;

// 각 사원의 연차에 대한 데이터를 보관하기 위한 DTO
public class AnnualLeaveDTO {
	private int annual_leave_seq; // 연차 SEQ
	private String emp_no; // 사번
	private Date create_at; // 연차 생성일
	private int annual_leave_num; // 연차 갯수
	private int use_num; // 사용 연차 갯수
	private int remaining_leaves; // 남은 연차 갯수

	public AnnualLeaveDTO(int annual_leave_seq, String emp_no, Date create_at, int annual_leave_num, int use_num,
			int remaining_leaves) {
		super();
		this.annual_leave_seq = annual_leave_seq;
		this.emp_no = emp_no;
		this.create_at = create_at;
		this.annual_leave_num = annual_leave_num;
		this.use_num = use_num;
		this.remaining_leaves = remaining_leaves;
	}

	public AnnualLeaveDTO() {
		super();
	}

	public int getAnnual_leave_seq() {
		return annual_leave_seq;
	}

	public void setAnnual_leave_seq(int annual_leave_seq) {
		this.annual_leave_seq = annual_leave_seq;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public Date getCreate_at() {
		return create_at;
	}

	public void setCreate_at(Date create_at) {
		this.create_at = create_at;
	}

	public int getAnnual_leave_num() {
		return annual_leave_num;
	}

	public void setAnnual_leave_num(int annual_leave_num) {
		this.annual_leave_num = annual_leave_num;
	}

	public int getUse_num() {
		return use_num;
	}

	public void setUse_num(int use_num) {
		this.use_num = use_num;
	}

	public int getRemaining_leaves() {
		return remaining_leaves;
	}

	public void setRemaining_leaves(int remaining_leaves) {
		this.remaining_leaves = remaining_leaves;
	}
}