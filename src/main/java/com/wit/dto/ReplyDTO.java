package com.wit.dto;

import java.sql.Timestamp;

public class ReplyDTO {
	private int reply_seq;
	private int board_seq;
	private String emp_no;
	private String contents;
	private Timestamp write_date;
	
	public ReplyDTO() {
		super();
	}

	public ReplyDTO(int reply_seq, int board_seq, String emp_no, String contents, Timestamp write_date) {
		super();
		this.reply_seq = reply_seq;
		this.board_seq = board_seq;
		this.emp_no = emp_no;
		this.contents = contents;
		this.write_date = write_date;
	}

	public int getReply_seq() {
		return reply_seq;
	}

	public void setReply_seq(int reply_seq) {
		this.reply_seq = reply_seq;
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
	
	
}
