// 모달창 닫으면 페이지 새로고침
$('.modalClose, #cancelReservBtn').on('click', function () {
	location.reload();
});

// 예약 목적 입력 시 입력 문자열 길이를 제어
$('#purpose').on('input', function() {
	const maxLength = 200;
    const currentLength = $(this).val().length;

    if (currentLength > maxLength) {
        alert("예약 목적은 최대 200자까지만 입력 가능합니다.");
        $(this).val($(this).val().substr(0, maxLength));
    }
});

// 예약 모달창에서 시작 시간 입력 시 유효성 검사
$('#startTime').on('change', function() {
	if($(this).val() < '10:00') {
		alert('오전 10시 이전 시간은 예약이 불가능합니다.');
		$(this).val('10:00');
		return;
	}
	if($(this).val() > '17:00') {
		alert('오후 5시 이후 시간은 예약이 불가능합니다.');
		$(this).val('10:00');
		return;
	}

	// 시작 시간이 존재한다면 종료 시간을 시작 시간에서 1시간 지난 시간으로 세팅
    if ($(this).val()) {
   		setEndTime();
    }
});

// 예약 모달창에서 종료 시간 입력 시 유효성 검사
$('#endTime').on('change', function() {
	if($(this).val() < '10:00') {
		alert('오전 10시 이전 시간은 예약이 불가능합니다.');
		// 종료 시간 재설정
    	if ($('#startTime').val()) {
   			setEndTime();
    	} else {
    		$(this).val('11:00');
    	}
		return;
	}
	if($(this).val() > '17:00') {
		alert('오후 5시 이후 시간은 예약이 불가능합니다.');
		// 종료 시간 재설정
    	if ($('#startTime').val()) {
   			setEndTime();
    	} else {
    		$(this).val('11:00');
    	}
		return;
	}
	if($(this).val() < $('#startTime').val()){
		alert('예약 시간을 다시 확인해주세요.');
		// 종료 시간 재설정
    	if ($('#startTime').val()) {
   			setEndTime();
    	} else {
    		$(this).val('11:00');
    	}
    	return;
	}
});

// 예약 종료 시간을 시작 시간에서 1시간 지난 시간으로 자동 설정하는 메서드
function setEndTime() {
	const [hours, minutes] = $('#startTime').val().split(':');
    const date = new Date();
    date.setHours(parseInt(hours) + 1);
    date.setMinutes(parseInt(minutes));

    const endTime = date.toTimeString().slice(0, 5);
    $('#endTime').val(endTime);
}

// 예약을 완료하려는 경우 Form 태그 제출 전 유효성 검사 
$('#addMeetingReserv').on('click', function () {

	if($('#startTime').val() == '' || $('#endTime').val() == ''){
		alert('예약 시간을 다시 확인 해주세요');
		return;
	}
	
	if($('#purpose').val().trim() == ''){
		alert('예약 목적을 입력해주세요');
		return;
	}

	// 날짜와 시간 값을 가져오기
    const date = $('#bookingDate').val();
    const startTime = $('#startTime').val();
	const endTime = $('#endTime').val();

    // Date 객체 생성 
    const startDateTimeString = date + 'T' + startTime;
    const endDateTimeString = date + 'T' + endTime;
    const startDateTime = new Date(startDateTimeString);
	const endDateTime = new Date(endDateTimeString);
	
	const pathName = window.location.pathname;
	
	if(confirm('예약 내용은 수정&삭제가 불가능합니다.')){
		// 입력한 날짜에 다른 예약이 존재하는지 검사
		$.ajax({
    		url: '/reservation/meetingRoom/addEvent',
    		method: 'post', 
   			dataType: 'json', 
    		data: {
    			startDate: startDateTime.getTime(),
    			endDate: endDateTime.getTime(),
    			room_seq : $('#roomSeq').val(),
    			purpose: $('#purpose').val()
			}
    	}).done(resp => {
			// 서버에서 검사 후 등록 여부 알람
			if (resp.result == "등록 완료") {
				alert('예약이 완료되었습니다.');
				location.href = pathName + "?roomSeq=" + $('#roomSeq').val();
			} else if(resp.result == "불가능") {
				alert('예약 일정을 다시 확인해주세요.\n같은 장소를 동시에 사용하는 것은 불가능합니다.');
				$('#startTime').focus();
				return;
			} 
		}).fail((jqXHR, textStatus, errorThrown) => {
    		console.error('AJAX request failed:', textStatus, errorThrown);  // 오류 로그 출력
		});
	}
});

