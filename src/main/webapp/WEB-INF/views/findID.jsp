<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>사원번호 찾기</title>
<link rel="stylesheet" href="/resources/css/employee.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/resources/js/employee.js"></script>
</head>
<body>
	<div class="find_id_container active">
		<h2>ID 찾기</h2>
		<form action="/employee/find_id" method="post">
			<input type="text" name="name" placeholder="Name" required> 
			<input type="email" name="email" placeholder="Email" required>
			<button type="submit">Find ID</button>
		</form>
	</div>
</body>
</html>