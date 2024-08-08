package com.wit.dto;

import java.sql.Timestamp;

public class ChatRoomDTO {
	private int chat_room_seq;
	private String emp_no;
	private String chat_room_name;
	private String chat_room_code;
	private String created_by;
	private Timestamp create_date;
	private int is_read;

	public ChatRoomDTO(int chat_room_seq, String emp_no, String chat_room_name, String chat_room_code,
			String created_by, Timestamp create_date, int is_read) {
		super();
		this.chat_room_seq = chat_room_seq;
		this.emp_no = emp_no;
		this.chat_room_name = chat_room_name;
		this.chat_room_code = chat_room_code;
		this.created_by = created_by;
		this.create_date = create_date;
		this.is_read = is_read;
	}

	public ChatRoomDTO() {
		super();
	}

	public int getChat_room_seq() {
		return chat_room_seq;
	}

	public void setChat_room_seq(int chat_room_seq) {
		this.chat_room_seq = chat_room_seq;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getChat_room_name() {
		return chat_room_name;
	}

	public void setChat_room_name(String chat_room_name) {
		this.chat_room_name = chat_room_name;
	}

	public String getChat_room_code() {
		return chat_room_code;
	}

	public void setChat_room_code(String chat_room_code) {
		this.chat_room_code = chat_room_code;
	}

	public String getCreated_by() {
		return created_by;
	}

	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

	public int getIs_read() {
		return is_read;
	}

	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}
}
