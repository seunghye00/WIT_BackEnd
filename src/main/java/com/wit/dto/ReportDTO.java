package com.wit.dto;

import java.sql.Timestamp;

public class ReportDTO {    
    private int report_seq;
    private int board_seq;
    private String emp_no;
    private String report_type;
    private Timestamp report_date;
	public ReportDTO(int report_seq, int board_seq, String emp_no, String report_type, Timestamp report_date) {
		super();
		this.report_seq = report_seq;
		this.board_seq = board_seq;
		this.emp_no = emp_no;
		this.report_type = report_type;
		this.report_date = report_date;
	}
	public ReportDTO() {
		super();
	}
	public int getReport_seq() {
		return report_seq;
	}
	public void setReport_seq(int report_seq) {
		this.report_seq = report_seq;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public Timestamp getReport_date() {
		return report_date;
	}
	public void setReport_date(Timestamp report_date) {
		this.report_date = report_date;
	}
    
    
    
}
