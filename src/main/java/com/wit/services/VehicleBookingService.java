package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.VehicleBookingDAO;
import com.wit.dto.VehicleBookingDTO;
import com.wit.dto.VehiclesDTO;

@Service
public class VehicleBookingService {
	
	@Autowired
	private VehicleBookingDAO dao;
	
	public VehiclesDTO reservVehicle(int vehicleSeq) {
		return dao.reservVehicle(vehicleSeq);
	}
	
	// 차량 예약 추가
	public int saveVehicle(VehicleBookingDTO dto) {
		return dao.saveVehicle(dto);
	}
	
	// 차량 예약 정보 조회
	public List<VehicleBookingDTO> getAll(String vehicleSeq){
		return dao.getAll(vehicleSeq);
	}
}
