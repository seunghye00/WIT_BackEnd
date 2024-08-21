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
														<input type="text" name="calendar_name" id="calendar_name">
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
									<c:forEach items="${dlist}" var="dto">
										<li><input type="checkbox"
											id="calendar_${dto.calendar_seq}"
											name="calendar_${dto.calendar_seq}"
											class="<c:out value="${dto.default_yn == 'Y' ? 'active' : ''}" />"
											<c:if test="${dto.default_yn == 'Y'}">checked</c:if>>
											<label for="calendar_${dto.calendar_seq}">(${dto.dept_title}) ${dto.calendar_name}</label>
											<!-- 회의 일정(기본), 부서원 생일(기본)에는 삭제 버튼 없음 기본 생성자는 default='Y' -->
											<c:if
												test="${employee.role_code eq 'R2' and dto.default_yn ne 'Y'}">
												<span class="sideDepSelectDel"
													data-seq="${dto.calendar_seq}" id="sideDepSelectDel">&times;</span>
											</c:if> <input type="hidden" id="${dto.calendar_seq}"
											value="${dto.calendar_seq}"></li>
									</c:forEach>
									<c:if test="${employee.role_code eq 'R2'}">
										<div>
											<span class="sideCalendarAdd"><i
												class='bx bx-plus-medical'></i> <span
												class="deptCalendarAdd">부서 캘린더 추가</span>
												<div class="deptCalendarPopup">
													<header>
														<h3>
															부서 캘린더 추가<span class="deptPopupClose">&times;</span>
														</h3>
													</header>
													<div class="content">
														<form id="deptCalendarForm"
															action="/calendar/insertDepCalendar" method="post">
															<input type="text" name="calendar_name"
																id="depCalendarName"> <input type="hidden"
																name="dept_code" value="${employee.dept_code}">
															<input type="hidden" name="default_yn">
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
									</c:if>
								</ul>
							</li>
						</ul>
					</div>
					<div style="padding: 60px;"></div>					
					    <hr>					    
					    <ul class="company">
					        <!-- 전사 일정 -->
					        <c:forEach var="cl" items="${clist}">
					            <li>
					                <input type="checkbox" id="calendar_${cl.calendar_seq}" name="calendar_${cl.calendar_seq}">
					                <label for="calendar_${cl.calendar_seq}">${cl.calendar_name}</label>
					            </li>
					        </c:forEach>
					        <!-- 임원 일정 -->
					        <c:forEach var="el" items="${elist}">
					            <li>
					                <input type="checkbox" id="calendar_${el.calendar_seq}" name="calendar_${el.calendar_seq}">
					                <label for="calendar_${el.calendar_seq}">${el.calendar_name}</label>
					            </li>
					        </c:forEach>
					    </ul>
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
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
                                    </c:forEach>
                                    <c:forEach items="${dlist}" var="dto">
                                        <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
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
								<input type="text" class="eventName" name="title" disabled>
							</div></li>
						<li><span>일정기간</span>
							<div>
								<input type="date" id="eventStartDate"
									class="eventStartDate startDate dateInput" name="editStartDate"
									disabled> <input type="time" id="eventStartTime"
									class="eventStartTime startDate dateInput" name="editStartTime"
									disabled> ~ <input type="date" id="eventEndDate"
									class="eventEndDate endDate dateInput" name="editEndDate"
									disabled> <input type="time" id="eventEndTime"
									class="eventEndTime endDate dateInput" name="editEndTime"
									disabled>
							</div></li>
						<li><span>부서 캘린더</span>
							<div>
								<select class="choiEvent" name="calendar_seq" disabled>
									<!-- role_code가 'R2'인 경우 -->
									<c:if test="${employee.role_code eq 'R2'}">
										<c:forEach items="${plist}" var="dto">
											<option value="${dto.calendar_seq}">${dto.calendar_name}</option>
										</c:forEach>
										<c:forEach items="${dlist}" var="dto">
											<option value="${dto.calendar_seq}">${dto.calendar_name}</option>
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
								<input type="text" class="eventLocation" name="location"
									disabled>
							</div></li>
						<li><span>내용</span>
							<div>
								<textarea class="eventText" name="content" disabled></textarea>
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
					<input type="hidden" name="editStartAt" class="editStartAt">
					<input type="hidden" name="editEndAt" class="editEndAt">
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
        		$("#perCalendarForm").submit();
        		
        	}else{
        		alert("캘린더 이름을 입력해주세요.");
        	}        	
        });
		
        // 내 캘린더 팝업 x 버튼
        $('.myPopupClose').on('click', function () {
            $('.myCalendarPopup').hide();
        })
	
	//개인 캘린더 x 버튼
	$(document).on('click', '.sidePerSelectDel', function(){
		// 클릭된 버튼의 data-seq 속성 값을 가져오기
		let calendarSeq = $(this).data('seq');
		// 클릭된 버튼 자체를 저장
		let $this = $(this);
		
		let deleteConfirm = confirm('정말로 이 캘린더를 삭제하시겠습니까?');
		
		if(deleteConfirm){
			// 사용자가 확인을 클릭한 경우 삭제 요청을 서버로 전송
			$.ajax({
				url: '/calendar/deletePerCalendar',
				type:"POST",
				data: {calendarSeq: calendarSeq},
				sucess: function(response){
					if(response.success){
						$('#calendar').fullCalendar('refetchEvents');
						// 삭제가 성공했으면 해당 항목을 DOM에서 제거
						$this.closet('li').remove();
					}else{
						alert('삭제 실패');
					}
				},
				error: function(){
					alert('삭제 요청 중 오류 발생');
				}
			});
		}
	})
	
        // 부서 캘린더 추가 버튼
        $('.deptCalendarAdd').on('click', function () {
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
        
     	// 내 캘린더 팝업 x 버튼
        $('.deptPopupClose').on('click', function () {
            $('.deptCalendarPopup').hide();
        })
		
        // 부서 캘린더 x 버튼
        $(document).on('click', '.sideDepSelectDel', function() {
	    // 클릭된 버튼의 data-seq 속성 값을 가져오기
	    let calendarSeq = $(this).data('seq');
	    // 클릭된 버튼 자체를 저장
	    let $this = $(this);
	    
	    let deleteConfirm = confirm('정말로 이 캘린더를 삭제하시겠습니까?');
	    
	    if (deleteConfirm) {
	        // 사용자가 확인을 클릭한 경우 삭제 요청을 서버로 전송
	        $.ajax({
	            url: '/calendar/deleteDepCalendar',
	            type: 'POST',
	            data: { calendarSeq: calendarSeq },
	            success: function(response) {
	            	if(response.success){
						$('#calendar').fullCalendar('refetchEvents');
						// 삭제가 성공했으면 해당 항목을 DOM에서 제거
						$this.closet('li').remove();
					}else{
						alert('삭제 실패');
					}
				},
				error: function(){
					alert('삭제 요청 중 오류 발생');
				}
			});
		}
	})
        // 개인 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#editBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            $('#editBtn').hide();
            $('.deleteBtn').hide();
            $('#perConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#perConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        // 기본 폼 제출을 방지
        e.preventDefault(); 

        	let startDate = $('#eventStartDate').val();
        	let startTime = $('#eventStartTime').val();
        	let endDate = $('#eventEndDate').val();
        	let endTime = $('#eventEndTime').val();
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let dateTimeLocal = startDate + 'T' + startTime;
            let dateTime = new Date(dateTimeLocal);
        	// 밀리초 단위의 타임스탬프
            let timestamp = dateTime.getTime(); 
            
            $(".editStartAt").val(timestamp);
            
            dateTimeLocal = endDate + 'T' + endTime;
            dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            timestamp = dateTime.getTime(); 
            
            $(".editEndAt").val(timestamp);

         // 폼을 제출하여 서버로 데이터를 전송
        $('#eventEditForm').submit(); 
    });
        
     // 부서 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#deptEditBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            $('#deptEditBtn').hide();
            $('.deleteBtn').hide();
            $('#deptConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#deptConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        // 기본 폼 제출을 방지
        e.preventDefault(); 

        	let startDate = $('#eventStartDate').val();
        	let startTime = $('#eventStartTime').val();
        	let endDate = $('#eventEndDate').val();
        	let endTime = $('#eventEndTime').val();
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let dateTimeLocal = startDate + 'T' + startTime;
            let dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            let timestamp = dateTime.getTime(); 
            
            $(".editStartAt").val(timestamp);
            
            dateTimeLocal = endDate + 'T' + endTime;
            dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            timestamp = dateTime.getTime(); 
            
            $(".editEndAt").val(timestamp);

         // 폼을 제출하여 서버로 데이터를 전송
        $('#deptEventEditForm').submit(); 
    });
        
        // 전사 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#companyEditBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            $('#companyEditBtn').hide();
            $('.deleteBtn').hide();
            $('#companyConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#companyConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        // 기본 폼 제출을 방지
        e.preventDefault(); 

        	let startDate = $('#eventStartDate').val();
        	let startTime = $('#eventStartTime').val();
        	let endDate = $('#eventEndDate').val();
        	let endTime = $('#eventEndTime').val();
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let dateTimeLocal = startDate + 'T' + startTime;
            let dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            let timestamp = dateTime.getTime(); 
            
            $(".editStartAt").val(timestamp);
            
            dateTimeLocal = endDate + 'T' + endTime;
            dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            timestamp = dateTime.getTime(); 
            
            $(".editEndAt").val(timestamp);

         // 폼을 제출하여 서버로 데이터를 전송
        $('#companyEventEditForm').submit();
    });
        
     // 임원 이벤트 클릭해서 수정 버튼 눌렀을 시
        $('#executiveEditBtn').on('click', function () {
            let $inputs = $('.eventCheck input, .eventCheck select, .eventCheck textarea');
            $inputs.prop('disabled', false);
            $('#executiveEditBtn').hide();
            $('.deleteBtn').hide();
            $('#executiveConfirmBtn').show();
            $('.cancelBtn').show();
        });


        $('#executiveConfirmBtn').on('click', function (e) {
        // 확인 버튼 클릭 시
        // 기본 폼 제출을 방지
        e.preventDefault(); 

        	let startDate = $('#eventStartDate').val();
        	let startTime = $('#eventStartTime').val();
        	let endDate = $('#eventEndDate').val();
        	let endTime = $('#eventEndTime').val();
        	// 날짜와 시간을 결합하여 ISO 8601 형식의 타임스탬프 문자열을 만듬.
            let dateTimeLocal = startDate + 'T' + startTime;
            let dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            let timestamp = dateTime.getTime(); 
            
            $(".editStartAt").val(timestamp);
            
            dateTimeLocal = endDate + 'T' + endTime;
            dateTime = new Date(dateTimeLocal);
         	// 밀리초 단위의 타임스탬프
            timestamp = dateTime.getTime(); 
            
            $(".editEndAt").val(timestamp);

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
                	let checkedCalendars = getCheckedCalendars();
                    $.ajax({
                    	// 서버의 이벤트 데이터 엔드포인트
                        url: '/events/all_event', 
                        method: 'GET',
                        dataType: 'json',
                        data:{
                        	// 체크된 캘린더 ID 목록을 서버로 전송
                        	// 문자열로 변환하여 전달
                        	calendars: checkedCalendars
                        	
                        }, 
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
                             	// 변환된 시작 날짜
                                start: formatDate(event.start_date), 
                             	// 변환된 종료 날짜
                                end: formatDate(event.end_date),     
                                extendedProps: {
                                	events_seq : event.events_seq,
                                	calendar_seq: event.calendar_seq,
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
        
        
        
        
    </script>
</body>
</html>
