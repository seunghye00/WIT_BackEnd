package com.wit.dto;

import java.sql.Timestamp;

// 회의실 예약 정보에 대한 데이터를 보관하기 위한 DTO
public class RoomBookingDTO {
	private int room_booking_seq;
	private String emp_no;
	private String dept_title;
	private int room_seq;
	private Timestamp start_date;
	private Timestamp end_date;
	private String purpose;
	public int getRoom_booking_seq() {
		return room_booking_seq;
	}
	public void setRoom_booking_seq(int room_booking_seq) {
		this.room_booking_seq = room_booking_seq;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getDept_title() {
		return dept_title;
	}
	public void setDept_title(String dept_title) {
		this.dept_title = dept_title;
	}
	public int getRoom_seq() {
		return room_seq;
	}
	public void setRoom_seq(int room_seq) {
		this.room_seq = room_seq;
	}
	public Timestamp getStart_date() {
		return start_date;
	}
	public void setStart_date(Timestamp start_date) {
		this.start_date = start_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public RoomBookingDTO(int room_booking_seq, String emp_no, String dept_title, int room_seq, Timestamp start_date,
			Timestamp end_date, String purpose) {
		super();
		this.room_booking_seq = room_booking_seq;
		this.emp_no = emp_no;
		this.dept_title = dept_title;
		this.room_seq = room_seq;
		this.start_date = start_date;
		this.end_date = end_date;
		this.purpose = purpose;
	}
	public RoomBookingDTO() {
		super();
	}
}