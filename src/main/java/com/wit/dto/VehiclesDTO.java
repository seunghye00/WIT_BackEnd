package com.wit.dto;

public class VehiclesDTO {
	
	private int vehicle_seq;
	private String name;
	private int license_plate;
	private String status;
	
	public int getVehicle_seq() {
		return vehicle_seq;
	}
	public void setVehicle_seq(int vehicle_seq) {
		this.vehicle_seq = vehicle_seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getLicense_plate() {
		return license_plate;
	}
	public void setLicense_plate(int license_plate) {
		this.license_plate = license_plate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public VehiclesDTO() {}
	
	public VehiclesDTO(int vehicle_seq, String name, int license_plate, String status) {
		super();
		this.vehicle_seq = vehicle_seq;
		this.name = name;
		this.license_plate = license_plate;
		this.status = status;
	}
}
