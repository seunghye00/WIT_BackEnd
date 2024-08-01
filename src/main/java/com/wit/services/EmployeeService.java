package com.wit.services;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.EmployeeDAO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.RoleDTO;
import com.wit.dto.DeptDTO;
import com.wit.utill.PWUtill;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeDAO dao;

	// 입사 순서대로 부서코드 생성을 위한 DB 조회 (사번 생성)
	public String getHighestEmployeeIDByDept(String dept) {
		return dao.getHighestEmployeeIDByDept(dept);
	}

	// 회원가입
	public int register(EmployeeDTO dto) {
		dto.setPw(PWUtill.encryptPassword(dto.getPw()));
		return dao.register(dto);
	}

	// 로그인
	public EmployeeDTO login(String empNo, String pw) {
		String encryptedPw = PWUtill.encryptPassword(pw);
		return dao.login(empNo, encryptedPw);
	}

	// 회원탈퇴
	public int delete(String empNo) {
		return dao.delete(empNo);
	}

	// 추가 정보 업데이트 를 위한 직원 정보 조회
	public boolean FirstLogin(String empNo) {
		EmployeeDTO employee = dao.findByEmpNo(empNo);
		// 직원 정보가 존재하고 특정 컬럼이 비어있는지 확인
		return employee != null && (isEmptyOrWhitespace(employee.getNickname())
				|| isEmptyOrWhitespace(employee.getPhone()) || isEmptyOrWhitespace(employee.getEmail())
				|| isEmptyOrWhitespace(employee.getZip_code()) || isEmptyOrWhitespace(employee.getAddress())
				|| isEmptyOrWhitespace(employee.getDetail_address()) || isEmptyOrWhitespace(employee.getSsn()));
	}

	// 필드가 빈 문자열 또는 공백인지 확인하는 헬퍼 메서드
	private boolean isEmptyOrWhitespace(String str) {
		return str == null || str.trim().isEmpty();
	}

	// 추가 정보 업데이트
	public int updateInfo(EmployeeDTO dto) {
		dto.setPw(PWUtill.encryptPassword(dto.getPw()));
		return dao.updateInfo(dto);
	}

	// 마이페이지 정보 업데이트
	public int updateMyPage(EmployeeDTO dto) {
		// 비밀번호와 닉네임 개별 업데이트
		if (dto.getPw() != null && !dto.getPw().isEmpty()) {
			dto.setPw(PWUtill.encryptPassword(dto.getPw()));
			dao.updatePassword(dto);
		}
		if (dto.getNickname() != null && !dto.getNickname().isEmpty()) {
			dao.updateNickname(dto);
		}
		return 1;
	}

	// 아이디(사번) 찾기
	public String findID(String name, String ssn) {
		EmployeeDTO employee = dao.findID(name, ssn);
		return (employee != null) ? employee.getEmp_no() : null;
	}

	// 모든 직급 정보 가져오기
	public List<RoleDTO> AllRoles() {
		return dao.AllRoles();
	}

	// 모든 부서 정보 가져오기
	public List<DeptDTO> AllDepts() {
		return dao.AllDepts();
	}

	// 닉네임 중복 체크
	public boolean checkNickname(String nickname) {
		return dao.checkNickname(nickname) == 0;
	}

	// 직원 정보 조회
	public EmployeeDTO findByEmpNo(String empNo) {
		return dao.findByEmpNo(empNo);
	}

	// 직원 정보 확인
	public boolean verifyEmployee(String empNo, String name, String ssn) {
		EmployeeDTO employee = dao.findEmployee(empNo, name, ssn);
		return employee != null;
	}

	// 비밀번호 찾기
	public boolean modifyPassword(String empNo, String newPassword) {
		String encryptedPassword = PWUtill.encryptPassword(newPassword); // 비밀번호 암호화
		return dao.modifyPassword(empNo, encryptedPassword) > 0;
	}

}
