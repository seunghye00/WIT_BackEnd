<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>사번 찾기</title>
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/resources/js/employee.js"></script>
</head>
<body class="membership_body">
	<div class="find_id_container active">
		<img src="/resources/img/logo.png" alt="로고 이미지">
		<form id="findId" action="/employee/findID" method="post">
			<input type="text" name="name" placeholder="이름" required> <input
				type="text" name="ssn" placeholder="주민등록번호" required>
			<button type="submit">ID 찾기</button>
		</form>
	</div>
</body>
</html>
