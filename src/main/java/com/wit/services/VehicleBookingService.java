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

	// 예약 가능한 차량 목록 조회
	public List<VehiclesDTO> getVehicleList(String status) {
		return dao.getVehicleList(status);
	}

	// 해당 사원의 모든 차량 예약 정보 목록 조회
	public List<VehicleBookingDTO> getAllVehicleBookingByEmpNo(String empNo, int cPage) {
		return dao.getAllVehicleBookingByEmpNo(empNo, cPage);
	}

	// 해당 사원의 모든 차량 예약 정보 목록 총 갯수 조회
	public int getCountVehicleList(String empNo) {
		return dao.getCountVehicleList(empNo);
	}

	// 해당 사원의 검색한 차량 예약 정보 목록 조회
	public List<VehiclesDTO> getSearchVehicleBookingByEmpNo(String empNo, String keyword, int cPage) {
		return dao.getSearchVehicleBookingByEmpNo(empNo, keyword, cPage);
	}
	
	// 해당 사원의 검색한 차량 예약 정보 목록 총 갯수 조회
	public int getCountSearchVehicleList(String empNo, String keyword) {
		return dao.getCountSearchVehicleList(empNo, keyword);
	}

	// 해당 항목의 상태를 변경
	public void updateStatus(int seq, String status) {
		System.out.println("서비스");
		dao.updateStatus(seq, status);
	}

	// 해당 항목의 안내 사항을 변경하기 위한 메서드
	public void updateGuideLines(int seq, String guideLines) {
		dao.updateGuideLines(seq, guideLines);
	}
}
