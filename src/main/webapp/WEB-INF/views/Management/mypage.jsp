<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이 페이지</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/js/employee.js"></script>
<script src="/js/wit.js"></script>
</head>

<body>
	<div class="container">
		<!-- 공통영역 -->
		<c:choose>
			<c:when test="${employee.role_code == '사장'}">
				<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp"%>
			</c:when>
			<c:otherwise>
				<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
			</c:otherwise>
		</c:choose>
		<!-- 공통영역 끝 -->

		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>

			<div class="contents">
				<div class="sideContents mypage">
					<h2>마이페이지</h2>
					<div class="form-container">
						<form id="updateForm">
							<div class="form-group-photo">
								<span>프로필</span> <img src="${employee.photo}" alt="프로필 이미지">
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>이름</span> <input type="text" value="${employee.name}"
										readonly disabled="true">
								</div>
								<div class="form-group">
									<span>닉네임</span> <input type="text" name="nickname"
										id="nickname" value="${employee.nickname}" readonly>
									<button type="button" id="checkNickname"
										class="edit-nickname-button hidden">중복체크</button>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>생년월일</span> <input type="text" value="${employee.ssn}"
										readonly disabled="true">
								</div>
								<div class="form-group">
									<span>휴대폰</span> <input type="text" value="${employee.phone}"
										readonly disabled="true">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>이메일</span> <input type="text" value="${employee.email}"
										readonly disabled="true">
								</div>
								<div class="form-group">
									<span>주소</span> <input type="text" value="${employee.address}"
										readonly disabled="true">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>상세주소</span> <input type="text"
										value="${employee.detail_address}" readonly disabled="true">
								</div>
								<div class="form-group">
									<span>입사일</span> <input type="text"
										value="<fmt:formatDate value='${employee.join_date}' pattern='yyyy년 MM월 dd일' />"
										readonly disabled="true">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>부서</span> <input type="text"
										value="${employee.dept_code}" readonly disabled="true">
								</div>
								<div class="form-group">
									<span>직급</span> <input type="text"
										value="${employee.role_code}" readonly disabled="true">
								</div>
							</div>
							<div class="form-row hidden" id="passwordRow">
								<div class="form-group">
									<span>PW변경</span> <input type="password" name="pw" id="pw">
									<label id="resultpw" class="resultpw"></label> <span
										id="pwCheck"></span>
								</div>
								<div class="form-group">
									<span>PW확인</span> <input type="password" name="checkpw"
										id="checkpw"> <label id="resultcheckpw"
										class="resultcheckpw"></label> <span id="checkpwCheck"></span>
								</div>
							</div>
							<div class="form-actions">
								<button type="button" id="editButton" onclick="toggleEdit()">수정</button>
								<button type="submit" id="saveButton" class="hidden">완료</button>
								<div class="cancel">
									<button type="button" id="cancelButton" class="hidden"
										onclick="toggleEdit()">취소</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		// 원래 닉네임을 저장
		let originalNickname = "${employee.nickname}";

		// 닉네임 중복 체크여부 확인
		let nicknameChecked = false;

		// 수정을 위한 함수
		function toggleEdit() {
			const isEditing = !document.getElementById('editButton').classList
					.contains('hidden');
			document.getElementById('editButton').classList.toggle('hidden');
			document.getElementById('saveButton').classList.toggle('hidden');
			document.getElementById('cancelButton').classList.toggle('hidden');
			document.getElementById('passwordRow').classList.toggle('hidden');
			document.getElementById('checkNickname').classList.toggle('hidden');

			const nicknameField = document
					.querySelector('input[name="nickname"]');
			if (nicknameField) {
				nicknameField.readOnly = !isEditing;
				
				// 취소 버튼을 눌렀을 때 닉네임을 원래대로 복원
				if (!isEditing) {
					nicknameField.value = originalNickname;
				}
			}
		}
	</script>
</body>
</html>
