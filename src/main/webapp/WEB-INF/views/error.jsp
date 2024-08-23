<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Error</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/employee.js"></script>
</head>
<body class="membership_body">
	<div class="membership active">
		<img src="/resources/img/logo.png" alt="로고 이미지">
		<div class="errorMsg">
			오류가 발생했습니다.<br>
			자세한 사항은 관리자에게 문의해주세요.
		</div>
		<a href="/employee/main">
			<button>홈으로</button>
		</a>
	</div>
</body>
</html>
