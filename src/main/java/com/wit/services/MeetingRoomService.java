package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.MeetingRoomDAO;
import com.wit.dto.MeetingRoomDTO;
import com.wit.dto.RoomBookingDTO;

@Service
public class MeetingRoomService {
	
	@Autowired
	private MeetingRoomDAO dao;

	// 모든 회의실 목록을 넘겨주기 위한 메서드
	public List<MeetingRoomDTO> getMeetingRoomList() {
		return dao.getMeetingRoomList();
	}
	
	// 예약 가능한 회의실 목록을 넘겨주기 위한 메서드
	public List<MeetingRoomDTO> getMeetingRoomList(String status) {
		return dao.getMeetingRoomList(status);
	}
	
	// 해당 회의실 정보를 넘겨주기 위한 메서드
	public MeetingRoomDTO getMeetingRoomInfo(int roomSeq) {
		return dao.getMeetingRoomInfo(roomSeq);
	}

	// 회의실 예약 정보를 입력하기 위한 메서드
	public void addMeetingRoomEvent(RoomBookingDTO dto) {
		dao.addMeetingRoomEvent(dto);
	}

	// 해당 회의실의 모든 예약 정보를 넘겨주기 위한 메서드
	public List<RoomBookingDTO> getAllRoomBooking(int roomSeq) {
		return dao.getAllRoomBooking(roomSeq);
	}

	// 회의실 예약 시간이 겹치는지 확인하기 위한 메서드
	public int checkBooking(RoomBookingDTO dto) {
		return dao.checkBooking(dto);
	}

	// 해당 사원의 모든 회의실 예약 정보를 조회하기 위한 메서드
	public List<RoomBookingDTO> getAllRoomBookingByEmpNo(String empNo, int cPage) {
		return dao.getAllRoomBookingByEmpNo(empNo, cPage);
	}

	// 해당 사원의 모든 회의실 예약 정보 갯수를 조회하기 위한 메서드
	public int getCountRoomBookingList(String empNo) {
		return dao.getCountRoomBookingList(empNo);
	}

	// 해당 사원의 검색한 회의실 예약 정보를 조회하기 위한 메서드
	public List<RoomBookingDTO> getSearchRoomBookingByEmpNo(String empNo, String keyword, int cPage) {
		return dao.getSearchRoomBookingByEmpNo(empNo, keyword, cPage);
	}

	// 해당 사원의 검색한 회의실 예약 정보 갯수를 조회하기 위한 메서드
	public int getCountSearchRoomBookingList(String empNo, String keyword) {
		return dao.getCountSearchRoomBookingList(empNo, keyword);
	}

	// 해당 항목의 상태를 변경하기 위한 메서드
	public void updateStatus(int seq, String status) {
		dao.updateStatus(seq, status);	
	}

	// 해당 항목의 안내 사항을 변경하기 위한 메서드
	public void updateGuideLines(int seq, String guideLines) {
		dao.updateGuideLines(seq, guideLines);
	}
}
