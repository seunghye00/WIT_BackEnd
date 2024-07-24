package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.EmployeeDAO;
import com.wit.dto.EmployeeDTO;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeDAO dao;

    // 회원가입
    public int register(EmployeeDTO dto) {
        return dao.register(dto);
    }

    public boolean isFirstLogin(String empNo) {
        EmployeeDTO employee = dao.findByEmpNo(empNo);
        return employee != null && (employee.getNickname() == null || employee.getNickname().isEmpty()
                || employee.getPhone() == null || employee.getPhone().isEmpty() || employee.getEmail() == null || employee.getEmail().isEmpty()
                || employee.getZip_code() == null || employee.getZip_code().isEmpty() || employee.getAddress() == null
                || employee.getAddress().isEmpty() || employee.getDetail_address() == null
                || employee.getDetail_address().isEmpty() || employee.getSsn() == null || employee.getSsn().isEmpty()); // ssn 체크 추가
    }

    // 로그인
    public EmployeeDTO login(String empNo, String pw) {
        return dao.login(empNo, pw);
    }

    // 회원탈퇴
    public int delete(String empNo) {
        return dao.delete(empNo);
    }

    // 추가 정보 업데이트
    public int updateInfo(EmployeeDTO dto) {
        return dao.updateInfo(dto);
    }
}
