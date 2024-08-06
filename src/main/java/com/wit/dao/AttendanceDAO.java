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
import com.wit.dto.EmployeeDTO;

@Repository
public class AttendanceDAO {

	@Autowired
	private SqlSession mybatis;

	// 출근하기
	public void startAtd(AttendanceDTO dto) {
		mybatis.insert("attendance.startAtd", dto);
	}

	// 특정 직원의 특정 날짜 출근 정보를 조회
	// 출근 및 퇴근 시간 조회(메인 페이지)
	public AttendanceDTO selectAtd(@Param("emp_no") String emp_no, @Param("work_date") Date work_date) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("work_date", work_date);
		return mybatis.selectOne("attendance.selectAtd", params);
	}

	// 퇴근하기
	public void endAtd(AttendanceDTO dto) {
		mybatis.update("attendance.endAtd", dto);
	}

	// 월간 근태현황 조회
	public Map<String, Integer> MonthlyStatus(String emp_no) {
		Map<String, Integer> result = mybatis.selectOne("attendance.MonthlyStatus", emp_no);
		System.out.println("DAO: " + result);
		return result;
	}

	// 월간 근무시간 조회
	public Map<String, Object> MonthlyWorkHours(String emp_no) {
		Map<String, Object> result = mybatis.selectOne("attendance.MonthlyWorkHours", emp_no);
		return result;
	}

	// 주간 근무현황 조회
	public List<Map<String, Object>> WeeklyStatus(String emp_no) {
		return mybatis.selectList("attendance.WeeklyStatus", emp_no);
	}

	// 월간 근무현황 조회
	public List<Map<String, Object>> MonthlyWorkStatus(String emp_no, String month) {
		Map<String, String> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("month", month);
		return mybatis.selectList("attendance.MonthlyWorkStatus", params);
	}

	// 결근
	public void markAbsence(String emp_no, java.sql.Date work_date) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("work_date", work_date);
		mybatis.update("attendance.markAbsence", params);
	}

	// 직원 정보 조회 메소드 추가
    public EmployeeDTO employeeInfo(String emp_no) {
        return mybatis.selectOne("attendance.employeeInfo", emp_no);
    }
}
