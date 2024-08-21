<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.global.min.js"></script>
<script src="/resources/js/employee.js"></script>
</head>

<body class="membership_body">
	<div class="container">
		<!-- 공통영역 -->
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<!-- 공통영역 끝 -->
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>

			<div class="contents">
				<div class="left">
					<div class="leftTop">
						<span class="main_profile"> <img src="/img/푸바오.png"
							alt="프로필 사진" class="profileImg">
						</span>
						<div class="dept-role">${employee.dept_code}
							${employee.role_code}</div>
						<div class="username">${employee.name}</div>
					</div>
					<div class="leftBottom">
						<div id="date"></div>
						<h3 id="clock"></h3>
						<div class="attendance-btn">
							<div class="start">
								<button type="button" id="start_button"><i class="bx bxs-id-card"></i>출근</button>
								<span class="check-time" id="start_time_display">00:00</span>
							</div>
							<div class="end">
								<button type="button" id="end_button"><i class='bx bxs-home'></i>퇴근</button>
								<span class="check-time" id="end_time_display">00:00</span>
							</div>
						</div>
					</div>
				</div>
				<div class="center">
					<div class="boardList">
						<div class="notiList">
							<div class="rows notiHeader">
								<div class="cols boardSeq">
									<span>자유 게시판</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>날짜</span>
								</div>
								<c:choose>
									<c:when test="${report=='true'}">
										<div class="cols boardView">신고유형</div>
									</c:when>
									<c:otherwise>
										<div class="cols boardView">조회수</div>
									</c:otherwise>
								</c:choose>

							</div>

							<!-- 게시물 목록 출력 -->
							<!-- varStatus 를 이용하여 최신 게시물의 no를 1로 했다! -->
							<!-- 매퍼파일에서 최신순으로 내가 정렬을 해놨는데, 최신순으로 정렬을 했을때 사용가능!~  -->
							<!-- 이렇게도 할 수 있어 밍쥬야 jsp에서 번호를 수동으로 할당 해주는거래-->
							<c:forEach var="board" items="${boardList}" varStatus="status">
								<div class="rows notiConts">
									<div class="cols boardSeq">
										<span>${status.index + 1}</span>
									</div>
									<div class="cols boardTitle" onclick="toDetailBoard(this)"
										data-seq="${board.board_seq}">
										<span>${board.title}</span>
									</div>
									<div class="cols boardWriter">
										<!-- 여기서 조인해서 emp_no 자리에 닉네임이 나오게끔 했어! -->
										<span>${board.emp_no}</span>
									</div>
									<c:choose>
										<c:when test="${report=='true'}">
											<div class="cols boardDate">
												<fmt:formatDate value="${board.report_date}"
													pattern="yyyy-MM-dd" />
											</div>
										</c:when>
										<c:otherwise>
											<div class="cols boardDate">
												<fmt:formatDate value="${board.write_date}"
													pattern="yyyy-MM-dd" />
											</div>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${report=='true'}">
											<div class="cols boardView">
												<span>${board.report_type}</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="cols boardView">
												<span>${board.views}</span>
											</div>
										</c:otherwise>
									</c:choose>

								</div>
							</c:forEach>
						</div>
						<div class="notiList">
							<div class="rows notiHeader">
								<div class="cols boardSeq">
									<span>공지 게시판</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>날짜</span>
								</div>
								<c:choose>
									<c:when test="${report=='true'}">
										<div class="cols boardView">신고유형</div>
									</c:when>
									<c:otherwise>
										<div class="cols boardView">조회수</div>
									</c:otherwise>
								</c:choose>

							</div>

							<!-- 게시물 목록 출력 -->
							<!-- varStatus 를 이용하여 최신 게시물의 no를 1로 했다! -->
							<!-- 매퍼파일에서 최신순으로 내가 정렬을 해놨는데, 최신순으로 정렬을 했을때 사용가능!~  -->
							<!-- 이렇게도 할 수 있어 밍쥬야 jsp에서 번호를 수동으로 할당 해주는거래-->
							<c:forEach var="board" items="${noticeList}" varStatus="status">
								<div class="rows notiConts">
									<div class="cols boardSeq">
										<span>${status.index + 1}</span>
									</div>
									<div class="cols boardTitle" onclick="toDetailNotice(this)"
										data-seq="${board.board_seq}">
										<span>${board.title}</span>
									</div>
									<div class="cols boardWriter">
										<!-- 여기서 조인해서 emp_no 자리에 닉네임이 나오게끔 했어! -->
										<span>${board.emp_no}</span>
									</div>
									<c:choose>
										<c:when test="${report=='true'}">
											<div class="cols boardDate">
												<fmt:formatDate value="${board.report_date}"
													pattern="yyyy-MM-dd" />
											</div>
										</c:when>
										<c:otherwise>
											<div class="cols boardDate">
												<fmt:formatDate value="${board.write_date}"
													pattern="yyyy-MM-dd" />
											</div>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${report=='true'}">
											<div class="cols boardView">
												<span>${board.report_type}</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="cols boardView">
												<span>${board.views}</span>
											</div>
										</c:otherwise>
									</c:choose>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rightTop">
						<a href="/eApproval/home">
							전자 결재&nbsp;<i class='bx bx-home' style='color: #558bcf'></i> 
						</a>
						<div class="eApprBox">
							<div class="eApprRows">
								<div class="eApprCols">
								<a href="/eApproval/apprList?type=todo&cPage=1">
									결재 대기&nbsp;<i class='bx bx-file bx-flip-horizontal' style='color: #558bcf'></i>
									<span class="docuNum">${todoNum}</span>
								</a>
								</div>
								<div class="eApprCols">
								<a href="/eApproval/privateList?type=view&cPage=1">
									참조&nbsp;<i class='bx bx-file bx-flip-horizontal' style='color: #558bcf'></i> 
									<span class="docuNum">${refeNum}</span>
								</a>
								</div>	
							</div>
							<div class="eApprRows">
								<div class="eApprCols">
								<a href="/eApproval/privateList?type=write&cPage=1">
									기안 진행중&nbsp;<i class='bx bx-file bx-flip-horizontal' style='color: #558bcf'></i>
									<span class="docuNum">${apprNum}</span>
								</a>
								</div>
								<div class="eApprCols">
								<a href="/eApproval/privateList?type=save&cPage=1">
									임시 저장&nbsp;<i class='bx bx-file bx-flip-horizontal' style='color: #558bcf'></i>
									<span class="docuNum">${saveNum}</span>
								</a>
								</div>	
							</div>
						</div>
					</div>
					<div class="rightBottom">
						<div id="calendar" class="calendar"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="overlay"></div>
	<div id="popup" class="popup">
		<h2>추가 정보 입력</h2>
		<form id="insertForm" action="/employee/update_info" method="post">
			<input type="hidden" name="emp_no" value="${employee.emp_no}">
			<div class="input-container">
				<input type="password" name="pw" id="pw" placeholder="비밀번호" required>
				<span class="valid-check error" id="pwCheck">&#x2716;</span>
			</div>
			<label id="resultpw"></label>
			<div class="input-container">
				<input type="password" name="checkpw" id="checkpw"
					placeholder="비밀번호 확인" required> <span
					class="valid-check error" id="checkpwCheck">&#x2716;</span>
			</div>
			<label id="resultcheckpw"></label>
			<div class="input-container">
				<input type="text" name="nickname" id="nickname" placeholder="닉네임"
					required> <span class="valid-check error"
					id="nicknameCheck">&#x2716;</span>
			</div>
			<label id="resultNickname"></label>
			<button type="button" class="nickname-button" id="checkNickname">중복체크</button>
			<div class="input-container">
				<input type="text" name="ssn" id="ssn" placeholder="주민등록번호" required>
				<span class="valid-check error" id="ssnCheck">&#x2716;</span>
			</div>
			<label id="resultSSN"></label>
			<div class="input-container">
				<input type="text" name="phone" id="phone" placeholder="휴대폰"
					required> <span class="valid-check error" id="phoneCheck">&#x2716;</span>
			</div>
			<label id="resultPhone"></label>
			<div class="input-container">
				<input type="email" name="email" id="email" placeholder="이메일"
					required> <span class="valid-check error" id="emailCheck">&#x2716;</span>
			</div>
			<label id="resultEmail"></label> <input type="text" name="zip_code"
				id="zip_code" placeholder="우편주소" required readonly>
			<button type="button" class="address-button" id="postcode">주소
				찾기</button>
			<input type="text" name="address" id="address" placeholder="주소"
				required readonly> <input type="text" name="detail_address"
				placeholder="상세주소" required>
			<button type="submit" class="submit-button">입력하기</button>
		</form>
	</div>

	<script>
		$(document).ready(
				function() {
					// 사이드바 토글 버튼
					let btn = document.querySelector("#btn");
					let sideBar = document.querySelector(".sideBar");

					btn.onclick = function() {
						sideBar.classList.toggle("active");
					};

					// 첫 로그인시 추가 정보 입력 팝업
					var firstLogin = "${sessionScope.FirstLogin}" === "true";
					if (firstLogin) {
						$(".overlay").show();
						$("#popup").show();
					}

					// 팝업 외부 클릭 방지
					$(".overlay").on("click", function(e) {
						e.stopPropagation();
						alert("추가 정보를 입력 후 제출하세요.");
					});

					// 팝업 내부 클릭 시 이벤트 전파 방지
					$("#popup").on("click", function(e) {
						e.stopPropagation();
					});

					// 실시간 시간 업데이트
					function updateClock() {
						var now = new Date();
						var date = now.getFullYear() + '년 '
								+ (now.getMonth() + 1) + '월 ' + now.getDate()
								+ '일';
						var days = [ '일', '월', '화', '수', '목', '금', '토' ];
						var day = days[now.getDay()];
						// AM/PM 형식으로 시간 표시
						var options = {
							hour: 'numeric',
							minute: 'numeric',
							second: 'numeric',
							hour12: true // 12시간 형식 사용, AM/PM 표기
						};
						var time = now.toLocaleTimeString('en-US', options);

						$('#date').text(date + ' (' + day + ')');
						$('#clock').text(time);
					}

					setInterval(updateClock, 1000);
					updateClock(); // 페이지 로드 시 초기 시간 설정
				});

		document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');

			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar : {
					left : 'prev,next',
					center : 'title',
					right : 'today'
				},
				dayCellContent : function(e) {
					return e.dayNumberText.replace('일', '');
				},
				locale : 'ko',
				initialView : 'dayGridMonth',
				initialDate : new Date(),
				editable : true,
				selectable : true,
				dayMaxEvents : true, // allow "more" link when too many events
				// multiMonthMaxColumns: 1, // guarantee single column
				// showNonCurrentDates: true,
				// fixedWeekCount: false,
				// businessHours: true,
				weekends : false,
				events : [

				]
			});

			calendar.render();
		});

		function toDetailBoard(e) {
			$
					.ajax({
						url : "/board/views",
						data : {
							board_seq : $(e).data("seq")
						}

					})
					.done(
							function(response) {
								window.location.href = "${pageContext.request.contextPath}/board/detail?boardCode=1&board_seq="
										+ $(e).data("seq")
							})

		}

		function toDetailNotice(e) {
			$
					.ajax({
						url : "/board/views",
						data : {
							board_seq : $(e).data("seq")
						}

					})
					.done(
							function(response) {
								window.location.href = "${pageContext.request.contextPath}/board/detail?boardCode=2&board_seq="
										+ $(e).data("seq")
							})

		}
	</script>
</body>

</html>