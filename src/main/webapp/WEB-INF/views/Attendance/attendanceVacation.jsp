<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
				<li><a href="/eApproval/home"> <i class='bx bx-clipboard'></i>
						<span class="navItem">전자결재</span></a> <span class="toolTip">전자결재</span></li>
				<li><a href="/attendance/attendance"> <i
						class='bx bxs-briefcase-alt-2'></i> <span class="navItem">근태관리</span></a>
					<span class="toolTip">근태관리</span></li>
				<li><a href="/reservation/home?type=meetingRoom&cPage=1"> <i
						class='bx bxs-check-square'></i> <span class="navItem">예약</span></a> <span
					class="toolTip">예약</span></li>
			</ul>
		</div>
		<!-- 공통역역 끝 -->

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<!--마이페이지로 이동-->
				<span class="myName"> <img src="/resources/img/푸바오.png"
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
							<c:forEach var="request" items="${leaveRequests}">
								<div class="vacation_row">
									<div class="vacation_col">${request.document_seq}</div>
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
							href="/annualLeave/attendance_vacation?cpage=${cpage > 1 ? cpage - 1 : 1}"
							class="prev"> <i class='bx bx-chevron-left'></i>
						</a>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${startNavi}" end="${endNavi}">
							<a href="/annualLeave/attendance_vacation?cpage=${i}"
								class="${i == cpage ? 'active' : ''}">${i}</a>
						</c:forEach>

						<!-- 다음 페이지로 이동 -->
						<a
							href="/annualLeave/attendance_vacation?cpage=${cpage < pageTotalCount ? cpage + 1 : pageTotalCount}"
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