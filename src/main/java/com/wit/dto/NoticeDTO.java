package com.wit.dto;

import java.sql.Timestamp;

public class NoticeDTO {
	private int notice_seq ;
	private String emp_no;
	private String title;
    private String contents;
    private Timestamp write_date;
    private int views;
	public NoticeDTO(int notice_seq, String emp_no, String title, String contents, Timestamp write_date, int views) {
		super();
		this.notice_seq = notice_seq;
		this.emp_no = emp_no;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.views = views;
	}
	public NoticeDTO() {
		super();
	}
	public int getNotice_seq() {
		return notice_seq;
	}
	public void setNotice_seq(int notice_seq) {
		this.notice_seq = notice_seq;
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
}
