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
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/resources/js/employee.js"></script>
</head>

<body>
	<!-- 공통영역 -->
	<div class="container">
		<div class="sideBar">
			<div class="top">
				<i class="bx bx-menu" id="btn"></i>
			</div>
			<div class="user">
				<img src="/resources/img/WIT_logo1.png" alt="로고" class="userImg">
				<div class="nickName">
					<p class="bold">Wit Works</p>
					<p></p>
				</div>
			</div>

			<ul>
				<li><a href="/employee/main"> <i class='bx bxs-home-alt-2'></i>
						<span class="navItem">홈</span></a> <span class="toolTip">홈</span></li>
				<li><a href="/addressbook/addressbook"> <i
						class='bx bx-paperclip'></i> <span class="navItem">주소록</span></a> <span
					class="toolTip">주소록</span></li>
				<li><a href="/board/list"> <i class="bx bxs-grid-alt"></i>
						<span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
				<li><a href="/calendar/calendar"> <i
						class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a> <span
					class="toolTip">캘린더</span></li>
				<li><a href="/messenger/messenger"> <i
						class='bx bxs-message-dots'></i> <span class="navItem">메신저</span></a>
					<span class="toolTip">메신저</span></li>
				<li><a href="#"> <i class='bx bx-clipboard'></i> <span
						class="navItem">전자결재</span></a> <span class="toolTip">전자결재</span></li>
				<li><a href="/attendance/attendance"> <i
						class='bx bxs-briefcase-alt-2'></i> <span class="navItem">근태관리</span></a>
					<span class="toolTip">근태관리</span></li>
				<li><a href="#"> <i class='bx bxs-check-square'></i> <span
						class="navItem">예약</span></a> <span class="toolTip">예약</span></li>
				<li><a href="#"> <i class='bx bx-sitemap'></i> <span
						class="navItem">조직도</span></a> <span class="toolTip">조직도</span></li>
			</ul>
		</div>
		<!-- 공통영역 끝 -->

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<span class="myName"> <img src="/resources/img/푸바오.png"
					alt="프로필 사진" class="userImg"><a href="/employee/mypage">${employee.name}
						${employee.role_code}</a>
				</span> <span class="logOut"><a href="/employee/logout">LogOut</a></span>
			</div>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">마이페이지</h2>
					</div>
				</div>
				<div class="sideContents mypage">
					<h2>마이페이지</h2>
					<div class="form-container">
						<form id="updateForm">
							<div class="form-group-photo">
								<span>프로필</span> <img src="/resources/img/푸바오.png" alt="푸바오 이미지">
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>이름</span> <input type="text" value="${employee.name}"
										readonly>
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
										readonly>
								</div>
								<div class="form-group">
									<span>휴대폰</span> <input type="text" value="${employee.phone}"
										readonly>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>이메일</span> <input type="text" value="${employee.email}"
										readonly>
								</div>
								<div class="form-group">
									<span>주소</span> <input type="text" value="${employee.address}"
										readonly>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>상세주소</span> <input type="text"
										value="${employee.detail_address}" readonly>
								</div>
								<div class="form-group">
									<span>입사일</span> <input type="text"
										value="<fmt:formatDate value='${employee.join_date}' pattern='yyyy년 MM월 dd일' />"
										readonly>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<span>부서</span> <input type="text"
										value="${employee.dept_code}" readonly>
								</div>
								<div class="form-group">
									<span>직급</span> <input type="text"
										value="${employee.role_code}" readonly>
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
		let btn = document.querySelector("#btn");
		let sideBar = document.querySelector(".sideBar");

		btn.onclick = function() {
			sideBar.classList.toggle("active");
		};

		// 닉네임 중복 체크여부 확인
		let nicknameChecked = false;
		// 사용자 현재 닉네임 저장
		const originalNickname = "${employee.nickname}";

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
			}
		}
	</script>
</body>
</html>
