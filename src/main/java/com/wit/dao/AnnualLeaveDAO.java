package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.AnnualLeaveDTO;
import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.LeaveRequestDTO;

@Repository
public class AnnualLeaveDAO {

	@Autowired
	private SqlSession mybatis;

	// 직원의 연차 정보를 조회
	public AnnualLeaveDTO getAnnualLeaveByEmpNo(String empNo) {
		return mybatis.selectOne("annualLeave.selectAnnualLeaveByEmpNo", empNo);
	}

	// 연차 데이터 삽입 또는 업데이트 (MERGE INTO 사용)
	public void insertOrUpdateAnnualLeave(String empNo) {
		mybatis.insert("annualLeave.insertOrUpdateAnnualLeave", empNo);
	}

	// 직원 정보 조회
	public EmployeeDTO employeeInfo(String empNo) {
		return mybatis.selectOne("annualLeave.employeeInfo", empNo);
	}

	// document_seq로 emp_no를 조회하는 메서드 추가
	public String getEmpNoByDocumentSeq(int documentSeq) {
		return mybatis.selectOne("annualLeave.selectEmpNoByDocumentSeq", documentSeq);
	}

	// 해당 직원의 남은 연차 갯수 조회
	public int getRemainingLeavesByEmpNo(String empNo) {
		return mybatis.selectOne("annualLeave.getRemainingLeaves", empNo);
	}

	// 해당 직원의 연차 정보 업데이트
	public void updateByAnnualLeave(String empNo, float useNum) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("useNum", useNum);
		mybatis.update("annualLeave.updateByAnnualLeave", params);
	}

	// 연차 사용 정보 기록
	public void insertAnnualLeaveLog(String empNo, int docuSeq) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuSeq", docuSeq);
		mybatis.insert("annualLeave.insertAnnualLeaveLog", params);
	}

	// 연간 휴가 내역의 총 레코드 수 조회
	public int annualLeaveRecordCount(String empNo) {
		return mybatis.selectOne("annualLeave.annualLeaveRecordCount", empNo);
	}

	// 연간 휴가 내역을 페이징하여 조회
	public List<LeaveRequestDTO> selectAnnualLeaveRequests(String empNo, int start, int end) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("start", start);
		params.put("end", end);
		return mybatis.selectList("annualLeave.selectAnnualLeaveRequests", params);
	}

	// 부서별 휴가내역 (관리자)
	public List<Map<String, Object>> selectAnnualLeaveRequestsByDept(String deptTitle, String searchTxt, int start,
			int end) {
		Map<String, Object> params = new HashMap<>();
		params.put("deptTitle", deptTitle);
		params.put("searchTxt", searchTxt);
		params.put("start", start);
		params.put("end", end);

		return mybatis.selectList("annualLeave.selectAnnualLeaveRequestsByDept", params);
	}

	// 검색된 연간 휴가 내역의 총 레코드 수 조회
	public int annualLeaveRecordCountByDept(String deptTitle, String searchTxt) {
		Map<String, Object> params = new HashMap<>();
		params.put("deptTitle", deptTitle);
		params.put("searchTxt", searchTxt);

		return mybatis.selectOne("annualLeave.annualLeaveRecordCountByDept", params);
	}

	// 부서 리스트 조회
	public List<DeptDTO> getDepartments() {
		return mybatis.selectList("annualLeave.selectAllDepartments");
	}
}
