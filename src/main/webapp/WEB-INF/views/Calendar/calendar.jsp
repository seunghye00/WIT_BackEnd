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
<link rel="stylesheet" href="/resources/css/wit.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.global.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<!-- 공통영역 -->
	<div class="container">
			<c:choose>
				<c:when test="${employee.role_code eq 'R1'}">
					<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp"%>
				</c:when>
				<c:otherwise>
					<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		        </c:otherwise>
			</c:choose>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
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
								<div class="scrollableContent">  <!-- 스크롤 가능한 콘텐츠를 감싸는 div -->
									<c:forEach items="${plist}" var="dto">
										<li><input type="checkbox"
											id="calendar_${dto.calendar_seq}"
											name="calendar_${dto.calendar_seq}"
											class="<c:out value="${dto.default_yn == 'Y' ? 'active' : ''}" />"
											<c:if test="${dto.default_yn == 'Y'}">checked</c:if>>
											<label for="calendar_${dto.calendar_seq}">${dto.calendar_name}</label>
											<!-- 내 일정(기본)에는 삭제 버튼 없음 기본 생성자는 default='y' --> <c:if
												test="${dto.default_yn != 'Y' }">
												<span class="sidePerSelectDel"
													data-seq="${dto.calendar_seq}" id="sidePerSelectDel">&times;</span>
											</c:if> <input type="hidden" id="hidden_${dto.calendar_seq}"
											value="${dto.calendar_seq}"></li>
									</c:forEach>
									</div>
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
													<form id="perCalendarForm"
														action="/calendar/insertPerCalendar" method="post">
														<input type="text" name="calendar_name" id="calendar_name" maxlength="13" placeholder="최대 13글자">
														<input type="hidden" name="emp_no"> <input
															type="hidden" name="default_yn">
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
								    <div class="scrollableContent">  <!-- 스크롤 가능한 콘텐츠를 감싸는 div -->
								        <c:forEach items="${dlist}" var="dto">
								            <li>
								                <input type="checkbox"
								                    id="calendar_${dto.calendar_seq}"
								                    name="calendar_${dto.calendar_seq}"
								                    class="<c:out value="${dto.default_yn == 'Y' ? 'active' : ''}" />"
								                    <c:if test="${dto.default_yn == 'Y'}">checked</c:if>>
								                <label for="calendar_${dto.calendar_seq}">(${dto.dept_title}) ${dto.calendar_name}</label>
								                <c:if test="${employee.role_code eq 'R2' and dto.default_yn ne 'Y'}">
								                    <span class="sideDepSelectDel" data-seq="${dto.calendar_seq}" id="sideDepSelectDel">&times;</span>
								                </c:if>
								                <input type="hidden" id="${dto.calendar_seq}" value="${dto.calendar_seq}">
								            </li>
								        </c:forEach>
								    </div>
								    <c:if test="${employee.role_code eq 'R2'}">
								        <div>
								            <span class="sideCalendarAdd">
								                <i class='bx bx-plus-medical'></i>
								                <span class="deptCalendarAdd">부서 캘린더 추가</span>
								                <div class="deptCalendarPopup">
								                    <header>
								                        <h3>부서 캘린더 추가<span class="deptPopupClose">&times;</span></h3>
								                    </header>
								                    <div class="content">
								                        <form id="deptCalendarForm" action="/calendar/insertDepCalendar" method="post">
								                            <input type="text" name="calendar_name" id="depCalendarName" maxlength="13" placeholder="최대 13글자">
								                            <input type="hidden" name="dept_code" value="${employee.dept_code}">
								                            <input type="hidden" name="default_yn">
								                        </form>
								                    </div>
								                    <footer>
								                        <div class="btns">
								                            <button id="sideDeptAdd" class="okBtn">확인</button>
								                            <button id="sideDeptCancel" class="cancelBtn">취소</button>
								                        </div>
								                    </footer>
								                </div>
								            </span>
								        </div>
								    </c:if>
								</ul>
							</li>
						</ul>
					</div>
					<div class="addressListGroup compCalendar">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggleTit active">회사 캘린더</h3>
								<ul class="subList calendarList active">
									<!-- 전사 일정 -->
									<c:forEach var="cl" items="${clist}">
					            		<li>
					                		<input type="checkbox" id="calendar_${cl.calendar_seq}" name="calendar_${cl.calendar_seq}"
					                		<c:if test="${cl.default_yn == 'Y'}">checked</c:if>>
					                		<label for="calendar_${cl.calendar_seq}">${cl.calendar_name}</label>
					            		</li>
					        		</c:forEach>
					        		<!-- 임원 일정 -->
					        		<c:forEach var="el" items="${elist}">
					            		<li>
					                		<input type="checkbox" id="calendar_${el.calendar_seq}" name="calendar_${el.calendar_seq}"
					                		<c:if test="${el.default_yn == 'Y'}">checked</c:if>>
					                		<label for="calendar_${el.calendar_seq}">${el.calendar_name}</label>
					            		</li>
					        		</c:forEach>
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
    	<div class="modalContent calendarCont">
        <h1>
            일정등록<span class="modalClose">&times;</span>
        </h1>
        <div class="calendarAdd">
            <form id="eventForm" action="/events/save_event" method="post">
                <ul>
                    <li><span>일정명</span>
                        <div>
                            <input type="text" name="title">
                        </div>
                    </li>
                    <li><span>일정기간</span>
                        <div>
                            <input type="date" class="startDate dateInput" id="startDate" name="startDate">
                            <input type="time" class="startDate dateInput" id="startTime" name="startTime"> ~ 
                            <input type="date" class="endDate dateInput" id="endDate" name="endDate"> 
                            <input type="time" class="endDate dateInput" id="endTime" name="endTime">
                        </div>
                    </li>
                    <li><span>내 캘린더</span>
                        <div>
                            <select name="calendar_seq" id="choiCalendar">
                                <!-- role_code가 'R2'인 경우 -->
                                <c:if test="${employee.role_code eq 'R2'}">
                                    <c:forEach items="${plist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}(개인)</option>
                                    </c:forEach>
                                    <c:forEach items="${dlist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}(부서)</option>
                                    </c:forEach>
                                </c:if>
                                <!-- role_code가 'R1'인 경우 -->
                                <c:if test="${employee.role_code eq 'R1'}">
                                    <c:forEach items="${plist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
                                    </c:forEach>
                                    <c:forEach items="${clist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
                                    </c:forEach>
                                    <c:forEach items="${elist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
                                    </c:forEach>
                                </c:if>
                                <!-- role_code가 'R1, R2'가 아닌 경우 -->
                                <c:if test="${employee.role_code ne 'R2' and employee.role_code ne 'R1'}">
                                    <c:forEach items="${plist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>
                    </li>
                    <li><span>장소</span>
                        <div>
                            <input type="text" class="eventLocation" name="location">
                        </div>
                    </li>
                    <li><span>내용</span>
                        <div>
                            <textarea id="calendarText" name="content"></textarea>
                        </div>
                    </li>
                    <li>
                        <div class="btns">
                            <button type="submit" id="addBtn" class="okBtn">완료</button>
                            <button type="button" class="cancelBtn">취소</button>
                        </div>
                    </li>
                </ul>
                <input type="hidden" name="start_at" id="start_at"> 
                <input type="hidden" name="end_at" id="end_at">
            </form>
        </div>
    </div>
