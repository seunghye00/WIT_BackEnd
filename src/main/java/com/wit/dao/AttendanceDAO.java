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
		Map<String, Integer> result = mybatis.selectOne("attendance.getMonthlyStatus", emp_no);
		System.out.println("DAO: " + result);
		return result;
	}

	// 월간 근무시간 조회
	public Map<String, Object> getMonthlyWorkHours(String emp_no) {
		Map<String, Object> result = mybatis.selectOne("attendance.getMonthlyWorkHours", emp_no);
		return result;
	}

	// 주간 근무현황 조회
	public List<Map<String, Object>> getWeeklyStatus(String emp_no) {
		return mybatis.selectList("attendance.getWeeklyStatus", emp_no);
	}

	// 월간 근무현황 조회
	public List<Map<String, Object>> getMonthlyWorkStatus(String emp_no, String month) {
		Map<String, String> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("month", month);
		return mybatis.selectList("attendance.getMonthlyWorkStatus", params);
	}

	// 결근
	public void markAbsence(String emp_no, java.sql.Date work_date) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("work_date", work_date);
		mybatis.update("attendance.markAbsence", params);
	}
}
