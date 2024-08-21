package com.wit.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.AttendanceDTO;
import com.wit.dto.DeptDTO;
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
	public AttendanceDTO selectAtd(String emp_no, Date work_date) {
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
	public Map<String, Integer> monthlyStatus(String emp_no) {
		Map<String, Integer> result = mybatis.selectOne("attendance.monthlyStatus", emp_no);
		return result;
	}

	// 월간 근무시간 조회
	public Map<String, Object> monthlyWorkHours(String emp_no) {
		Map<String, Object> result = mybatis.selectOne("attendance.monthlyWorkHours", emp_no);
		return result;
	}

	// 주간 근무현황 조회
	public List<Map<String, Object>> weeklyStatus(String emp_no) {
		return mybatis.selectList("attendance.weeklyStatus", emp_no);
	}

	// 월간 레코드 수 조회
	public int monthlyRecordCount(String empNo, String month) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("month", month);
		return mybatis.selectOne("attendance.monthlyRecordCount", params);
	}

	// 월간 근무현황 조회 (페이징 적용)
	public List<Map<String, Object>> monthlyWorkStatus(String empNo, String month, int start, int end) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("month", month);
		params.put("start", start);
		params.put("end", end);
		return mybatis.selectList("attendance.monthlyWorkStatus", params);
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

	// 부서별 근태현황(관리자) 조회 (페이징 적용)
	public List<Map<String, Object>> deptAtd(Map<String, Object> params) {
	    return mybatis.selectList("attendance.deptAtd", params);
	}

    // 부서의 총 직원 수를 가져옴
    public int getDeptEmployeeCount(String deptTitle) {
        return mybatis.selectOne("attendance.getDeptEmployeeCount", deptTitle);
    }

	// 부서 조회
	public List<DeptDTO> getAllDepartments() {
		return mybatis.selectList("attendance.AllDepts");
	}
}
