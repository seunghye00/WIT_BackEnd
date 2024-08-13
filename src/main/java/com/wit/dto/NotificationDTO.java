package com.wit.dto;

import java.sql.Timestamp;

public class NotificationDTO {
	private int noti_seq;
	private String emp_no;
	private int chat_seq;
	private String noti_text;
	private Timestamp create_date;

	public NotificationDTO(int noti_seq, String emp_no, int chat_seq, String noti_text, Timestamp create_date) {
		super();
		this.noti_seq = noti_seq;
		this.emp_no = emp_no;
		this.chat_seq = chat_seq;
		this.noti_text = noti_text;
		this.create_date = create_date;
	}

	public NotificationDTO() {
		super();
	}

	public int getNoti_seq() {
		return noti_seq;
	}

	public void setNoti_seq(int noti_seq) {
		this.noti_seq = noti_seq;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public int getChat_seq() {
		return chat_seq;
	}

	public void setChat_seq(int chat_seq) {
		this.chat_seq = chat_seq;
	}

	public String getNoti_text() {
		return noti_text;
	}

	public void setNoti_text(String noti_text) {
		this.noti_text = noti_text;
	}

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

}
