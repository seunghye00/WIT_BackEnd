package com.wit.dto;

import java.util.List;

public class ChatRoomGroupDTO {
	private String chatRoomName;
	private List<String> empNos;

	public ChatRoomGroupDTO() {
		super();
	}

	public ChatRoomGroupDTO(String chatRoomName, List<String> empNos) {
		super();
		this.chatRoomName = chatRoomName;
		this.empNos = empNos;
	}

	public String getChatRoomName() {
		return chatRoomName;
	}

	public void setChatRoomName(String chatRoomName) {
		this.chatRoomName = chatRoomName;
	}

	public List<String> getEmpNos() {
		return empNos;
	}

	public void setEmpNos(List<String> empNos) {
		this.empNos = empNos;
	}

}
