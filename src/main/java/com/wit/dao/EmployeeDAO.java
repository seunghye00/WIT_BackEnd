package com.wit.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.EmployeeDTO;

@Repository
public class EmployeeDAO {

    @Autowired
    private SqlSession mybatis;

    // 회원가입
    public int register(EmployeeDTO dto) {
        return mybatis.insert("employee.insert", dto);
    }

    // 로그인
    public EmployeeDTO login(String emp_no, String pw) {
        Map<String, Object> params = new HashMap<>();
        params.put("emp_no", emp_no);
        params.put("pw", pw);
        return mybatis.selectOne("employee.login", params);
    }

    // 회원탈퇴
    public int delete(String emp_no) {
        return mybatis.delete("employee.delete", emp_no);
    }

    // 추가 정보 업데이트
    public int updateInfo(EmployeeDTO dto) {
        return mybatis.update("employee.updateInfo", dto);
    }
    
    // EmpNo로 직원 정보 찾기
    public EmployeeDTO findByEmpNo(String empNo) {
        return mybatis.selectOne("employee.findByEmpNo", empNo);
    }
}
