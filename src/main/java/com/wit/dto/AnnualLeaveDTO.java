package com.wit.dto;

// 각 사원의 연차에 대한 데이터를 보관하기 위한 DTO
public class AnnualLeaveDTO {
	private String emp_no; // 사번
	private int annual_leave_num; // 연차 갯수
	private float use_num; // 사용 연차 갯수
	private float remaining_leaves; // 남은 연차 갯수
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public int getAnnual_leave_num() {
		return annual_leave_num;
	}
	public void setAnnual_leave_num(int annual_leave_num) {
		this.annual_leave_num = annual_leave_num;
	}
	public float getUse_num() {
		return use_num;
	}
	public void setUse_num(float use_num) {
		this.use_num = use_num;
	}
	public float getRemaining_leaves() {
		return remaining_leaves;
	}
	public void setRemaining_leaves(float remaining_leaves) {
		this.remaining_leaves = remaining_leaves;
	}
	public AnnualLeaveDTO(String emp_no, int annual_leave_num, float use_num, float remaining_leaves) {
		super();
		this.emp_no = emp_no;
		this.annual_leave_num = annual_leave_num;
		this.use_num = use_num;
		this.remaining_leaves = remaining_leaves;
	}
	public AnnualLeaveDTO() {
		super();
	}
}