</div>
		<!-- 개인 캘린더 event 클릭 시 모달 -->
		<%@ include file="/WEB-INF/views/Calendar/Modal.jsp"%>
		<!-- 전사 일정 event 클릭 시 모달 -->
		<%@ include file="/WEB-INF/views/Calendar/companyModal.jsp"%>
		<!-- 임원 일정 event 클릭 시 모달 -->
		<%@ include file="/WEB-INF/views/Calendar/executiveModal.jsp"%>
	</div>

	<!-- 부서 캘린더 event 클릭 시 모달 -->
	<div id="deptEventModal" class="modal">
		<div class="modalContent calendarCont">
			<h1>
				일정 내용<span class="modalClose" id="eventModalClose">&times;</span>
			</h1>
			<div class="eventCheck">
				<form id="deptEventEditForm" action="/events/editEvent"
					method="post">
					<input type="hidden" name="events_seq" class="eventSeq">
					<ul>
						<li><span>일정명</span>
							<div>
								<input type="text" class="eventName" id="deptEventName" name="title" disabled>
							</div></li>
						<li><span>일정기간</span>
							<div>
								<input type="date" id="deptEventStartDate"
									class="eventStartDate startDate dateInput" name="editStartDate"
									disabled> <input type="time" id="deptEventStartTime"
									class="eventStartTime startDate dateInput" name="editStartTime"
									disabled> ~ <input type="date" id="deptEventEndDate"
									class="eventEndDate endDate dateInput" name="editEndDate"
									disabled> <input type="time" id="deptEventEndTime"
									class="eventEndTime endDate dateInput" name="editEndTime"
									disabled>
							</div></li>
						<li><span>부서 캘린더</span>
							<div>
								<select class="choiEvent" name="calendar_seq" disabled>
									<!-- role_code가 'R2'인 경우 -->
									<c:if test="${employee.role_code eq 'R2'}">
										<c:forEach items="${plist}" var="dto">
											<option value="${dto.calendar_seq}">${dto.calendar_name}(개인)</option>
										</c:forEach>
										<c:forEach items="${dlist}" var="dto">
											<option value="${dto.calendar_seq}">${dto.calendar_name}(부서)</option>
										</c:forEach>
									</c:if>
									<!-- role_code가 'R2'가 아닌 경우 -->
									<c:if test="${employee.role_code ne 'R2'}">
										<c:forEach items="${dlist}" var="dto">
											<option value="${dto.calendar_seq}">${dto.calendar_name}</option>
										</c:forEach>
									</c:if>
								</select>
							</div></li>
						<li><span>장소</span>
							<div>
								<input type="text" class="eventLocation" id="deptEventLocation" name="location"
									disabled>
							</div></li>
						<li><span>내용</span>
							<div>
								<textarea class="eventText" id="deptEventText" name="content" disabled></textarea>
							</div></li>
						<li><c:choose>
								<c:when test="${employee.role_code eq 'R2'}">
									<div class="btns">
										<button type="button" id="deptEditBtn">수정</button>
										<button type="submit" id="deptConfirmBtn" class="confirmBtn">확인</button>
										<button type="button" class="deleteBtn" id="eventDel">삭제</button>
										<button type="button" class="cancelBtn editCancelBtn">취소</button>
									</div>
								</c:when>
								<c:otherwise>
									<div class="btns"></div>
								</c:otherwise>
							</c:choose></li>
					</ul>
					<input type="hidden" name="editStartAt" class="editStartAt" id="deptEditStartAt">
					<input type="hidden" name="editEndAt" class="editEndAt" id="deptEditEndAt">
				</form>
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
        
        
        // input date 오늘 이전 날짜 선택 불가
     	// 현재 날짜를 가져오기
        const today = new Date();
        
        // 오늘 날짜
        today.setDate(today.getDate());

        // 내일 날짜를 YYYY-MM-DD 형식으로 변환
        const formattedTomorrow = today.toISOString().split('T')[0];

        // startDate와 endDate 입력 필드의 min 속성을 설정
        document.getElementById('startDate').setAttribute('min', formattedTomorrow);
        document.getElementById('endDate').setAttribute('min', formattedTomorrow);
        document.getElementById('perEventStartDate').setAttribute('min', formattedTomorrow);
        document.getElementById('perEventEndDate').setAttribute('min', formattedTomorrow);
        document.getElementById('deptEventStartDate').setAttribute('min', formattedTomorrow);
        document.getElementById('deptEventEndDate').setAttribute('min', formattedTomorrow);
        document.getElementById('compEventStartDate').setAttribute('min', formattedTomorrow);
        document.getElementById('compEventEndDate').setAttribute('min', formattedTomorrow);
        document.getElementById('execEventStartDate').setAttribute('min', formattedTomorrow);
        document.getElementById('execEventEndDate').setAttribute('min', formattedTomorrow);
		
    
        // 내 캘린더 추가 버튼
        $('.myCalendarAdd').on('click', function (e) {
        	// 클릭 이벤트 전파 중지
        	e.stopPropagation();
            $('.myCalendarPopup').show();
        })
        
        // 내 캘린더 추가 팝업에서 확인 버튼
        $('#sideMyAdd').on('click', function(){
        	let calendar_name = $('#calendar_name').val().trim();
        	if(calendar_name !== ""){
        		console.log(calendar_name);
        		// 내 캘린더 추가
        		$("#perCalendarForm").submit();
        		
        	}else{
        		alert("캘린더 이름을 입력해주세요.");
        	}        	
        });
        
     	// 팝업 외부 클릭 시 팝업 닫기
        $(document).on('click', function(e){
        	if(!$(e.target).closest('.myCalendarPopup, myCalendarAdd').length){
        		// 팝업 닫기
        		$('.myCalendarPopup').hide();
        	}
        });
		
        // 내 캘린더 팝업 x 버튼
        $('.myPopupClose').on('click', function () {
            $('.myCalendarPopup').hide();
        })
	
		// 개인 캘린더 x 버튼
		$(document).on('click', '.sidePerSelectDel', function(){
		    let calendarSeq = $(this).data('seq');
		    let deleteConfirm = confirm('정말로 이 캘린더를 삭제하시겠습니까?');
		    
		    if (deleteConfirm) {
		        $.ajax({
		            url: '/calendar/deletePerCalendar',
		            type: "POST",
		            data: { calendarSeq: calendarSeq },
		            success: function(response) {
		                if (response.success) {
		                    alert('캘린더가 성공적으로 삭제되었습니다.');
		                 // 삭제 후 페이지를 다시 로드하여 최신 상태 반영
		                    location.reload(); 
		                } else {
		                    alert('삭제 실패');
		                }
		            },
		            error: function() {
		                alert('삭제 요청 중 오류 발생');
		            }
		        });
		    }
		});
	
        // 부서 캘린더 추가 버튼
        $('.deptCalendarAdd').on('click', function (e) {
        		// 클릭 이벤트 전파 중지
        		e.stopPropagation(); 
            $('.deptCalendarPopup').show();
        })
        
        $('#sideDeptAdd').on('click', function(){
        	let calendar_name = $('#depCalendarName').val().trim();
        	let dept_code = $("input[name='dept_code']").val();
        	console.log("Dept Code: ", dept_code); 
        	if(calendar_name !== ""){
        		console.log(calendar_name)
        		console.log("Dept Code: ", dept_code); 
        		$("#deptCalendarForm").submit();      		
        	}else{
        		alert("캘린더 이름을 입력해주세요.");
        	}
        });
        
        $(document).on('click', function(e){
        	if(!$(e.target).closest('.deptCalendarPopup, deptCalendarAdd').length){
        		// 팝업 닫기
        		$('.deptCalendarPopup').hide();
        	}
        }) 
        
     	// 부서 캘린더 팝업 x 버튼
        $('.deptPopupClose').on('click', function () {
            $('.deptCalendarPopup').hide();
        })
		        
        // 부서 캘린더 x 버튼
        $(document).on('click', '.sideDepSelectDel', function(){
    let calendarSeq = $(this).data('seq');
    let deleteConfirm = confirm('정말로 이 캘린더를 삭제하시겠습니까?');
    
    if (deleteConfirm) {
        $.ajax({
            url: '/calendar/deleteDepCalendar',
            type: "POST",
            data: { calendarSeq: calendarSeq },
            success: function(response) {
                if (response.success) {
                    alert('캘린더가 성공적으로 삭제되었습니다.');
                 // 삭제 후 페이지를 다시 로드하여 최신 상태 반영
                    location.reload(); 
                } else {
                    alert('삭제 실패');
                }
            },
            error: function() {
                alert('삭제 요청 중 오류 발생');
            }
        });
    }
});
        // 개인 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#editBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            
         // 수정 모드에서 선택된 값 확인
         // 현재 선택된 값
            let selectedCalendar = $('.choiEvent option:selected').val();
            
            $('#editBtn').hide();
            $('.deleteBtn').hide();
            $('#perConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#perConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        e.preventDefault(); // 기본 폼 제출을 방지

            // 각 입력 값 가져오기
            let eventName = $('#perEventName').val() ? $('#perEventName').val().trim() : '';
            let startDate = $('#perEventStartDate').val() ? $('#perEventStartDate').val().trim() : '';
            let startTime = $('#perEventStartTime').val() ? $('#perEventStartTime').val().trim() : '';
            let endDate = $('#perEventEndDate').val() ? $('#perEventEndDate').val().trim() : '';
            let endTime = $('#perEventEndTime').val() ? $('#perEventEndTime').val().trim() : '';
            let selectedCalendar = $('.choiEvent option:selected').val() ? $('.choiEvent option:selected').val().trim() : '';  // 변경된 값 그대로 사용
            let location = $('#perEventLocation').val() ? $('#perEventLocation').val().trim() : '';
            let content = $('#perEventText').val() ? $('#perEventText').val().trim() : '';

            // 모든 필드 비어있는지 체크
            if (!eventName || !startDate || !startTime || !endDate || !endTime || !selectedCalendar || !location || !content) {
                alert('모든 필드를 입력해 주세요.'); // alert을 띄움
                console.log("폼 제출 중단: 빈 필드가 있습니다."); // 디버깅용 로그
                return; // 빈 필드가 있을 경우 폼 제출 중단
            }

            // 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let startDateTimeLocal = startDate + 'T' + startTime;
            let startDateTime = new Date(startDateTimeLocal);
            let startTimestamp = startDateTime.getTime(); 
            

            let endDateTimeLocal = endDate + 'T' + endTime;
            let endDateTime = new Date(endDateTimeLocal);
            let endTimestamp = endDateTime.getTime();
            
         // 종료일이 시작일보다 빠를 수 없도록 검증
            if (startTimestamp > endTimestamp) {
                alert('종료일은 시작일보다 빠를 수 없습니다. 기간을 다시 입력해주세요.');
                return;
            }
            
            $("#perEditStartAt").val(startTimestamp);
            $("#perEditEndAt").val(endTimestamp);
         // 폼을 제출하여 서버로 데이터를 전송
        $('#eventEditForm').submit(); 
    });
        
        
        
     // 부서 이벤트 수정 버튼 클릭 시
        $('#deptEditBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false); // 모든 입력 필드의 disabled 속성을 false로 설정

            // 수정 모드에서 선택된 값 확인
            let selectedCalendar = $('.choiEvent option:selected').val(); // 현재 선택된 값
            console.log("수정 모드에서 선택된 캘린더:", selectedCalendar); // 디버깅을 위한 로그

            $('#deptEditBtn').hide(); // 수정 버튼 숨김
            $('.deleteBtn').hide(); // 삭제 버튼 숨김
            $('#deptConfirmBtn').show(); // 확인 버튼 보임
            $('.cancelBtn').show(); // 취소 버튼 보임
        });

     // 확인 버튼 클릭 시
        $('#deptConfirmBtn').on('click', function (e) {
            e.preventDefault(); // 기본 폼 제출을 방지

            // 각 입력 값 가져오기
            let eventName = $('#deptEventName').val() ? $('#deptEventName').val().trim() : '';
            let startDate = $('#deptEventStartDate').val() ? $('#deptEventStartDate').val().trim() : '';
            let startTime = $('#deptEventStartTime').val() ? $('#deptEventStartTime').val().trim() : '';
            let endDate = $('#deptEventEndDate').val() ? $('#deptEventEndDate').val().trim() : '';
            let endTime = $('#deptEventEndTime').val() ? $('#deptEventEndTime').val().trim() : '';
            let selectedCalendar = $('.choiEvent option:selected').val() ? $('.choiEvent option:selected').val().trim() : '';  // 변경된 값 그대로 사용
            let location = $('#deptEventLocation').val() ? $('#deptEventLocation').val().trim() : '';
            let content = $('#deptEventText').val() ? $('#deptEventText').val().trim() : '';

            // 모든 필드 비어있는지 체크
            if (!eventName || !startDate || !startTime || !endDate || !endTime || !selectedCalendar || !location || !content) {
                alert('모든 필드를 입력해 주세요.'); // alert을 띄움
                console.log("폼 제출 중단: 빈 필드가 있습니다."); // 디버깅용 로그
                return; // 빈 필드가 있을 경우 폼 제출 중단
            }

         // 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let startDateTimeLocal = startDate + 'T' + startTime;
            let startDateTime = new Date(startDateTimeLocal);
            let startTimestamp = startDateTime.getTime(); 
            

            let endDateTimeLocal = endDate + 'T' + endTime;
            let endDateTime = new Date(endDateTimeLocal);
            let endTimestamp = endDateTime.getTime();
            
         // 종료일이 시작일보다 빠를 수 없도록 검증
            if (startTimestamp > endTimestamp) {
                alert('종료일은 시작일보다 빠를 수 없습니다. 기간을 다시 입력해주세요.');
                return;
            }
            
            $("#deptEditStartAt").val(startTimestamp);
            $("#deptEditEndAt").val(endTimestamp);
            
            // 폼을 제출하여 서버로 데이터를 전송
            $('#deptEventEditForm').submit(); 
        });
        
        // 전사 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#companyEditBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            
         // 수정 모드에서 선택된 값 확인
            let selectedCalendar = $('.choiEvent option:selected').val(); // 현재 선택된 값
            console.log("수정 모드에서 선택된 캘린더:", selectedCalendar); // 디버깅을 위한 로그
            
            $('#companyEditBtn').hide();
            $('.deleteBtn').hide();
            $('#companyConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#companyConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        e.preventDefault(); // 기본 폼 제출을 방지

            // 각 입력 값 가져오기
            let eventName = $('#compEventName').val() ? $('#compEventName').val().trim() : '';
            let startDate = $('#compEventStartDate').val() ? $('#compEventStartDate').val().trim() : '';
            let startTime = $('#compEventStartTime').val() ? $('#compEventStartTime').val().trim() : '';
            let endDate = $('#compEventEndDate').val() ? $('#compEventEndDate').val().trim() : '';
            let endTime = $('#compEventEndTime').val() ? $('#compEventEndTime').val().trim() : '';
            let selectedCalendar = $('.choiEvent option:selected').val() ? $('.choiEvent option:selected').val().trim() : '';  // 변경된 값 그대로 사용
            let location = $('#compEventLocation').val() ? $('#compEventLocation').val().trim() : '';
            let content = $('#compEventText').val() ? $('#compEventText').val().trim() : '';

            // 모든 필드 비어있는지 체크
            if (!eventName || !startDate || !startTime || !endDate || !endTime || !selectedCalendar || !location || !content) {
                alert('모든 필드를 입력해 주세요.'); // alert을 띄움
                console.log("폼 제출 중단: 빈 필드가 있습니다."); // 디버깅용 로그
                return; // 빈 필드가 있을 경우 폼 제출 중단
            }

         // 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let startDateTimeLocal = startDate + 'T' + startTime;
            let startDateTime = new Date(startDateTimeLocal);
            let startTimestamp = startDateTime.getTime(); 
            

            let endDateTimeLocal = endDate + 'T' + endTime;
            let endDateTime = new Date(endDateTimeLocal);
            let endTimestamp = endDateTime.getTime();
            
         // 종료일이 시작일보다 빠를 수 없도록 검증
            if (startTimestamp > endTimestamp) {
                alert('종료일은 시작일보다 빠를 수 없습니다. 기간을 다시 입력해주세요.');
                return;
            }
            
            $("#compEditStartAt").val(startTimestamp);
            $("#compEditEndAt").val(endTimestamp);

         // 폼을 제출하여 서버로 데이터를 전송
        $('#companyEventEditForm').submit();
    });
        
     // 임원 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#executiveEditBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            
         // 수정 모드에서 선택된 값 확인
            let selectedCalendar = $('.choiEvent option:selected').val(); // 현재 선택된 값
            console.log("수정 모드에서 선택된 캘린더:", selectedCalendar); // 디버깅을 위한 로그
            
            $('#executiveEditBtn').hide();
            $('.deleteBtn').hide();
            $('#executiveConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#executiveConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        e.preventDefault();
        
        // 각 입력 값 가져오기
            let eventName = $('#execEventName').val() ? $('#execEventName').val().trim() : '';
            let startDate = $('#execEventStartDate').val() ? $('#execEventStartDate').val().trim() : '';
            let startTime = $('#execEventStartTime').val() ? $('#execEventStartTime').val().trim() : '';
            let endDate = $('#execEventEndDate').val() ? $('#execEventEndDate').val().trim() : '';
            let endTime = $('#execEventEndTime').val() ? $('#execEventEndTime').val().trim() : '';
            let selectedCalendar = $('.choiEvent option:selected').val() ? $('.choiEvent option:selected').val().trim() : '';  // 변경된 값 그대로 사용
            let location = $('#execEventLocation').val() ? $('#execEventLocation').val().trim() : '';
            let content = $('#execEventText').val() ? $('#execEventText').val().trim() : '';

            // 모든 필드 비어있는지 체크
            if (!eventName || !startDate || !startTime || !endDate || !endTime || !selectedCalendar || !location || !content) {
                alert('모든 필드를 입력해 주세요.'); // alert을 띄움
                console.log("폼 제출 중단: 빈 필드가 있습니다."); // 디버깅용 로그
                return; // 빈 필드가 있을 경우 폼 제출 중단
            }

         // 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let startDateTimeLocal = startDate + 'T' + startTime;
            let startDateTime = new Date(startDateTimeLocal);
            let startTimestamp = startDateTime.getTime(); 
            

            let endDateTimeLocal = endDate + 'T' + endTime;
            let endDateTime = new Date(endDateTimeLocal);
            let endTimestamp = endDateTime.getTime();
            
         // 종료일이 시작일보다 빠를 수 없도록 검증
            if (startTimestamp > endTimestamp) {
                alert('종료일은 시작일보다 빠를 수 없습니다. 기간을 다시 입력해주세요.');
                return;
            }
            
            $("#execEditStartAt").val(startTimestamp);
            $("#execEditEndAt").val(endTimestamp);
            
         // 폼을 제출하여 서버로 데이터를 전송
        $('#executiveEventEditForm').submit(); 
    });

        $('.cancelBtn').on('click', function () {
            location.reload();
        })
        
        // 이벤트 모달창에서 삭제 버튼 눌렀을 시
        $('.deleteBtn').on('click', function (){
            
            let eventDeleteConfirm = confirm('정말로 이 캘린더를 삭제하시겠습니까?');
            
            if (eventDeleteConfirm) {
                // 사용자가 확인을 클릭한 경우 삭제 요청을 서버로 전송
            	let eventSeq = $('.eventSeq').val();
            	console.log(eventSeq);
            	location.href = "/events/del_event?eventSeq=" + eventSeq;
            }        	
        })

        $('.plusBtn.sideBtn').on('click', function () {
            $("#calendarModal").show();
            $(".modalClose").on("click", function () {
                $("#calendarModal").hide();
            })
        })


    // 실제 구현에 따라 이벤트 리스너를 추가할 수 있음.
    $('#sideMyAdd').on('click', function() {
    	// 새로운 캘린더를 추가한 후 셀렉트 옵션 업데이트
        updateSelectOptions('.choiEvent');
        updateSelectOptions('#choiCalendar');
    });

        // 캘린더 기능 시작
        document.addEventListener('DOMContentLoaded', function () {
        	
        	let calendarType = "";
        	
        	function getCheckedCalendars() {
                let checkedCalendars = [];
                $('input[type="checkbox"]:checked').each(function() {
                    checkedCalendars.push($(this).attr('id').split('_')[1]);
                });
                return checkedCalendars;
            }

            function reloadCalendarEvents() {
                // Ensure that the events are refetched only when needed
                calendar.refetchEvents();
            }

            // 체크 상태 초기화
            let checkedCalendars = getCheckedCalendars();

            // 체크 박스 상태 변화되었을 시
            $('input[type="checkbox"]').change(function() {
                checkedCalendars = getCheckedCalendars();
                reloadCalendarEvents();
            });

            console.log("Collected:", checkedCalendars);

        	
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
                // 드래그로 일정 옮길수 없음
                editable: false,
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
                    let checkedCalendars = getCheckedCalendars();
                    $.ajax({
                        // 서버의 이벤트 데이터 엔드포인트
                        url: '/events/all_event', 
                        method: 'GET',
                        dataType: 'json',
                        data: {
                            // 체크된 캘린더 ID 목록을 서버로 전송
                            // 문자열로 변환하여 전달
                            calendars: checkedCalendars
                        }, 
                        success: function (data) {
                            console.log(data); // 서버로부터 받은 이벤트 데이터를 풀캘린더에 전달
                            
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
                            
                            successCallback(data.map(event => {
                                let color = '#3788D8'; // 기본 색상 설정

                                // 전사 일정
                                if (event.calendar_seq === 6) {
                                    color = 'red'; 
                                }
                                // 임원 일정
                                else if(event.calendar_seq === 7){
                                	color = 'green';
                                }

                                return {
                                    title: event.title,
                                    start: formatDate(event.start_date), // 변환된 시작 날짜
                                    end: formatDate(event.end_date), // 변환된 종료 날짜
                                    color: color, // 색상 속성 추가
                                    extendedProps: {
                                        events_seq: event.events_seq,
                                        calendar_seq: event.calendar_seq,
                                        location: event.location,
                                        content: event.content
                                    }
                                };
                            }));
                        },
                        error: function () {
                            alert('이벤트를 불러오는데 실패했습니다.');
                            failureCallback();
                        }
                    });
                },
                dateClick: function (info) {
                	// 클릭한 날짜 (Date 객체)
                   	const selectedDate = new Date(info.dateStr);
            		// 오늘 날짜 (Date 객체)
            		const today = new Date(); 
            		// 오늘 날짜의 시간 부분을 00:00:00으로 설정
            		today.setHours(0, 0, 0, 0); 
        	
        			// 현재 캘린더에 있는 모든 이벤트
            		const events = calendar.getEvents(); 

            		// 선택한 날짜가 오늘 이후인지 확인
            		if (selectedDate <= today) {
                		alert('일정은 오늘 이후 날짜에만 생성할 수 있습니다.');
                		return;
            		}

                    // 날짜 클릭 시 발생할 이벤트
                    $('.startDate').val(info.dateStr);
                    $("#calendarModal").show();
                    $(".modalClose").on("click", function () {
                        $("#calendarModal").hide();
                    });
                },
                eventClick: function (info) {
                	console.log(info);
                	
                    // 이벤트 클릭 시 발생할 이벤트
                    let eventTitle = info.event.title;
                    let eventSeq = info.event.extendedProps.events_seq;
                    let eventChoice = info.event.extendedProps.calendar_seq;
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
                    $('.eventSeq').val(eventSeq);
                    $('.eventStartDate').val(eventStartDate);
                    $('.eventStartTime').val(eventStartTime);
                    $('.eventEndDate').val(eventEndDate);
                    $('.eventEndTime').val(eventEndTime);
                    $('.choiEvent').val(eventChoice);
                    $('.eventLocation').val(eventLocation);
                    $('.eventText').val(eventContent);
                     
                    console.log(eventChoice);
                    $.ajax({
        	            url: '/calendar/getCalendarType',
        	            data: { 
        	            	calendarSeq: eventChoice 
        	            },
        	            dataType: 'json'
        	        }).done((resp)=>{  	        	
        	        	if (resp.type == 'personal') {
        	                $("#personEventModal").show();
        	                $("#personEventModal .modalClose").off("click").on("click", function (event) {
        	                    event.preventDefault();
        	                    $("#personEventModal").find('input[type="text"], input[type="date"], input[type="time"], textarea').val('');
        	                 	// 장소 필드만 초기화
        	                    $(".eventLocation").val('');
        	                    $("#personEventModal").hide();
        	                });

        	            } else if(resp.type == 'dept'){
        	                $("#deptEventModal").show();
        	                $("#deptEventModal .modalClose").off("click").on("click", function (event) {
        	                    event.preventDefault();
        	                    $("#deptEventModal").find('input[type="text"], input[type="date"], input[type="time"], textarea').val('');
        	                    // 장소 필드 초기화
        	                    $(".eventLocation").val('');
        	                    $("#deptEventModal").hide();
        	                });
        	            } else if(resp.type == 'company'){
        	            		$("#companyEventModal").show();
            	                $("#companyEventModal .modalClose").off("click").on("click", function (event) {
            	                    event.preventDefault();
            	                    $("#companyEventModal").find('input[type="text"], input[type="date"], input[type="time"], textarea').val('');
            	                    // 장소 필드 초기화
            	                    $(".eventLocation").val('');
            	                    $("#companyEventModal").hide();
        	            	});
        	            }else{
        	            	$("#executiveEventModal").show();
        	            	$("#executiveEventModal .modalClose").off("click").on("click", function (event) {
        	            		event.preventDefault();
        	            		$("#executiveEventModal").find('input[type="text"], input[type="date"], input[type="time"], textarea').val('');
        	            		$(".eventLocation").val('');
        	            		$("#executiveEventModal").hide();      	            	
        	            });
        	            }
        	        }).fail((jqXHR, textStatus, errorThrown) => {
        	            console.error('AJAX 요청 실패:', textStatus, errorThrown);
        	        });                 
                }
            });
            
            calendar.render();
            // Add event listener to checkboxes
            $('input[type="checkbox"]').change(function () {
                reloadCalendarEvents();
            });
         
        });

        document.getElementById('eventForm').addEventListener('submit', function (event) {
            // 기본 폼 제출 동작을 막음
            event.preventDefault();
            console.log("폼태그 동작 확인");

            // 필수 입력 필드들을 확인
            let title = $("input[name='title']").val().trim();
            let startDate = $("#startDate").val().trim();
            let startTime = $("#startTime").val().trim();
            let endDate = $("#endDate").val().trim();
            let endTime = $("#endTime").val().trim();
            let calendarSeq = $("#choiCalendar").val().trim();
            let location = $("input[name='location']").val().trim();
            let content = $("textarea[name='content']").val().trim();

            // 필수 입력 필드가 비어 있는지 확인
            if (!title || !startDate || !startTime || !endDate || !endTime || !calendarSeq || !location || !content) {
                alert("모든 필드를 입력해주세요.");
                return;
            }

            // 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열
            let startDateTimeLocal = startDate + 'T' + startTime;
            let startDateTime = new Date(startDateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            let startTimestamp = startDateTime.getTime();  

            let endDateTimeLocal = endDate + 'T' + endTime;
            let endDateTime = new Date(endDateTimeLocal);
            // 밀리초 단위의 타임스탬프
            let endTimestamp = endDateTime.getTime(); 

            // 종료일이 시작일보다 빠를 수 없도록 검증
            if (startTimestamp > endTimestamp) {
                alert('종료일은 시작일보다 빠를 수 없습니다. 기간을 다시 입력해주세요.');
                return;
            }

            // 타임스탬프를 hidden input에 설정
            $("#start_at").val(startTimestamp);
            $("#end_at").val(endTimestamp);

            // 모든 검증을 통과한 후 폼 제출
            event.target.submit();
        });
        
     	// 모달 외부 클릭 시 닫기
        $(window).click(function(e) {
        	if ($(e.target).is($('#calendarModal')[0])) {
        		location.reload();
        	}
        	if ($(e.target).is($('#deptEventModal')[0])) {
        		$('#deptEventModal').hide();
        	}
        	if ($(e.target).is($('#personEventModal')[0])) {
        		$('#personEventModal').hide();
        	}
        	if ($(e.target).is($('#executiveEventModal')[0])) {
        		$('#executiveEventModal').hide();
        	}
        	if ($(e.target).is($('#companyEventModal')[0])) {
        		$('#companyEventModal').hide();
        	}
        });      
    </script>
</body>
</html>
