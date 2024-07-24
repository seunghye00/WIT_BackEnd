<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>신규 직원 등록</title>
<link rel="stylesheet" href="/resources/css/employee.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/resources/js/employee.js"></script>
</head>
<body>
    <div class="registration_container active">
        <h2>New Employee Registration</h2>
        <form action="/employee/register" method="post">
            <input type="text" id="employee_id" name="emp_no" placeholder="Employee ID" readonly>
            <button type="button" id="generate_id_button">Generate Employee ID</button>
            <input type="password" name="pw" placeholder="Initial Password: 1233" value="1233" readonly> 
            <input type="text" id="name" name="name" placeholder="이름" required>
            <label for="name" class="hidden">Name (2~4 characters)</label>
            <select name="dept" required>
                <option value="" disabled selected>부서 선택</option>
                <option value="인사부">인사부</option>
                <option value="영업부">영업부</option>
                <option value="IT부">IT부</option>
                <option value="재무부">재무부</option>
                <option value="마켓팅부">마케팅부</option>
            </select>
            <select name="role" required>
                <option value="" disabled selected>직급 선택</option>
                <option value="부장">부장</option>
                <option value="차장">차장</option>
                <option value="과장">과장</option>
                <option value="대리">대리</option>
                <option value="사원">사원</option>
                <option value="인턴">인턴</option>
            </select>
            <button type="submit" id="register_button">Register</button>
        </form>
    </div>
</body>
</html>