// 페이지의 모든 요소가 로드되었을 때 실행
$(document).ready(function() {

	const calendarEl = $('#calendar')[0];

    const calendar = new FullCalendar.Calendar(calendarEl, {
    	dayCellContent: function (e) {
        	return e.dayNumberText.replace('일', '');
        },
        locale: "ko",
        initialDate: new Date(),
        timeZone: 'Asia/Seoul',
        editable: false,
        selectable: true,
        businessHours: true,
        dayMaxEvents: true,
        buttonText: {
        	today: '오늘'
        },
        dateClick: function (info) {
        //날짜 클릭 시 발생할 이벤트
			
			// 현재 시간을 오늘 00:00으로 맞추기
			const today = new Date(); 
    		today.setHours(0, 0, 0, 0);

    		if (info.date < today) {
        		alert('예약이 이미 마감된 날짜 입니다.');
    		} else {
        		$('#bookingDate').val(info.dateStr);
        		$("#reservModal").show();
    		}
        },
        eventClick: function (info) {
        // 이벤트 클릭 시 발생할 이벤트
        	// console.log(info);
        
        	// 이벤트 정보 저장
            const eventTitle = info.event._def.title;
            const empName = info.event._def.extendedProps.empName;
            const roomName = info.event._def.extendedProps.roomName;
            const purpose = info.event._def.extendedProps.purpose;
            const location = info.event._def.extendedProps.location;
            
            $('#roomName').val(roomName);
            $('#dept').val(eventTitle);
            $('#empName').val(empName);
            $('#roomLocation').val(location);
            $('#bookingPurpose').val(purpose);
            
            let startStr = info.event.startStr;
            let endStr = info.event.endStr;
            
            // Date 객체로 변환
    		const start = new Date(startStr);
    		const end = new Date(endStr);

    		// 날짜와 시간을 각각 추출
    		const startDate = start.toISOString().slice(0, 10); // YYYY-MM-DD
    		const startTime = start.toISOString().slice(11, 16); // HH:MM
			const endDate = end.toISOString().slice(0, 10); // YYYY-MM-DD
    		const endTime = end.toISOString().slice(11, 16); // HH:MM
			
    		// input 태그에 값 설정
    		$('#eStartDate').val(startDate);
    		$('#eStartTime').val(startTime);
            $('#eEndDate').val(endDate);
            $('#eEndTime').val(endTime);

            $("#eventModal").show();
            $(".modalClose").on("click", function () {
            	$("#eventModal").hide();
            });
        },
        events: function(fetchInfo, successCallback, failureCallback) {
          // AJAX 요청으로 서버에서 이벤트 데이터를 가져오기
          $.ajax({
            url: '/reservation/allRoomBooking',  // 서버에서 이벤트 데이터를 제공하는 엔드포인트
            method: 'post',
            data: {
            	roomSeq: $('#roomSeq').val()
            },
            dataType: "json",
            success: function(data) {
            	// console.log(data)
            
              	// 서버에서 받은 데이터를 FullCalendar 형식으로 변환
              	const events = data.map(event => {
                
                // 서버에서 받은 날짜 문자열을 ISO 8601 형식으로 변환
                const startDateUTC = new Date(event.start_date + ' UTC');
                const endDateUTC = new Date(event.end_date + ' UTC');
                
                // 날짜 객체를 ISO 8601 문자열로 변환
                const start = startDateUTC.toISOString();
                const end = endDateUTC.toISOString();
				
				let color = '#3788D8';
				
				if(event.dept_title == '인사부'){
					color = '#81DAC6';
				} else if(event.dept_title == '영업부'){
					color = '#C8DD9F';
				}  else if(event.dept_title == 'IT부'){
					color = '#F5D48F';
				}  else if(event.dept_title == '마케팅부'){
					color = '#F28376';
				}  else if(event.dept_title == '기술지원부'){
					color = '#C4A4D1';
				}
				
                return {
                  	id: event.room_booking_seq,  
                  	title: event.dept_title,     
                  	start: start,                
                  	end: end,
                  	color: color,
                  	extendedProps: {
                  		empName: event.emp_name,
                  		roomName: event.room_name,
                  		purpose: event.purpose,
                  		location: event.location
                  	}                     
                };
            });
            successCallback(events);
        },
        error: function(err) {
            console.error('Error fetching events:', err);
            failureCallback(err);
        }
    });
    }
  });
  calendar.render();
});

