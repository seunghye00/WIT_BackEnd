package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.DeptDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.EmployeeInfoDTO;
import com.wit.dto.RoleDTO;

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

	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String emp_no) {
		return mybatis.selectOne("employee.employeeInfo", emp_no);
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

	// 직원 주소록 리스트 조회
	public List<Map<String, Object>> getEmployeeAddressList(Map<String, Object> params) {
		return mybatis.selectList("employee.getEmployeeAddressList", params);
	}

	// 직원 주소록 검색
	public List<EmployeeDTO> searchEmployeeAddressList(String keyword, int cpage) {
		Map<String, Object> params = new HashMap<>();
		params.put("keyword", keyword);
		params.put("cpage", cpage);
		return mybatis.selectList("employee.searchEmployeeAddressList", params);
	}
	
	// 주소록 데이터 총 조회
	public int CountPageAddress(Map<String, Object> params) {
		return mybatis.selectOne("employee.CountPageAddress", params);
	}
	
	// 주소록 데이터 총 조회
	public int totalCountPage(String emp_no) {
		return mybatis.selectOne("employee.totalCountPage", emp_no);
	}

	// 카테고리 목록 가져오기
	public List<Map<String, Object>> getCategories() {
		return mybatis.selectList("employee.getCategories");
	}

	// 주소록 데이터 가져오기
	public Map<String, Object> getContactByEmp_no(String emp_no) {
		return mybatis.selectOne("employee.getContactByEmp_no", emp_no);
	}

	// 주소록 검색
	public List<Map<String, Object>> selectByCon(String keyword, int startNum, int endNum) {
		Map<String, Object> params = new HashMap<>();
		params.put("keyword", keyword);
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		List<Map<String, Object>> list = mybatis.selectList("employee.selectByCon", params);
		return list;
	}

	// 주소록 툴바 페이지네이션 총 카운트
	public int totalCountPageSearch(String keyword) {
		return mybatis.selectOne("employee.totalCountPageSearch", keyword);
	}

	// 메신저 주소록 조히
	public List<Map<String, Object>> getAllMessengerEmp(String emp_no) {
		return mybatis.selectList("employee.getAllMessengerEmp", emp_no);
	}

	// 메신저 주소록 상세 조히
	public Map<String, Object> getContactByEmpNo(String emp_no) {
		return mybatis.selectOne("employee.getContactByEmpNo", emp_no);
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

	// 부서별 사원 목록 조회
	public List<EmployeeDTO> getListByDept(String deptCode) {
		return mybatis.selectList("employee.selectByDept", deptCode);
	}

	// 해당 사번을 지닌 직원의 이름과 부서명 조회
	public EmployeeInfoDTO getNameNDept(String empNo) {
		return mybatis.selectOne("employee.selectByEmpNo", empNo);
	}

	// 메신저 emp_no 이름으로 변경
	public String getEmployeeName(String emp_no) {
		return mybatis.selectOne("employee.getEmployeeName", emp_no);
	}

	// 해당 사번을 지닌 직원의 이름 조회
	public String getName(String empNo) {
		return mybatis.selectOne("employee.getName", empNo);
	}

	// 해당 사번을 지닌 직원의 직급 조회
	public String getRole(String empNo) {
		return mybatis.selectOne("employee.getRole", empNo);
	}

	// 해당 사번을 지닌 직원의 부서명 조회
	public String getDept(String empNo) {
		return mybatis.selectOne("employee.getDept", empNo);
	}
	
	// 직원 리스트 조회
	public List<Map<String, Object>> getManagementList(Map<String, Object> params) {
		return mybatis.selectList("employee.getManagementList", params);
	}
	
	// 직원 검색 조회
	public List<Map<String, Object>> selectByManage(Map<String, Object> params) {
		return mybatis.selectList("employee.selectByManage", params);
	}
	
	// 직원 조회 페이지네이션 총 카운트
	public int totalCountManageSearch(Map<String, Object> params) {
		return mybatis.selectOne("employee.totalCountManageSearch", params);
	}
	
	// 직원 상세 조회
	public Map<String, Object> managementDetail(String emp_no) {
		return mybatis.selectOne("employee.managementDetail", emp_no);
	}
	
	// 직원 상세 업데이트
	public void updateManage(Map<String, Object> params) {
		mybatis.update("employee.updateManage", params);
	}
}
