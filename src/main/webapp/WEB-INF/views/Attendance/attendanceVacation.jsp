<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>휴가관리</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
				<div class="sideContents Attendance">
					<h2>휴가관리</h2>
					<div class="Attendance_container">
						<div class="Attendance_vacation">
							<div class="vacation_container">
								<h3>휴가 보유 현황</h3>
								<div class="vacation_row vacation_header">
									<div class="vacation_col">
										<span>총 휴가</span>
									</div>
									<div class="vacation_col">
										<span>사용</span>
									</div>
									<div class="vacation_col">
										<span>잔여</span>
									</div>
								</div>
								<div class="vacation_row">
									<div class="vacation_col">${annualLeave.annual_leave_num}일</div>
									<div class="vacation_col">${annualLeave.use_num}일</div>
									<div class="vacation_col">${annualLeave.remaining_leaves}일</div>
								</div>
							</div>
						</div>

						<div style="padding: 5px;"></div>

						<div class="vacation_status">
							<h3>휴가 사용 내역</h3>
							<div class="vacation_row vacation_header">
								<div class="vacation_col">
									<span>번호</span>
								</div>
								<div class="vacation_col">
									<span>휴가 종류</span>
								</div>
								<div class="vacation_col">
									<span>사용 기간</span>
								</div>
								<div class="vacation_col">
									<span>일수</span>
								</div>
							</div>
							<c:forEach var="request" items="${leaveRequests}"
								varStatus="status">
								<div class="vacation_row">
									<div class="vacation_col">${((cpage - 1) * 10) + status.count}
									</div>
									<div class="vacation_col">${request.leave_type}</div>
									<div class="vacation_col">${request.start_date}~
										${request.end_date}</div>
									<div class="vacation_col">${request.request_leave_days.intValue()}일</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="pagination">
						<!-- 이전 페이지로 이동 -->
						<a
							href="/annualLeave/attendanceVacation?cpage=${cpage > 1 ? cpage - 1 : 1}"
							class="prev"> <i class='bx bx-chevron-left'></i>
						</a>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${startNavi}" end="${endNavi}">
							<a href="/annualLeave/attendanceVacation?cpage=${i}"
								class="${i == cpage ? 'active' : ''}">${i}</a>
						</c:forEach>

						<!-- 다음 페이지로 이동 -->
						<a
							href="/annualLeave/attendanceVacation?cpage=${cpage + 1 > pageTotalCount ? pageTotalCount : cpage + 1}"
							class="next"> <i class='bx bx-chevron-right'></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
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

</html>