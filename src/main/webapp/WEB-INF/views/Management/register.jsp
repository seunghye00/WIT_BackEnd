<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>신규 직원 등록</title>
    <link rel="stylesheet" href="/resources/css/wit.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="/resources/js/employee.js"></script>
</head>
<body class="membership_body">
    <div class="registration_container active">
        <h2>신규 직원 등록</h2>
        <form action="/employee/register" method="post">
            <select name="dept_code" id="dept_select" required>
                <option value="" disabled selected>부서 선택</option>
                <c:forEach var="dept" items="${deptList}">
                    <option value="${dept.dept_code}">${dept.dept_title}</option>
                </c:forEach>
            </select>
            <select name="role_code" id="role_select" required>
                <option value="" disabled selected>직급 선택</option>
                <c:forEach var="role" items="${roleList}">
                    <option value="${role.role_code}">${role.role_title}</option>
                </c:forEach>
            </select>
            <input type="text" id="employee_id" name="emp_no" placeholder="사원번호" readonly>
            <button type="button" id="generate_id_button">사원번호 생성</button>
            <input type="password" name="pw" placeholder="초기 비밀번호: 1233" value="1233" readonly>
            <input type="text" id="name" name="name" placeholder="이름" required>
            <label id="resultName"></label>
            <button type="submit" id="register_button">등록</button>
        </form>
    </div>
</body>
</html>
