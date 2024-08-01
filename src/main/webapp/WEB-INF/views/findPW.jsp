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
<script>
$(document).ready(function() {
    // 비밀번호 찾기 버튼 클릭 이벤트
    $('#openModalButton').on('click', function(e) {
        e.preventDefault();
        var formData = $('#findId').serialize();

        $.ajax({
            url: '/employee/verifyEmployee',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    $('#overlay').show();
                    $('#pwChangeModal').show();
                } else {
                    alert("사번, 이름, 주민등록번호를 다시 확인해 주세요.");
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert("AJAX 에러!");
            }
        });
    });

    // 비밀번호 변경 폼 제출 이벤트
    $('#changePasswordForm').on('submit', function(e) {
        e.preventDefault();
        var newPassword = $('#newPassword').val().trim();
        var confirmPassword = $('#confirmPassword').val().trim();

        // 사용자 정의 정규표현식을 사용한 비밀번호 유효성 검사
        var passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{10,}$/;
        if (!passwordRegex.test(newPassword)) {
            alert("비밀번호는 10자 이상이며, 소문자, 숫자 및 특수문자(!@#$%^&*)를 포함해야 합니다.");
            return;
        }

        if (newPassword !== confirmPassword) {
            alert("비밀번호 확인이 일치하지 않습니다.");
            return;
        }

        var formData = {
            emp_no: $("input[name='emp_no']").val(),
            newPassword: newPassword
        };

        $.ajax({
            url: '/employee/updatePassword',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert("비밀번호가 성공적으로 변경되었습니다.");
                    $('#overlay').hide();
                    $('#pwChangeModal').hide();
                    window.location.href = "/"; // 비밀번호 변경 성공 시 홈으로 이동
                } else {
                    alert("비밀번호 변경에 실패하였습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert("AJAX 에러!");
            }
        });
    });
});
</script>
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
            <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
            <button type="submit" class="submit-button">변경</button>
        </form>
    </div>

</body>
</html>
