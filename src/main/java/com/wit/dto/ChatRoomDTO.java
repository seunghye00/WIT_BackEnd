package com.wit.dto;

import java.sql.Timestamp;

public class ChatRoomDTO {
	private int chat_room_seq;
	private String room_type; // "1:1" 또는 "GROUP"
	private Timestamp created_date;

	public ChatRoomDTO() {
		super();
	}

	public ChatRoomDTO(int chat_room_seq, String room_type, Timestamp created_date) {
		super();
		this.chat_room_seq = chat_room_seq;
		this.room_type = room_type;
		this.created_date = created_date;
	}

	public int getChat_room_seq() {
		return chat_room_seq;
	}

	public void setChat_room_seq(int chat_room_seq) {
		this.chat_room_seq = chat_room_seq;
	}

	public String getRoom_type() {
		return room_type;
	}

	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}

	public Timestamp getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}

}
