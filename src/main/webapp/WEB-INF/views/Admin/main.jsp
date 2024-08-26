<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wit Works</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script defer src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script defer src="/js/employee.js"></script>
</head>

<body class="membership_body">
	<div class="container">
		<!-- 공통영역 -->
		<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp"%>
		<!-- 공통영역 끝 -->
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents adminCont">
				<div class="left">
					<div class="leftTop">
						<span class="main_profile"> <img src="${employee.photo}"
							alt="프로필 이미지" class="profileImg">
						</span>
						<div class="dept-role">${employee.dept_code}
							${employee.role_code}</div>
						<div class="username">${employee.name}</div>
						<div class="eApprBox">
							<a href="/eApproval/admin/apprList?type=todo&cPage=1">
								<div class="eApprRows">결재 대기 문서</div> <span class="docuNum">${todoNum}</span>
							</a> <a href="/eApproval/admin/apprList?type=upcoming&cPage=1">
								<div class="eApprRows">결재 예정 문서</div> <span class="docuNum">${upcomingNum}</span>
							</a> <a href="/eApproval/admin/privateList?type=view&cPage=1">
								<div class="eApprRows">참조 문서 ( 미확인 )</div> <span class="docuNum">${refeNum}</span>
							</a>
						</div>
					</div>
					<div class="leftBottom">
						<div id="date"></div>
						<h3 id="clock"></h3>
						<div class="attendance-btn">
							<div class="start">
								<button type="button" id="start_button">
									<i class="bx bxs-id-card"></i>출근
								</button>
								<span class="check-time" id="start_time_display">00:00</span>
							</div>
							<div class="end">
								<button type="button" id="end_button">
									<i class='bx bxs-home'></i>퇴근
								</button>
								<span class="check-time" id="end_time_display">00:00</span>
							</div>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="contBox">
						<div class="leftChart chartBox">
							<canvas id="doughNutChart"></canvas>
						</div>
						<div class="rightChart chartBox">
							<canvas id="docuStatusChart"></canvas>
							<canvas id="empRoleChart"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="overlay">
		<div id="popup" class="popup">
			<h2>추가 정보 입력</h2>
			<form id="insertForm" action="/employee/update_info" method="post">
				<input type="hidden" name="emp_no" value="${employee.emp_no}">
				<div class="input-container">
					<input type="password" name="pw" id="pw" placeholder="비밀번호"
						required> <span class="valid-check error" id="pwCheck">&#x2716;</span>
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
					<input type="text" name="ssn" id="ssn" placeholder="주민등록번호"
						required> <span class="valid-check error" id="ssnCheck">&#x2716;</span>
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
	</div>
	<script>
		$(document)
				.ready(
						function() {

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

							// 사이드바 토글 버튼
							let btn = document.querySelector("#btn");
							let sideBar = document.querySelector(".sideBar");

							btn.onclick = function() {
								sideBar.classList.toggle("active");
							};

							// 실시간 시간 업데이트
							function updateClock() {
								var now = new Date();
								var date = now.getFullYear() + '년 '
										+ (now.getMonth() + 1) + '월 '
										+ now.getDate() + '일';
								var days = [ '일', '월', '화', '수', '목', '금', '토' ];
								var day = days[now.getDay()];
								// AM/PM 형식으로 시간 표시
								var options = {
									hour : 'numeric',
									minute : 'numeric',
									second : 'numeric',
									hour12 : true
								// 12시간 형식 사용, AM/PM 표기
								};
								var time = now.toLocaleTimeString('en-US',
										options);

								$('#date').text(date + ' (' + day + ')');
								$('#clock').text(time);
							}

							setInterval(updateClock, 1000);
							updateClock(); // 페이지 로드 시 초기 시간 설정

							$.ajax({
								url : '/employee/getEmpNumByDept',
								method : 'GET',
								success : function(data) {

									let labels = [];
									let counts = [];

									data.forEach(function(i) {
										labels.push(i.DEPT_TITLE);
										counts.push(i.EMPNUM);
									});

									const ctx = $('#doughNutChart');
									const doughNutChart = new Chart(ctx, {
										type : 'doughnut',
										data : {
											labels : labels,
											datasets : [ {
												label : '인원',
												data : counts,
												backgroundColor : [ '#DDECF3',
														'#EED9E5', '#DBE8D5',
														'#F3E8AE', '#C4A4D1' ],
												borderColor : [ '#81DAC6',
														'#C8DD9F', '#F5D48F',
														'#F28376', '#C4A4D1' ],
												borderWidth : 1
											} ]
										},
										options : {
											responsive : true,
											plugins : {
												legend : {
													position : 'top',
													labels : {
														font : {
															size : 16
														}
													}
												},
												title : {
													display : true,
													text : '부서별 사원 수',
													font : {
														size : 24
													}
												}
											}
										}
									});
								}
							});
							$
									.ajax({
										url : '/eApproval/getDocuStatus',
										method : 'GET',
										success : function(data) {
											let labels = [];
											let apprCounts = [];
											let returnCounts = [];

											data
													.forEach(function(i) {
														labels.push(i.NAME);
														apprCounts
																.push(i.APPROVED_COUNT);
														returnCounts
																.push(i.RETURN_COUNT);
													});

											const ctx = $('#docuStatusChart');
											const docuStatusChart = new Chart(
													ctx,
													{
														type : 'bar',
														data : {
															labels : [ '업무 기안',
																	'휴가 신청서',
																	'지각 사유서' ],
															datasets : [
																	{
																		label : '반려',
																		data : returnCounts,
																		borderColor : 'rgba(255, 99, 132, 1)',
																		backgroundColor : 'rgba(255, 99, 132, 0.5)',
																		borderWidth : 2,
																		borderRadius : 5,
																		borderSkipped : false
																	},
																	{
																		label : '결재',
																		data : apprCounts,
																		borderColor : 'rgba(54, 162, 235, 1)',
																		backgroundColor : 'rgba(54, 162, 235, 0.5)',
																		borderWidth : 2,
																		borderRadius : 5,
																		borderSkipped : false
																	} ]
														},
														options : {
															responsive : true,
															plugins : {
																legend : {
																	position : 'top',
																	labels : {
																		font : {
																			size : 14
																		}
																	}
																},
																title : {
																	display : true,
																	text : '문서별 결재 현황',
																	font : {
																		size : 20
																	}
																}
															}
														}
													});
										}
									});
							$
									.ajax({
										url : '/employee/getEmpNumByRole',
										method : 'GET',
										success : function(data) {

											let labels = [];
											let totalCounts = [];
											let femaleCounts = [];
											let maleCounts = [];

											data
													.forEach(function(i) {
														labels
																.push(i.ROLE_TITLE);
														totalCounts
																.push(i.TOTAL_COUNT);
														femaleCounts
																.push(i.FEMALE_COUNT);
														maleCounts
																.push(i.MALE_COUNT);
													});

											const ctx = $('#empRoleChart');
											const empRoleChart = new Chart(
													ctx,
													{
														data : {
															labels : labels,
															datasets : [
																	{
																		type : 'bar',
																		label : '여성 사원수',
																		data : femaleCounts, // 직급별 여성 사원수
																		backgroundColor : 'rgba(255, 99, 132, 0.2)', // 핑크 색상
																		borderColor : 'rgba(255, 99, 132, 1)',
																		borderWidth : 1
																	},
																	{
																		type : 'bar',
																		label : '남성 사원수',
																		data : maleCounts, // 직급별 남성 사원수
																		backgroundColor : 'rgba(54, 162, 235, 0.2)', // 파란색
																		borderColor : 'rgba(54, 162, 235, 1)',
																		borderWidth : 1
																	},
																	{
																		type : 'line',
																		label : '총 사원수',
																		data : totalCounts, // 직급별 총 사원수
																		borderColor : 'rgba(75, 192, 192, 1)',
																		backgroundColor : 'rgba(75, 192, 192, 0.2)',
																		fill : false,
																		tension : 0.1
																	} ]
														},
														options : {
															responsive : true,
															scales : {
																x : {
																	title : {
																		display : true,
																		text : '직급'
																	}
																},
																y : {
																	beginAtZero : true,
																	title : {
																		display : true,
																		text : '사원 수'
																	}
																}
															},
															plugins : {
																title : {
																	display : true,
																	text : '직급별 성별 사원 수와 총 사원 수',
																	font : {
																		size : 20
																	}
																},
																tooltip : {
																	mode : 'index',
																	intersect : false,
																}
															}
														}
													});
										}
									});
						});
	</script>
</body>

</html>