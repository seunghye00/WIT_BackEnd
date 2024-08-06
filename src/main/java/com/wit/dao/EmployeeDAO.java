package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.EmployeeDTO;
import com.wit.dto.RoleDTO;
import com.wit.dto.DeptDTO;

@Repository
public class EmployeeDAO {

	@Autowired
	private SqlSession mybatis;

	// 모든 직급 정보 가져오기
	public List<RoleDTO> AllRoles() {
		return mybatis.selectList("employee.AllRoles");
	}

	// 모든 부서 정보 가져오기
	public List<DeptDTO> AllDepts() {
		return mybatis.selectList("employee.AllDepts");
	}
	
	// 입사 순서대로 부서코드 생성을 위한 DB 조회 (사번 생성)
	public String getHighestEmployeeIDByDept(String dept) {
		return mybatis.selectOne("employee.getHighestEmployeeIDByDept", dept);
	}

	// 회원가입
	public int register(EmployeeDTO dto) {
		return mybatis.insert("employee.register", dto);
	}

	// 로그인
	public EmployeeDTO login(String emp_no, String pw) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("pw", pw);
		return mybatis.selectOne("employee.login", params);
	}
	
	// 추가 정보 업데이트 를 위한 직원 정보 조회
	public EmployeeDTO findByEmpNo(String empNo) {
		return mybatis.selectOne("employee.findByEmpNo", empNo);
	}
	
	// 추가 정보 업데이트
	public int updateInfo(EmployeeDTO dto) {
		return mybatis.update("employee.updateInfo", dto);
	}

	// ID찾기
	public EmployeeDTO findID(String name, String ssn) {
		Map<String, Object> params = new HashMap<>();
		params.put("name", name);
		params.put("ssn", ssn);
		return mybatis.selectOne("employee.findID", params);
	}

	// PW찾기를 위한 직원 정보 확인
	public EmployeeDTO findEmployee(String empNo, String name, String ssn) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", empNo);
		params.put("name", name);
		params.put("ssn", ssn);
		return mybatis.selectOne("employee.findEmployee", params);
	}

	// PW찾기 (수정)
	public int modifyPassword(String empNo, String newPassword) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", empNo);
		params.put("newPassword", newPassword);
		return mybatis.update("employee.modifyPassword", params);
	}
	
	// 닉네임 중복 체크(마이페이지)
	public int checkNickname(String nickname) {
		return mybatis.selectOne("employee.checkNickname", nickname);
	}

	// 마이페이지 정보 업데이트 - 비밀번호
	public int updatePassword(EmployeeDTO dto) {
		return mybatis.update("employee.updatePassword", dto);
	}

	// 마이페이지 정보 업데이트 - 닉네임
	public int updateNickname(EmployeeDTO dto) {
		return mybatis.update("employee.updateNickname", dto);
	}

	// 회원탈퇴
	public int delete(String emp_no) {
		return mybatis.delete("employee.delete", emp_no);
	}

}
