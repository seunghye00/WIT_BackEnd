<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>근태 관리</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/employee.js"></script>

</head>
<body>
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

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<span class="myName"><img src="/resources/img/푸바오.png"
					alt="프로필 사진" class="userImg"><a href="/employee/mypage">${employee.name}
						${employee.role_code}</a></span> <span class="logOut"><a
					href="/employee/logout">LogOut</a></span>
			</div>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<a href="/attendance/attendance">
							<h2 class="sideTit">근태관리</h2>
						</a>
					</div>
					<div class="addressListPrivate">
						<ul class="privateList">
							<li class="toggleItem">
								<h3 class="toggleTit">근태관리</h3>
								<div style="padding: 5px;"></div>
								<ul class="subList">
									<li><a href="/attendance/attendance_month" class="active">월간
											근태현황</a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div style="padding: 10px;"></div>
					<a href="/annualLeave/attendanceVacation">
						<h3 class="toggleTit">휴가관리</h3>
					</a>
					<div style="padding: 10px;"></div>
					<!-- 사장일 때만 부서별 근태현황과 부서별 휴가현황을 보여줌 -->
					<c:if test="${employee.role_code == '사장'}">
						<a href="/attendance/attendanceDept">
							<h3 class="toggleTit">부서별 근태현황</h3>
						</a>
						<div style="padding: 10px;"></div>
						<a href="/annualLeave/attendanceDeptVacation">
							<h3 class="toggleTit">부서별 휴가현황</h3>
						</a>
					</c:if>
				</div>
				<div class="sideContents Attendance">
					<h2>근태관리</h2>
					<div class="Attendance_container">
						<div class="Attendance_sections">
							<div class="status_container">
								<h3>월간 근태현황</h3>
								<div class="status_row status_header">
									<div class="status_col">
										<span>지각</span>
									</div>
									<div class="status_col">
										<span>조퇴</span>
									</div>
									<div class="status_col">
										<span>결근</span>
									</div>
								</div>
								<div class="status_row">
									<div class="status_col">
										<span>${monthlyStatus.LATE}회</span>
									</div>
									<div class="status_col">
										<span>${monthlyStatus.EARLYLEAVE}회</span>
									</div>
									<div class="status_col">
										<span>${monthlyStatus.ABSENCE}회</span>
									</div>
								</div>
							</div>
							<div class="hours_container">
								<h3>월간 근무시간</h3>
								<div class="hours_row status_header">
									<div class="hours_col">
										<span>근무일수</span>
									</div>
									<div class="hours_col">
										<span>총 근무시간</span>
									</div>
								</div>
								<div class="hours_row">
									<div class="hours_col">
										<span>${monthlyWorkHours.WORKINGDAYS}일</span>
									</div>
									<div class="hours_col">
										<span>${monthlyWorkHours.totalWorkingHours}</span>
									</div>
								</div>
							</div>
						</div>
						<div class="week_status">
							<h3>주간 근무현황</h3>
							<div class="week_row week_header">
								<div class="week_col">
									<span>근무일</span>
								</div>
								<div class="week_col">
									<span>출근시간</span>
								</div>
								<div class="week_col">
									<span>퇴근시간</span>
								</div>
								<div class="week_col">
									<span>근무시간</span>
								</div>
							</div>
							<c:forEach var="status" items="${weeklyStatus}">
								<div class="week_row">
									<div class="week_col">
										<fmt:formatDate value="${status.WORK_DATE}"
											pattern="yyyy-MM-dd" />
									</div>
									<div class="week_col">
										<span>${status.START_TIME}</span>
									</div>
									<div class="week_col">
										<span>${status.END_TIME}</span>
									</div>
									<div class="week_col">
										<span>${status.WORK_HOURS}</span>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- sidebar 공통요소 script -->
	<script>
		let btn = document.querySelector("#btn")
		let sideBar = document.querySelector(".sideBar")

		btn.onclick = function() {
			sideBar.classList.toggle("active")
		};

		// 주소록 토글 이벤트 설정
		const toggleItems = document.querySelectorAll('.toggleItem')
		toggleItems.forEach(function(toggleItem) {
			const toggleTit = toggleItem.querySelector('.toggleTit')
			const subList = toggleItem.querySelector('.subList')

			toggleTit.addEventListener('click', function() {
				subList.classList.toggle('active')
				toggleTit.classList.toggle('active') // 이미지 회전을 위해 클래스 추가
			})
		})
	</script>
</body>
</html>
