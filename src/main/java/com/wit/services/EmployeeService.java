package com.wit.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.commons.BoardConfig;
import com.wit.dao.EmployeeDAO;
import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.RoleDTO;
import com.wit.utill.PWUtill;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeDAO dao;

	// 모든 직급 정보 가져오기
	public List<RoleDTO> AllRoles() {
		return dao.AllRoles();
	}

	// 모든 부서 정보 가져오기
	public List<DeptDTO> AllDepts() {
		return dao.AllDepts();
	}

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

	// 추가 정보 업데이트 를 위한 직원 정보 조회
	public boolean FirstLogin(String empNo) {
		EmployeeDTO employee = dao.findByEmpNo(empNo);
		// 직원 정보가 존재하고 특정 컬럼이 비어있는지 확인
		return employee != null && (isEmptyOrWhitespace(employee.getNickname())
				|| isEmptyOrWhitespace(employee.getPhone()) || isEmptyOrWhitespace(employee.getEmail())
				|| isEmptyOrWhitespace(employee.getZip_code()) || isEmptyOrWhitespace(employee.getAddress())
				|| isEmptyOrWhitespace(employee.getDetail_address()) || isEmptyOrWhitespace(employee.getSsn()));
	}

	// 추가 정보 업데이트 를 위한 헬퍼메서드
	// 필드가 빈 문자열 또는 공백인지 확인하는 헬퍼 메서드
	private boolean isEmptyOrWhitespace(String str) {
		return str == null || str.trim().isEmpty();
	}

	// 추가 정보 업데이트
	public int updateInfo(EmployeeDTO dto) {
		dto.setPw(PWUtill.encryptPassword(dto.getPw()));
		return dao.updateInfo(dto);
	}

	// ID찾기
	public String findID(String name, String ssn) {
		EmployeeDTO employee = dao.findID(name, ssn);
		return (employee != null) ? employee.getEmp_no() : null;
	}

	// PW찾기(수정) 직원 정보 확인
	public boolean verifyEmployee(String empNo, String name, String ssn) {
		EmployeeDTO employee = dao.findEmployee(empNo, name, ssn);
		return employee != null;
	}

	// PW찾기 (수정)
	public boolean modifyPassword(String empNo, String newPassword) {
		String encryptedPassword = PWUtill.encryptPassword(newPassword); // 비밀번호 암호화
		return dao.modifyPassword(empNo, encryptedPassword) > 0;
	}

	// 직원 정보 조회(마이페이지)
	public EmployeeDTO findByEmpNo(String empNo) {
		return dao.findByEmpNo(empNo);
	}

	// 닉네임 중복 체크(마이페이지)
	public boolean checkNickname(String nickname) {
		return dao.checkNickname(nickname) == 0;
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

	// 회원탈퇴
	public int delete(String empNo) {
		return dao.delete(empNo);
	}
	
	// 주소록 조회 메소드 추가
    public List<Map<String, Object>> getEmployeeList(String chosung, String category, int cpage) {
    	int startNum = (cpage - 1) * BoardConfig.recordCountPerPage + 1;
	    int endNum = cpage * BoardConfig.recordCountPerPage;

	    Map<String, Object> params = new HashMap<>();
	    params.put("chosung", chosung);
	    params.put("category", category);
	    params.put("startNum", startNum);
	    params.put("endNum", endNum);
        return dao.getEmployeeAddressList(params);
    }
    // 주소록 조회 메소드 추가
    public List<EmployeeDTO> searchEmployeeList(String keyword, int cpage) {
        return dao.searchEmployeeAddressList(keyword, cpage);
    }
    
    // 주소록 검색 카운트 값 조회
    @Transactional
    public int totalCountPage() {
    	return dao.totalCountPage();
    }
    
    // 주소록 카테고리 조회
    @Transactional
    public List<Map<String, Object>> getCategories() {
        return dao.getCategories();
    }
    
	// 주소록 데이터 가져오기
	public Map<String, Object> getContactByEmp_no(String emp_no) {
	    return dao.getContactByEmp_no(emp_no);
	}
	
	// 주소록 검색 카운트 값 조회
	@Transactional
	public int totalCountPageSearch(String keyword) {
		return dao.totalCountPageSearch(keyword);
	}
	
	// 주소록 검색값 레코드 조회
	@Transactional
	public List<Map<String, Object>> selectByCon(String keyword, int cpage) {
		return dao.selectByCon(keyword, cpage * BoardConfig.recordCountPerPage - (BoardConfig.recordCountPerPage - 1),
				cpage * BoardConfig.recordCountPerPage);
	}
	
	// 메신저 주소록 조회
	@Transactional
	public List<Map<String, Object>> getAllMessengerEmp() {
        return dao.getAllMessengerEmp();
    }
	
	// 메신저 주소록 상세 조회
	@Transactional
	public Map<String, Object> getContactByEmpNo(String emp_no) {
        return dao.getContactByEmpNo(emp_no);
    }
}
