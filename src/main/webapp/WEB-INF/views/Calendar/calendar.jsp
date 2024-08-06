<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/lwh.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.global.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
				<li><a href="/"> <i class='bx bxs-home-alt-2'></i> <span
						class="navItem">홈</span></a> <span class="toolTip">홈</span></li>
				<li><a href="#"> <i class='bx bx-paperclip'></i> <span
						class="navItem">주소록</span></a> <span class="toolTip">주소록</span></li>
				<li><a href="/board/list"> <i class="bx bxs-grid-alt"></i>
						<span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
				<li><a href="/calendar/calendar"> <i
						class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a> <span
					class="toolTip">캘린더</span></li>
				<li><a href="#"> <i class='bx bxs-message-dots'></i> <span
						class="navItem">메신저</span></a> <span class="toolTip">메신저</span></li>
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
		<!-- 공통역역 끝 -->
		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<!--마이페이지로 이동-->
				<span class="myName"><img src="/resources/img/푸바오.png"
					alt="프로필 사진" class="userImg"><a href="/employee/mypage">${employee.name}
						${employee.role_code}</a></span> <span class="logOut"><a
					href="/employee/logout">LogOut</a></span>
			</div>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">캘린더</h2>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn">일정 등록</button>
					</div>
					<div class="addressListPrivate">
						<ul class="privateList">
							<li class="toggleItem">
								<h3 class="toggleTit">내 캘린더</h3>
								<ul class="subList calendarList">
									<li><input type="checkbox" id="myCheckBox"
										name="myCheckBox" class="active"> <label
										for="myCheckBox">내 일정(기본)</label></li>
									<c:forEach items="${list}" var="dto">
										<li><input type="checkbox"> <label>${dto.calendar_name}</label>
											<span class="sideSelectDel" data-seq="${dto.calendar_seq}">&times;</span>
											<input type="hidden" id="${dto.calendar_seq}"
											value="${dto.calendar_seq}"></li>
									</c:forEach>
									<div>
										<span class="sideCalendarAdd"><i
											class='bx bx-plus-medical'></i> <span class="myCalendarAdd">내
												캘린더 추가</span>
											<div class="myCalendarPopup">
												<header>
													<h3>
														내 캘린더 추가<span class="myPopupClose">&times;</span>
													</h3>
												</header>
												<div class="content">
													<form id="calendarForm" action="/calendar/insertCalendar"
														method="post">
														<input type="hidden" name="emp_no"> <input
															type="hidden" name="dept_code"> <input
															type="hidden" name="calendar_code"> <input
															type="text" name="calendar_name" id="calendar_name">
													</form>
												</div>
												<footer>
													<div class="btns">
														<button id="sideMyAdd" class="okBtn">확인</button>
														<button id="sideMyCancel" class="cancelBtn">취소</button>
													</div>
												</footer>
											</div> </span>
									</div>
								</ul>
							</li>
						</ul>
					</div>
					<div class="addressListGroup">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggleTit">부서 캘린더</h3>
								<ul class="subList calendarList">
									<li><input type="checkbox" id="deptMeeting"
										name="deptMeeting"> <label for="deptMeeting">회의
											일정(기본)</label></li>
									<li><input type="checkbox" id="deptBirthday"
										name="deptBirthday"> <label for="deptBirthday">부서원
											생일(기본)</label></li>
									<c:forEach items="${list}" var="dto">
										<li><input type="checkbox"> <label>${dto.calendar_name}</label>
											<span class="sideSelectDel" data-seq="${dto.calendar_seq}">&times;</span>
											<input type="hidden" id="${dto.calendar_seq}"
											value="${dto.calendar_seq}"></li>
									</c:forEach>
									<div>
										<span class="sideCalendarAdd"><i
											class='bx bx-plus-medical'></i> <span class="deptCalendarAdd">부서
												캘린더 추가</span>
											<div class="deptCalendarPopup">
												<header>
													<h3>
														부서 캘린더 추가<span class="deptPopupClose">&times;</span>
													</h3>
												</header>
												<div class="content">
													<form id="deptCalendarForm"
														action="/calendar/insertCalendar" method="post">
														<input type="hidden" name="emp_no"> <input
															type="hidden" name="dept_code"> <input
															type="hidden" name="calendar_code"> <input
															type="text" name="calendar_name" id="calendar_name">
													</form>
												</div>
												<footer>
													<div class="btns">
														<button id="sideDeptAdd" class="okBtn">확인</button>
														<button id="sideDeptCancel" class="cancelBtn">취소</button>
													</div>
												</footer>
											</div> </span>
									</div>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div class="sideContents calendarBox">
					<div id="calendar" class="calendar"></div>
				</div>
			</div>
		</div>
		<!-- 날짜 박스 눌렀을 시 모달 -->
		<div id="calendarModal" class="modal">
			<div class="modalContent">
				<h1>
					일정등록<span class="modalClose">&times;</span>
				</h1>
				<div class="calendarAdd">
					<form id="eventForm" action="/events/save_event" method="post">
						<ul>
							<li><span>일정명</span>
								<div>
									<input type="text" name="title">
								</div></li>
							<li><span>일정기간</span>
								<div>
									<input type="date" class="startDate dateInput" id="startDate"
										name="startDate"> <input type="time"
										class="startDate dateInput" id="startTime" name="startTime">
									~ <input type="date" class="endDate dateInput" id="endDate"
										name="endDate"> <input type="time"
										class="endDate dateInput" id="endTime" name="endTime">
								</div></li>
							<li><span>내 캘린더</span>
								<div>
									<select name="calendar_name" id="choiCalendar">
										<option>웡히 캘린더</option>
										<option>바보 캘린더</option>
									</select>
								</div></li>
							<li><span>장소</span>
								<div>
									<input type="text" class="eventLocation" name="location">
								</div></li>
							<li><span>내용</span>
								<div>
									<textarea id="calendarText" name="content"></textarea>
								</div></li>
							<li>
								<div class="btns">
									<button type="submit" id="addBtn" class="okBtn">완료</button>
									<button type="button" class="cancelBtn">취소</button>
								</div>
							</li>
						</ul>
						<input type="hidden" name="start_at" id="start_at"> <input
							type="hidden" name="end_at" id="end_at">
					</form>
				</div>
			</div>
		</div>
		<!-- event 클릭 시 모달 -->
		<div id="eventModal" class="modal">
			<div class="modalContent">
				<h1>
					일정 내용<span class="modalClose" id="eventModalClose">&times;</span>
				</h1>
				<div class="eventCheck">
					<form id="eventEditForm" action="events/editEvent" method="post">
						<input type="hidden" name="events_seq" id="eventSeq">
						<ul>
							<li><span>일정명</span>
								<div>
									<input type="text" class="eventName" name="title" disabled>
								</div></li>
							<li><span>일정기간</span>
								<div>
									<input type="date" id="eventStartDate"
										class="startDate dateInput" name="editStartDate" disabled>
									<input type="time" id="eventStartTime"
										class="startDate dateInput" name="editStartTime" disabled>
									~ <input type="date" id="eventEndDate"
										class="endDate dateInput" name="editEndDate" disabled>
									<input type="time" id="eventEndTime" class="endDate dateInput"
										name="editEndTime" disabled>
								</div></li>
							<li><span>내 캘린더</span>
								<div>
									<select id="choiEvent" name="calendar_name" disabled>
										<option>웡히 캘린더</option>
										<option>바보 캘린더</option>
									</select>
								</div></li>
							<li><span>장소</span>
								<div>
									<input type="text" class="eventLocation" name="location"
										disabled>
								</div></li>
							<li><span>내용</span>
								<div>
									<textarea id="eventText" name="content" disabled></textarea>
								</div></li>
							<li>
								<div class="btns">
									<button type="button" id="editBtn">수정</button>
									<button type="submit" id="confirmBtn" class="okBtn">확인</button>
									<button type="button" class="deleteBtn" id="eventDel">삭제</button>
									<button type="button" class="cancelBtn editCancelBtn">취소</button>
								</div>
							</li>
						</ul>
						<input type="hidden" name="editStartAt" id="editStartAt">
						<input type="hidden" name="editEndAt" id="editEndAt">
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- sidebar 공통요소 script -->
	<script>
        let btn = document.querySelector("#btn");
        let sideBar = document.querySelector(".sideBar");

        btn.onclick = function () {
            sideBar.classList.toggle("active");
        };

        const toggleItems = document.querySelectorAll('.toggleItem');

        toggleItems.forEach(function (toggleItem) {
            const toggleTit = toggleItem.querySelector('.toggleTit');
            const subList = toggleItem.querySelector('.subList');

            toggleTit.addEventListener('click', function () {
                subList.classList.toggle('active');
                toggleTit.classList.toggle('active'); // 이미지 회전을 위해 클래스 추가
            });
        });
		
        // 내 캘린더 추가 버튼
        $('.myCalendarAdd').on('click', function () {
            $('.myCalendarPopup').show();
        })
        
        // 내 캘린더 추가 팝업에서 확인 버튼
        $('#sideMyAdd').on('click', function(){
        	let calendar_name = $('#calendar_name').val().trim();
        	if(calendar_name !== ""){
        		console.log(calendar_name);
        		// 내 캘린더 추가
        		$('#my_calendar_code').val('MY');
        		$("#calendarForm").submit();
        		
        	}else{
        		alert("캘린더 이름을 입력해주세요.");
        	}        	
        });
		
        // 내 캘린더 팝업 x 버튼
        $('.myPopupClose').on('click', function () {
            $('.myCalendarPopup').hide();
        })
        
        
        
       	// 캘린더 삭제(x)버튼 눌렀을 시
        $('.sideSelectDel').on('click', function() {
        // 클릭된 버튼의 data-seq 속성 값을 가져오기
        let calendarSeq = $(this).data('seq');
        // 클릭된 버튼 자체를 저장
        let $this = $(this);
        
        let deleteConfirm = confirm('정말로 이 캘린더를 삭제하시겠습니까?');
        
        if (deleteConfirm) {
            // 사용자가 확인을 클릭한 경우 삭제 요청을 서버로 전송
            $.ajax({
                url: '/calendar/deleteCalendar',
                type: 'GET',
                data: { calendarSeq: calendarSeq },
                success: function(response) {
                    // 삭제가 성공했으면 해당 항목을 DOM에서 제거
                    $this.closest('li').remove();
                },
                error: function() {
                    alert('삭제 요청 중 오류가 발생했습니다.');
                }
            });
        }
    });
		
        // 부서 캘린더 추가 버튼
        $('.deptCalendarAdd').on('click', function () {
            $('.deptCalendarPopup').show();
        })
        
        $('#sideDeptAdd').on('click', function(){
        	let calendar_name = $('#calendar_name').val().trim();
        	if(calendar_name !== ""){
        		console.log(calendar_name)
        		 // 부서 캘린더 코드 설정
        		$('#dept_calendar_code').val('DEPT');
        		$("#calendarForm").submit();
        		
        	}else{
        		alert("캘린더 이름을 입력해주세요.");
        	}        	
        });
		
        // 부서 캘린더 x 버튼
        $('.deptPopupClose').on('click', function () {
            $('.deptCalendarPopup').hide();
        })

        // 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#editBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            $('#editBtn').hide();
            $('.deleteBtn').hide();
            $('#confirmBtn').show();
            $('.cancelBtn').show();
        });

        // 이벤트 모달창에서 X버튼 눌렀을 시
        $('#eventModalClose').on('click', function () {
            location.reload();
        })

        $('#confirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        e.preventDefault(); // 기본 폼 제출을 방지합니다.

        	let startDate = $('#eventStartDate').val();
        	let startTime = $('#eventStartTime').val();
        	let endDate = $('#eventEndDate').val();
        	let endTime = $('#eventEndTime').val();
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듭니다.
            let dateTimeLocal = startDate + 'T' + startTime;
            let dateTime = new Date(dateTimeLocal);
            let timestamp = dateTime.getTime(); // 밀리초 단위의 타임스탬프
            
            $("#editStartAt").val(timestamp);
            
            dateTimeLocal = endDate + 'T' + endTime;
            dateTime = new Date(dateTimeLocal);
            timestamp = dateTime.getTime(); // 밀리초 단위의 타임스탬프
            
            $("#editEndAt").val(timestamp);

        // 폼을 제출합니다.
        $('#eventEditForm').submit(); // 폼을 제출하여 서버로 데이터를 전송합니다.
    });

        $('.cancelBtn').on('click', function () {
            location.reload();
        })
        
        $('#eventDel').on('click', function (){
        	let eventSeq = $('#eventSeq').val();
        	console.log(eventSeq);
        	location.href = "/events/del_event?eventSeq=" + eventSeq;
        })

        $('.deleteBtn').on('click', function () {
            // 삭제 로직 추가
        })

        $('.plusBtn.sideBtn').on('click', function () {
            $("#calendarModal").show();
            $(".modalClose").on("click", function () {
                $("#calendarModal").hide();
            })
        })

        // 캘린더 기능 시작
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
             // '일 제거'
                dayCellContent: function (e) {
                    return e.dayNumberText.replace('일', '');
                },
                locale: 'ko',
                initialDate: new Date(),
                timeZone: 'Asia/Seoul',
                navLinks: true,
                businessHours: true,
                editable: true,
                dayMaxEvents: true,
                selectable: true,
                buttonText: {
                    today: '오늘',
                    month: '월간',
                    week: '주간',
                    day: '일간',
                    list: '목록'
                },
                events: function (fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: '/events/all_event',  // 서버의 이벤트 데이터 엔드포인트
                        method: 'GET',
                        dataType: 'json',
                        success: function (data) {
                            console.log(data);// 서버로부터 받은 이벤트 데이터를 풀캘린더에 전달합니다.
                            
                            // 날짜와 시간을 ISO 8601 형식으로 변환하는 함수
                            function formatDate(dateStr) {
                                // 문자열을 Date 객체로 변환 (로컬 타임존 기준)
                                let date = new Date(dateStr);

                                // ISO 8601 형식으로 변환하기 위해 로컬 시간 기준으로 포맷팅
                                let year = date.getFullYear();
                                let month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1
                                let day = date.getDate().toString().padStart(2, '0');
                                let hours = date.getHours().toString().padStart(2, '0');
                                let minutes = date.getMinutes().toString().padStart(2, '0');
                                let seconds = date.getSeconds().toString().padStart(2, '0');

                                // ISO 8601 형식으로 조합
                                let isoString = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes + ':' + seconds;

                                return isoString;
                            }                          
                            successCallback(data.map(event => ({
                                title: event.title,
                                start: formatDate(event.start_date), // 변환된 시작 날짜
                                end: formatDate(event.end_date),     // 변환된 종료 날짜
                                extendedProps: {
                                	events_seq : event.events_seq,
                                	calendar_name: event.calendar_name,
                                    location: event.location,
                                    content: event.content
                                }
                            })));
                        },
                        error: function () {
                            alert('이벤트를 불러오는데 실패했습니다.');
                            failureCallback();
                        }
                    });
                },
                dateClick: function (info) {
                    // 날짜 클릭 시 발생할 이벤트
                    $('.startDate').val(info.dateStr);
                    $("#calendarModal").show();
                    $(".modalClose").on("click", function () {
                        $("#calendarModal").hide();
                    });
                },
                eventClick: function (info) {
                	
                	// console.log(info);
                	
                    // 이벤트 클릭 시 발생할 이벤트
                    let eventTitle = info.event.title;
                    let eventSeq = info.event.extendedProps.events_seq;
                    let eventChoice = info.event.extendedProps.calendar_name;
                    let eventContent = info.event.extendedProps.content;
                    let eventLocation = info.event.extendedProps.location;

                    let eventStartUTC = new Date(info.event.start);
                    let eventEndUTC = info.event.end ? new Date(info.event.end) : new Date(eventStartUTC.getTime() + 24 * 60 * 60 * 1000);

                    let eventStartKST = new Date(eventStartUTC.toLocaleString('en-US', { timeZone: 'Asia/Seoul' }));
                    let eventEndKST = new Date(eventEndUTC.toLocaleString('en-US', { timeZone: 'Asia/Seoul' })); 

                    let eventStartDate = eventStartKST.toISOString().split('T')[0];
                    let eventStartTime = eventStartKST.toISOString().split('T')[1].substring(0, 5);
                    let eventEndDate = eventEndKST.toISOString().split('T')[0];
                    let eventEndTime = eventEndKST.toISOString().split('T')[1].substring(0, 5);

                    $('.eventName').val(eventTitle);
                    $('#eventSeq').val(eventSeq);
                    $('#eventStartDate').val(eventStartDate);
                    $('#eventStartTime').val(eventStartTime);
                    $('#eventEndDate').val(eventEndDate);
                    $('#eventEndTime').val(eventEndTime);
                    $('#choiCalendar').val(eventChoice);
                    $('.eventLocation').val(eventLocation);
                    $('#eventText').val(eventContent);
					
                    $("#eventModal").show();
                    $(".modalClose").on("click", function () {
                        $("#eventModal").hide();
                    });
                }
            });

            calendar.render();
        });

        document.getElementById('eventForm').addEventListener('submit', function (event) {
            
        	event.preventDefault(); // 기본 폼 제출 동작을 막음
			console.log("폼태그 동작 확인");
        	
        	let startDate = $("#startDate").val();
        	let startTime = $("#startTime").val();
        	let endDate = $("#endDate").val();
        	let endTime = $("#endTime").val();
        	
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듭니다.
            let dateTimeLocal = startDate + 'T' + startTime;
            let dateTime = new Date(dateTimeLocal);
            let timestamp = dateTime.getTime(); // 밀리초 단위의 타임스탬프
            
			$("#start_at").val(timestamp);
            
			dateTimeLocal = endDate + 'T' + endTime;
            dateTime = new Date(dateTimeLocal);
            timestamp = dateTime.getTime(); // 밀리초 단위의 타임스탬프
            
            $("#end_at").val(timestamp);
 			event.target.submit();
        });
        
			/* document.getElementById('eventEditForm').addEventListener('submit', function (event) {
            
        	event.preventDefault(); // 기본 폼 제출 동작을 막음
			console.log("폼태그 동작 확인");
        	
        	let eventStartDate = $("#eventStartDate").val();
        	let eventStartTime = $("#eventStartTime").val();
        	let eventEndDate = $("#eventEndDate").val();
        	let eventEndTime = $("#eventEndTime").val();
        	
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듭니다.
            let dateTimeLocal = eventStartDate + 'T' + eventStartTime;
            let dateTime = new Date(dateTimeLocal);
            let timestamp = dateTime.getTime(); // 밀리초 단위의 타임스탬프
            
			$("#editStartAt").val(timestamp);
            
            console.log(timestamp);
            
			dateTimeLocal = eventEndDate + 'T' + eventEndTime;
            dateTime = new Date(dateTimeLocal);
            timestamp = dateTime.getTime(); // 밀리초 단위의 타임스탬프
            
            $("#editEndAt").val(timestamp);
			 event.target.submit(); 
        });  */
        
        
        
    </script>
</body>
</html>
