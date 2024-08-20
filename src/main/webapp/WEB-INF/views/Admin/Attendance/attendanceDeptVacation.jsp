<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부서별 근태현황</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<link rel="stylesheet" href="/resources/css/employee.css">
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
					<a href="/attendance/attendanceDept">
						<h3 class="toggleTit">부서별 근태현황</h3>
					</a>
					<div style="padding: 10px;"></div>
					<a href="/annualLeave/attendanceDeptVacation">
						<h3 class="toggleTit">부서별 휴가현황</h3>
					</a>
				</div>
				<div class="sideContents AttendanceDept">
					<h2>부서별 휴가현황</h2>
					<div class="searchBox">
						<input type="text" placeholder="검색" value="${searchTxt}"
							id="searchTxt">
						<button class="searchBtn" id="searchBtn">
							<i class='bx bx-search'></i>
						</button>
					</div>
					<div class="dept_tabs">
						<c:forEach var="dept" items="${departments}">
							<div
								class="dept_tab ${dept.dept_title == deptTitle ? 'active' : ''}">
								<a href="?deptTitle=${dept.dept_title}">${dept.dept_title}</a>
							</div>
						</c:forEach>
					</div>
					<div class="attendance_table">
						<div class="header_row">
							<span>번호</span> <span>휴가종류</span> <span>사용기간</span> <span>일수</span>
						</div>

					</div>
					<div class="pagination">
						<!-- 이전 페이지로 이동 -->
						<a
							href="/attendance/attendance_month?cpage=${cpage > 1 ? cpage - 1 : 1}"
							class="prev"> <i class='bx bx-chevron-left'></i>
						</a>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${startNavi}" end="${endNavi}">
							<a href="/attendance/attendance_month?cpage=${i}"
								class="${i == cpage ? 'active' : ''}">${i}</a>
						</c:forEach>

						<!-- 다음 페이지로 이동 -->
						<a
							href="/attendance/attendance_month?cpage=${cpage + 1 > pageTotalCount ? pageTotalCount : cpage + 1}"
							class="next"> <i class='bx bx-chevron-right'></i>
						</a>
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
