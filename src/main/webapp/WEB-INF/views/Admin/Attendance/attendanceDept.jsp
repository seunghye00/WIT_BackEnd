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
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/employee.js"></script>

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
				<div class="sideContents AttendanceDept">
					<h2>부서별 근태현황</h2>
					<div class="week_selector">
						<span> <i class="bx bx-chevron-left"
							onclick="window.location.href='?week=${previousWeek}&deptTitle=${deptTitle}'"></i>
							${startDate} ~ ${endDate} <i class="bx bx-chevron-right"
							onclick="window.location.href='?week=${nextWeek}&deptTitle=${deptTitle}'"></i>
						</span>
					</div>

					<div class="dept_tabs">
						<c:forEach var="dept" items="${departments}">
							<a href="?deptTitle=${dept.dept_title}"
								class="dept_tab ${dept.dept_title == deptTitle ? 'active' : ''}">
								<div>${dept.dept_title}</div>
							</a>
						</c:forEach>
					</div>

					<div class="attendance_table">
						<div class="header_row">
							<span>이름</span> <span>월</span> <span>화</span> <span>수</span> <span>목</span>
							<span>금</span> <span>토</span>
						</div>
						<c:forEach var="attendanceItem" items="${attendanceData}">
							<div class="attendance_row">
								<span>${attendanceItem.ROLETITLE}
									${attendanceItem.EMPNAME}</span> <span>${attendanceItem.MONDAY}</span>
								<span>${attendanceItem.TUESDAY}</span> <span>${attendanceItem.WEDNESDAY}</span>
								<span>${attendanceItem.THURSDAY}</span> <span>${attendanceItem.FRIDAY}</span>
								<span>${attendanceItem.SATURDAY}</span>
							</div>
						</c:forEach>
					</div>
					<div class="pagination" id="atd_dept_navi">
						<!-- 이전 페이지로 이동 -->
						<a
							href="?deptTitle=${deptTitle}&week=${startDate}&cpage=${cpage > 1 ? cpage - 1 : 1}"
							class="prev"> <i class='bx bx-chevron-left'></i>
						</a>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${startNavi}" end="${endNavi}">
							<a href="?deptTitle=${deptTitle}&week=${startDate}&cpage=${i}"
								class="${i == cpage ? 'active' : ''}"> ${i} </a>
						</c:forEach>

						<!-- 다음 페이지로 이동 -->
						<a
							href="?deptTitle=${deptTitle}&week=${startDate}&cpage=${cpage + 1 > pageTotalCount ? pageTotalCount : cpage + 1}"
							class="next"> <i class='bx bx-chevron-right'></i>
						</a>
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
