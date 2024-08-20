package com.wit.dto;

import java.sql.Timestamp;

public class BoardReportDTO {
	private int board_seq;
	private String emp_no;
	private String title;
	private String contents;
	private Timestamp write_date;
	private int views;
	private int board_code;
	private String report_type=null;
	private Timestamp report_date=null;
	private int count ;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getBoard_code() {
		return board_code;
	}
	public void setBoard_code(int board_code) {
		this.board_code = board_code;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public BoardReportDTO(int board_seq, String emp_no, String title, String contents, Timestamp write_date, int views,
			int board_code, String report_type, Timestamp report_date, int count) {
		super();
		this.board_seq = board_seq;
		this.emp_no = emp_no;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.views = views;
		this.board_code = board_code;
		this.report_type = report_type;
		this.report_date = report_date;
		this.count = count;
	}
	public BoardReportDTO() {
		super();
	}
	
	
	
	
}
