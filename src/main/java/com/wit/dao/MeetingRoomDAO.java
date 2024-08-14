package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.MeetingRoomDTO;
import com.wit.dto.RoomBookingDTO;

@Repository
public class MeetingRoomDAO {
	
	@Autowired
	private SqlSession mybatis;

	// 일반 사원들에게 노출할 회의실 목록을 받아오기 위한 메서드
	public List<MeetingRoomDTO> getMeetingRoomList() {
		return mybatis.selectList("meetingRoom.selectAll");
	}
	
	// 해당 회의실의 정보를 받아오기 위한 메서드
	public MeetingRoomDTO getMeetingRoomInfo(int roomSeq) {
		return mybatis.selectOne("meetingRoom.selectBySeq", roomSeq);
	}
	
	// 회의실 예약 정보를 입력하기 위한 메서드
	public void addMeetingRoomEvent(RoomBookingDTO dto) {
		mybatis.insert("meetingRoom.insert", dto);
	}
	
	// 해당 회의실의 모든 예약 정보를 받아오기 위한 메서드
	public List<RoomBookingDTO> getAllRoomBooking(int roomSeq) {
		return mybatis.selectList("meetingRoom.selectAllBySeq", roomSeq);
	}
}
