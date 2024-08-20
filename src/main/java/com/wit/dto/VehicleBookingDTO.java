package com.wit.dto;

import java.sql.Timestamp;

public class VehicleBookingDTO {
//	여기서 name은 이벤트에 사원 이름을 출력하기 위해 employee 테이블 emp_no과 join함
	private int vehicle_booking_seq;
	private String emp_no;
	private String dept_title;
	private String name;
	private String license_plate;
	private int vehicle_seq;
	private Timestamp start_date;
	private Timestamp end_date;
	private String passenger;
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
	public String getDept_title() {
		return dept_title;
	}
	public void setDept_title(String dept_title) {
		this.dept_title = dept_title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLicense_plate() {
		return license_plate;
	}
	public void setLicense_plate(String license_plate) {
		this.license_plate = license_plate;
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
	public String getPassenger() {
		return passenger;
	}
	public void setPassenger(String passenger) {
		this.passenger = passenger;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public VehicleBookingDTO(int vehicle_booking_seq, String emp_no, String dept_title, String name,
			String license_plate, int vehicle_seq, Timestamp start_date, Timestamp end_date, String passenger,
			String purpose) {
		super();
		this.vehicle_booking_seq = vehicle_booking_seq;
		this.emp_no = emp_no;
		this.dept_title = dept_title;
		this.name = name;
		this.license_plate = license_plate;
		this.vehicle_seq = vehicle_seq;
		this.start_date = start_date;
		this.end_date = end_date;
		this.passenger = passenger;
		this.purpose = purpose;
	}
	public VehicleBookingDTO() {
		super();
	}
}
