package com.wit.dto;

// 예약 시스템에서 조회할 회의실에 대한 정보를 보관하기 위한 DTO
public class MeetingRoomDTO {
	private int room_seq;
	private String name;
	private String location;
	private int capacity;
	private String status;
	public int getRoom_seq() {
		return room_seq;
	}
	public void setRoom_seq(int room_seq) {
		this.room_seq = room_seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public MeetingRoomDTO(int room_seq, String name, String location, int capacity, String status) {
		super();
		this.room_seq = room_seq;
		this.name = name;
		this.location = location;
		this.capacity = capacity;
		this.status = status;
	}
	public MeetingRoomDTO(int room_seq, String name) {
		super();
		this.room_seq = room_seq;
		this.name = name;
	}
	public MeetingRoomDTO() {
		super();
	}
}
