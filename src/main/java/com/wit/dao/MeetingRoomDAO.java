package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.commons.BoardConfig;
import com.wit.dto.MeetingRoomDTO;
import com.wit.dto.RoomBookingDTO;

@Repository
public class MeetingRoomDAO {
	
	@Autowired
	private SqlSession mybatis;

	// 일반 사원들에게 노출할 회의실 목록을 받아오기 위한 메서드
	public List<MeetingRoomDTO> getMeetingRoomList(String status) {
		return mybatis.selectList("meetingRoom.selectAll", status);
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

	// 회의실 예약 시간이 겹치는 지 확인하는 메서드
	public int checkBooking(RoomBookingDTO dto) {
		return mybatis.selectOne("meetingRoom.checkBooking", dto);
	}

	// 해당 사원의 모든 회의실 예약 정보를 조회하기 위한 메서드
	public List<RoomBookingDTO> getAllRoomBookingByEmpNo(String empNo, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("meetingRoom.selectAllByEmpNo", params);
	}

	// 해당 사원의 모든 회의실 예약 정보 갯수를 조회하기 위한 메서드
	public int getCountRoomBookingList(String empNo) {
		return mybatis.selectOne("meetingRoom.getCountBookingList", empNo);
	}

	// 해당 사원의 검색한 회의실 예약 정보를 조회하기 위한 메서드
	public List<RoomBookingDTO> getSearchRoomBookingByEmpNo(String empNo, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("meetingRoom.selectSearchListByEmpNo", params);
	}

	// 해당 사원의 검색한 회의실 예약 정보 갯수를 조회하기 위한 메서드
	public int getCountSearchRoomBookingList(String empNo, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("keyword", keyword);
		return mybatis.selectOne("meetingRoom.getSearchCountBookingList", params);
	}
}
