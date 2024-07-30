<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="/resources/css/employee.css">
    <script src="/resources/js/employee.js"></script>
</head>
<body class ="membership_body">
    <div class="membership active">
        <c:choose>
            <c:when test="${loginID != null}">
                <p>
                    <strong>${loginID}</strong>님 환영합니다.
                </p>
                <button type="button" onclick="location.href='/employee/mypage'">마이페이지</button>
                <button type="button" onclick="location.href='/employee/logout'">로그아웃</button>
                <button type="button" id="del_btn">회원탈퇴</button>
                <button type="button" id="start_button">출근</button>
                <button type="button" id="end_button">퇴근</button>

                <div id="popup" class="popup" style="display: none;">
                    <h2>추가 정보 입력</h2>
                    <form id="insertForm" action="/employee/update_info" method="post">
                        <input type="hidden" name="emp_no" value="${loginID}">
                        <div class="input-container">
                            <input type="password" name="pw" id="pw" placeholder="비밀번호" required>
                            <span class="valid-check error" id="pwCheck">&#x2716;</span>
                        </div>
                        <label id="resultpw"></label>
                        <div class="input-container">
                            <input type="password" name="checkpw" id="checkpw" placeholder="비밀번호 확인" required>
                            <span class="valid-check error" id="checkpwCheck">&#x2716;</span>
                        </div>
                        <label id="resultcheckpw"></label>
                        <div class="input-container">
                            <input type="text" name="nickname" id="nickname" placeholder="닉네임" required>
                            <span class="valid-check error" id="nicknameCheck">&#x2716;</span>
                        </div>
                        <label id="resultNickname"></label>
                        <button type="button" class="nickname-button" id="checkNickname">중복체크</button>
                        <div class="input-container">
                            <input type="text" name="ssn" id="ssn" placeholder="주민등록번호" required>
                            <span class="valid-check error" id="ssnCheck">&#x2716;</span>
                        </div>
                        <label id="resultSSN"></label>
                        <div class="input-container">
                            <input type="text" name="phone" id="phone" placeholder="휴대폰" required>
                            <span class="valid-check error" id="phoneCheck">&#x2716;</span>
                        </div>
                        <label id="resultPhone"></label>
                        <div class="input-container">
                            <input type="email" name="email" id="email" placeholder="이메일" required>
                            <span class="valid-check error" id="emailCheck">&#x2716;</span>
                        </div>
                        <label id="resultEmail"></label>
                        <input type="text" name="zip_code" id="zip_code" placeholder="우편주소" required readonly>
                        <button type="button" class="address-button" id="postcode">주소 찾기</button>
                        <input type="text" name="address" id="address" placeholder="주소" required readonly>
                        <input type="text" name="detail_address" placeholder="상세주소" required>
                        <button type="submit" class="submit-button">입력하기</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
            <img src="/resources/img/logo.png" alt="로고 이미지">
                <div class="find_container">
                    <a href="/employee/find_ID" class="find_id">ID 찾기</a>
                </div>
                <form id="loginForm">
                    <input type="text" name="emp_no" placeholder="User ID" required>
                    <input type="password" name="pw" placeholder="User PW" required>
                    <button type="button" id="login_button">Login</button>
                </form>
                <div class="employee_container">
                    <a href="/employee/register_form" class="insert_employee">신규 직원등록</a>
                    <!-- <a href="#" class="find_pw">PW 찾기</a> -->
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script>
        $(document).ready(function() {
            var firstLogin = "${FirstLogin}" === "true";
            if (firstLogin) {
                $("#popup").show();
            }
        });
    </script>
</body>
</html>
