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

	// 회의실 목록을 넘겨주기 위한 메서드
	public List<MeetingRoomDTO> getMeetingRoomList() {
		return dao.getMeetingRoomList();
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
}
