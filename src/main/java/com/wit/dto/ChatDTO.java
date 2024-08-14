package com.wit.dto;

import java.sql.Timestamp;

public class ChatDTO {
	private int chat_seq;
	private int chat_room_seq;
	private String name;
	private String sender;
	private String message;
	private Timestamp send_time;
	private int read_count;

	public ChatDTO() {
		super();
	}

	public ChatDTO(int chat_seq, int chat_room_seq, String name, String sender, String message, Timestamp send_time,
			int read_count) {
		super();
		this.chat_seq = chat_seq;
		this.chat_room_seq = chat_room_seq;
		this.name = name;
		this.sender = sender;
		this.message = message;
		this.send_time = send_time;
		this.read_count = read_count;
	}

	public int getChat_seq() {
		return chat_seq;
	}

	public void setChat_seq(int chat_seq) {
		this.chat_seq = chat_seq;
	}

	public int getChat_room_seq() {
		return chat_room_seq;
	}

	public void setChat_room_seq(int chat_room_seq) {
		this.chat_room_seq = chat_room_seq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getSend_time() {
		return send_time;
	}

	public void setSend_time(Timestamp send_time) {
		this.send_time = send_time;
	}

	public int getRead_count() {
		return read_count;
	}

	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}

}
