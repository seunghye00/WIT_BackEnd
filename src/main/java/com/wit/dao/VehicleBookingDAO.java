package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.commons.BoardConfig;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.VehicleBookingDTO;
import com.wit.dto.VehiclesDTO;

@Repository
public class VehicleBookingDAO {
	
	@Autowired
	private SqlSession mybatis;
	
	// 차량별 예약 목록
	public List<VehiclesDTO> getVehicleList() {
		return mybatis.selectList("vehicleBooking.getVehicleList");
	}
	
	// 해당 차량 정보 받아오기
	public VehiclesDTO getVehicleInfo(int vehicleSeq) {
		return mybatis.selectOne("vehicleBooking.getVehicleInfo", vehicleSeq);
	}
	
	// 차량 예약 추가
	public int saveVehicle(VehicleBookingDTO dto) {
		return mybatis.insert("vehicleBooking.vehicleBookingInsert", dto);
	}
	
	// 차량 예약 목록 조회
	public List<VehicleBookingDTO> getAllVehicleBooking(String vehicleSeq){
		return mybatis.selectList("vehicleBooking.getAllVehicleBooking", Integer.parseInt(vehicleSeq));
	}
	
	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String empNo) {
		return mybatis.selectOne("vehicleBooking.employeeInfo", empNo);
	}

	// 차량 목록 조회
	public List<VehiclesDTO> getVehicleList(String status) {
		return mybatis.selectList("vehicleBooking.selectAllVehicleList", status);
	}

	// 해당 사원의 모든 차량 예약 정보 목록 조회
	public List<VehicleBookingDTO> getAllVehicleBookingByEmpNo(String empNo, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("vehicleBooking.selectAllByEmpNo", params);
	}

	// 해당 사원의 모든 차량 예약 정보 목록 총 갯수 조회
	public int getCountVehicleList(String empNo) {
		return mybatis.selectOne("vehicleBooking.getCountBookingList", empNo);
	}

	// 해당 사원의 검색한 차량 예약 정보 목록 조회
	public List<VehiclesDTO> getSearchVehicleBookingByEmpNo(String empNo, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("vehicleBooking.selectSearchListByEmpNo", params);
	}
	
	// 해당 사원의 검색한 차량 예약 정보 목록 총 갯수 조회
	public int getCountSearchVehicleList(String empNo, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("keyword", keyword);
		return mybatis.selectOne("vehicleBooking.getCountSearchBookingList", params);
	}
}
