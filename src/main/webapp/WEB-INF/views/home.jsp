<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/employee.js"></script>
</head>

<body class="membership_body">
	<div class="membership active">
		<img src="/resources/img/logo.png" alt="로고 이미지">
		<div class="find_container">
			<a href="/employee/find_ID" class="find_id">ID 찾기</a> / <a
				href="/employee/find_PW" class="find_pw">PW 찾기</a>
		</div>
		<form id="loginForm" action="/employee/login" method="post">
			<input type="text" name="emp_no" placeholder="User ID" required>
			<input type="password" name="pw" placeholder="User PW" required>
			<button type="submit">Login</button>
		</form>
		<div class="employee_container">
			<a href="/employee/register_form" class="insert_employee">신규 직원등록</a>
		</div>
	</div>
</body>

</html>
