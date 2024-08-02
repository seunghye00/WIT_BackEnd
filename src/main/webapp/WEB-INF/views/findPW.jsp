<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>PW 찾기</title>
<link rel="stylesheet" href="/resources/css/employee.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/resources/js/employee.js"></script>
</head>
<body class="membership_body">
    <div class="find_pw_container active">
        <img src="/resources/img/logo.png" alt="로고 이미지">
        <form id="findId" method="post">
            <input type="text" name="emp_no" placeholder="EMP_NO" required>
            <input type="text" name="name" placeholder="Name" required>
            <input type="text" name="ssn" placeholder="SSN" required>
            <button type="button" id="openModalButton">Find PW</button>
        </form>
    </div>

    <!-- 모달 창 -->
    <div class="find_pw_overlay" id="overlay" style="display:none;"></div>
    <div class="find_pw_popup" id="pwChangeModal" style="display:none;">
        <h2>비밀번호 변경</h2>
        <form id="changePasswordForm" method="post">
            <div class="change">
                <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
                <label class="password-validation-message">
                    <span id="resultpw"></span>
                    <span class="valid-check" id="pwCheck">&#x2716;</span>
                </label>
            </div>
            <div class="change">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
                <label class="password-validation-message">
                    <span id="resultcheckpw"></span>
                    <span class="valid-check" id="checkpwCheck">&#x2716;</span>
                </label>
            </div>
            <button type="submit" class="submit-button">변경</button>
        </form>
    </div>

</body>
</html>
