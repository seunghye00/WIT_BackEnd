package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.wit.dto.AttendanceDTO;

@Repository
public class AttendanceDAO {

	@Autowired
	private SqlSession mybatis;

	// 출근하기
	public void startAtd(AttendanceDTO dto) {
		mybatis.insert("attendance.startAtd", dto);
	}

	// 특정 직원의 특정 날짜 출근 정보를 조회
	public AttendanceDTO select(@Param("emp_no") String emp_no, @Param("work_date") Date work_date) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("work_date", work_date);
		return mybatis.selectOne("attendance.select", params);
	}

	// 퇴근하기
	public void endAtd(AttendanceDTO dto) {
		mybatis.update("attendance.endAtd", dto);
	}

	// 월간 근태현황 조회
	public Map<String, Integer> getMonthlyStatus(String emp_no) {
		return mybatis.selectOne("attendance.getMonthlyStatus", emp_no);
	}

	// 월간 근무시간 조회
	public Map<String, Object> getMonthlyWorkHours(String emp_no) {
		Map<String, Object> result = mybatis.selectOne("attendance.getMonthlyWorkHours", emp_no);
		return result;
	}

	// 주간 근무현황 조회
	public List<AttendanceDTO> getWeeklyWorkStatus(@Param("emp_no") String emp_no,
			@Param("start_date") String start_date, @Param("end_date") String end_date) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("start_date", start_date);
		params.put("end_date", end_date);
		List<AttendanceDTO> result = mybatis.selectList("attendance.getWeeklyWorkStatus", params);
		System.out.println("DAO : " + result);
		return result;
	}
}
