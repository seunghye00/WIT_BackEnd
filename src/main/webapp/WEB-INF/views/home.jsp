<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/employee.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/resources/js/employee.js"></script>
</head>
<body>
    <div class="membership active">
        <c:choose>
            <c:when test="${loginID != null}">
                <p>
                    <strong>${loginID}</strong>님 환영합니다.
                </p>
                <button type="button" onclick="location.href='/employee/mypage'">마이페이지</button>
                <button type="button" onclick="location.href='/employee/logout'">로그아웃</button>
                <button type="button" id="del_btn">회원탈퇴</button>
                
                <!-- Popup for additional info -->
                <div id="popup" class="popup">
                    <h2>추가 정보 입력</h2>
                    <form id="additionalInfoForm" action="/employee/update_info" method="post">
                        <input type="hidden" name="emp_no" value="${loginID}">
                        <input type="text" name="nickname" placeholder="Nickname" required>
                        <input type="text" name="ssn" placeholder="ssn" required>
                        <input type="text" name="phone" placeholder="Phone" required>
                        <input type="email" name="email" placeholder="Email" required>
                        <input type="text" name="zip_code" id="zip_code" placeholder="Zip Code" required readonly>
                        <button type="button" class="address-button" onclick="execDaumPostcode()">주소 찾기</button>
                        <input type="text" name="address" id="address" placeholder="Address" required readonly>
                        <input type="text" name="detail_address" placeholder="Detail Address" required>
                        <button type="submit" class="submit-button">Submit</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <h2>Login</h2>
                <div class="employee_container">
                    <a href="/employee/register_form" class="insert_employee">신규 직원등록</a>
                </div>
                <form action="/employee/login" method="post">
                    <input type="text" name="emp_no" placeholder="User ID" required>
                    <input type="password" name="pw" placeholder="User PW" required>
                    <button type="submit" id="login_button">Login</button>
                </form>
                <div class="find_container">
                    <a href="/employee/find_ID" class="find_id">ID 찾기</a> 
                    <a href="#" class="find_pw">PW 찾기</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script>
        $(document).ready(function() {
            // 첫 로그인 시 추가 정보 입력 팝업 표시
            var isFirstLogin = '<c:out value="${isFirstLogin}" />' === 'true'; // 서버에서 isFirstLogin 값을 전달
            if (isFirstLogin) {
                $("#popup").show();
            }
        });
    </script>
</body>
</html>
