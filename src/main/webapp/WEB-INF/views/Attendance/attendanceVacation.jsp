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
<link rel="stylesheet" href="/resources/css/employee.css">
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
				<img src="메인게임.webp" alt="me" class="userImg">
				<div class="nickName">
					<p class="bold">Wit Works</p>
					<p></p>
				</div>
			</div>

			<ul>
				<li><a href="#"> <i class='bx bxs-home-alt-2'></i> <span
						class="navItem">홈</span>
				</a> <span class="toolTip">홈</span></li>
				<li><a href="#"> <i class='bx bx-paperclip'></i> <span
						class="navItem">주소록</span>
				</a> <span class="toolTip">주소록</span></li>
				<li><a href="board2.html"> <i class="bx bxs-grid-alt"></i>
						<span class="navItem">게시판</span>
				</a> <span class="toolTip">게시판</span></li>
				<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span
						class="navItem">캘린더</span>
				</a> <span class="toolTip">캘린더</span></li>
				<li><a href="#"> <i class='bx bxs-message-dots'></i> <span
						class="navItem">메신저</span>
				</a> <span class="toolTip">메신저</span></li>
				<li><a href="#"> <i class='bx bx-clipboard'></i> <span
						class="navItem">전자결재</span>
				</a> <span class="toolTip">전자결재</span></li>
				<li><a href="/attendance/attendance"> <i class='bx bxs-briefcase-alt-2'></i> <span
						class="navItem">근태관리</span>
				</a> <span class="toolTip">근태관리</span></li>
				<li><a href="#"> <i class='bx bxs-check-square'></i> <span
						class="navItem">예약</span>
				</a> <span class="toolTip">예약</span></li>
				<li><a href="#"> <i class='bx bx-sitemap'></i> <span
						class="navItem">조직도</span>
				</a> <span class="toolTip">조직도</span></li>
			</ul>
		</div>
		<!-- 공통역역 끝 -->

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<!--마이페이지로 이동-->
				<span class="myName"> <img src="메인게임.webp"><a href="/employee/mypage">백민주
						사원</a></span> <span class="logOut"><a href="/employee/logout">LogOut</a></span>
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
					<a href="/attendance/attendance_vacation">
						<h3 class="toggleTit">휴가 관리</h3>
					</a>
				</div>
				<div class="sideContents Attendance">
					<h2>휴가관리</h2>
					<div class="Attendance_container">
						<div class="Attendance_vacation">
							<div class="vacation_container">
								<h3>휴가 보유현황</h3>
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
									<div class="vacation_col">15일</div>
									<div class="vacation_col">5일</div>
									<div class="vacation_col">10일</div>
								</div>
							</div>
						</div>
						<div style="padding: 5px;"></div>
						<div class="vacation_status">
							<h3>휴가 사용내역</h3>
							<div class="vacation_row vacation_header">
								<div class="vacation_col">
									<span>번호</span>
								</div>
								<div class="vacation_col">
									<span>신청자</span>
								</div>
								<div class="vacation_col">
									<span>휴가종류</span>
								</div>
								<div class="vacation_col">
									<span>사용기간</span>
								</div>
								<div class="vacation_col">
									<span>일수</span>
								</div>
							</div>
							<div class="vacation_row">
								<div class="week_col">1</div>
								<div class="week_col">백민주</div>
								<div class="week_col">연차</div>
								<div class="week_col">2024-07-24 ~ 2024-07-25</div>
								<div class="week_col">2일</div>
							</div>
							<div class="vacation_row">
								<div class="week_col">2</div>
								<div class="week_col">백민주</div>
								<div class="week_col">연차</div>
								<div class="week_col">2024-07-24 ~ 2024-07-25</div>
								<div class="week_col">2일</div>
							</div>
							<div class="vacation_row">
								<div class="week_col">3</div>
								<div class="week_col">백민주</div>
								<div class="week_col">연차</div>
								<div class="week_col">2024-07-24 ~ 2024-07-25</div>
								<div class="week_col">2일</div>
							</div>
							<div class="vacation_row">
								<div class="week_col">4</div>
								<div class="week_col">백민주</div>
								<div class="week_col">연차</div>
								<div class="week_col">2024-07-24 ~ 2024-07-25</div>
								<div class="week_col">2일</div>
							</div>
							<div class="vacation_row">
								<div class="week_col">5</div>
								<div class="week_col">백민주</div>
								<div class="week_col">연차</div>
								<div class="week_col">2024-07-24 ~ 2024-07-25</div>
								<div class="week_col">2일</div>
							</div>
						</div>
					</div>
					<div class="pagination">
						<a href="javascript:;" class="prev "><i
							class='bx bx-chevron-left'></i></a> <a href="javascript:;"
							class="active">1</a> <a href="javascript:;">2</a> <a
							href="javascript:;">3</a> <a href="javascript:;">4</a> <a
							href="javascript:;">5</a> <a href="javascript:;"
							class="next active"><i class='bx bx-chevron-right'></i></a>
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