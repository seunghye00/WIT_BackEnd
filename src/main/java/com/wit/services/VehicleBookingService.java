package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.VehicleBookingDAO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.VehicleBookingDTO;
import com.wit.dto.VehiclesDTO;

@Service
public class VehicleBookingService {

	@Autowired
	private VehicleBookingDAO dao;
	
	// 차량 목록을 넘겨주기 위한 메서드
	public List<VehiclesDTO> getVehicleList() {
		return dao.getVehicleList();
	}
	
	// 해당 차량 정보 넘겨주기 위한 메서드
	public VehiclesDTO getVehicleInfo(int vehicleSeq) {
		return dao.getVehicleInfo(vehicleSeq);
	}

	// 차량 예약 추가
	public int saveVehicle(VehicleBookingDTO dto) {
		return dao.saveVehicle(dto);
	}

	// 차량 예약 정보 조회
	public List<VehicleBookingDTO> getAllVehicleBooking(String vehicleSeq){
		return dao.getAllVehicleBooking(vehicleSeq);
	}

	// 직원 정보 조회
	public EmployeeDTO employeeInfo(String empNo) {
		return dao.employeeInfo(empNo);
	}
}
