package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.VehicleBookingDTO;
import com.wit.dto.VehiclesDTO;

@Repository
public class VehicleBookingDAO {
	
	@Autowired
	private SqlSession mybatis;
	
	// 차량별 예약 목록
	public VehiclesDTO reservVehicle(int vehicleSeq) {
		return mybatis.selectOne("vehicleBooking.reservVehicle", vehicleSeq);
	}
	
	// 차량 예약 추가
	public int saveVehicle(VehicleBookingDTO dto) {
		return mybatis.insert("vehicleBooking.vehicleBookingInsert", dto);
	}
	
	// 차량 예약 목록 조회
	public List<VehicleBookingDTO> getAll(String vehicleSeq){
		return mybatis.selectList("vehicleBooking.getAll", Integer.parseInt(vehicleSeq));
	}
}
