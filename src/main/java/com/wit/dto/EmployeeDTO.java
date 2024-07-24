package com.wit.dto;

import java.sql.Timestamp;

public class EmployeeDTO {

    private String emp_no;
    private String pw;
    private String name;
    private String nickname;
    private String ssn; // 주민등록번호를 String 타입으로 변경
    private String phone; // 전화번호를 String 타입으로 변경
    private String email;
    private String zip_code;
    private String address;
    private String detail_address;
    private String dept;
    private String role;
    private Timestamp join_date;
    private Timestamp quit_date;

    // Getters and Setters
    public String getEmp_no() {
        return emp_no;
    }

    public void setEmp_no(String emp_no) {
        this.emp_no = emp_no;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetail_address() {
        return detail_address;
    }

    public void setDetail_address(String detail_address) {
        this.detail_address = detail_address;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getJoin_date() {
        return join_date;
    }

    public void setJoin_date(Timestamp join_date) {
        this.join_date = join_date;
    }

    public Timestamp getQuit_date() {
        return quit_date;
    }

    public void setQuit_date(Timestamp quit_date) {
        this.quit_date = quit_date;
    }

    public EmployeeDTO() {
    }

    public EmployeeDTO(String emp_no, String pw, String name, String nickname, String ssn, String phone, String email,
                       String zip_code, String address, String detail_address, String dept, String role, Timestamp join_date,
                       Timestamp quit_date) {
        super();
        this.emp_no = emp_no;
        this.pw = pw;
        this.name = name;
        this.nickname = nickname;
        this.ssn = ssn;
        this.phone = phone;
        this.email = email;
        this.zip_code = zip_code;
        this.address = address;
        this.detail_address = detail_address;
        this.dept = dept;
        this.role = role;
        this.join_date = join_date;
        this.quit_date = quit_date;
    }
}
