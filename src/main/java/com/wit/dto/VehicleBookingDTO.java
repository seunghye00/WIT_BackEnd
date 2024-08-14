package com.wit.dto;

import java.sql.Timestamp;

public class VehicleBookingDTO {
	
	private int vehicle_booking_seq;
	private String emp_no;
	private int vehicle_seq;
	private Timestamp start_date;
	private Timestamp end_date;
	private String purpose;
	
	public int getVehicle_booking_seq() {
		return vehicle_booking_seq;
	}
	public void setVehicle_booking_seq(int vehicle_booking_seq) {
		this.vehicle_booking_seq = vehicle_booking_seq;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public int getVehicle_seq() {
		return vehicle_seq;
	}
	public void setVehicle_seq(int vehicle_seq) {
		this.vehicle_seq = vehicle_seq;
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
	
	public VehicleBookingDTO() {}
	
	public VehicleBookingDTO(int vehicle_booking_seq, String emp_no, int vehicle_seq, Timestamp start_date,
			Timestamp end_date, String purpose) {
		super();
		this.vehicle_booking_seq = vehicle_booking_seq;
		this.emp_no = emp_no;
		this.vehicle_seq = vehicle_seq;
		this.start_date = start_date;
		this.end_date = end_date;
		this.purpose = purpose;
	}
}
