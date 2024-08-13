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
	
   	// 타임스탬프 변환 후 input 태그에 저장
   	$('#startDate').val(startDateTime.getTime());
	$('#endDate').val(endDateTime.getTime());

    $('#reservRoomForm').submit();
});

// 페이지의 모든 요소가 로드되었을 때 실행
$(document).ready(function() {
	// 현재 시간를 변수에 저장
	const today = new Date();

	const calendarEl = $('#calendar')[0];

    const calendar = new FullCalendar.Calendar(calendarEl, {
    	dayCellContent: function (e) {
        	return e.dayNumberText.replace('일', '');
        },
        locale: "ko",
        initialDate: today,
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

        	// 시간을 오늘 00:00으로 맞추기
          	today.setHours(0, 0, 0, 0);

			// 오늘 이전의 날짜 클릭 시 안내문 출력
          	if (info.date < today) {
            	alert('예약이 이미 마감된 날짜 입니다.');
          	} else {
          		// 해당 날짜 설정 후 모달창 활성화
            	$('#bookingDate').val(info.dateStr);
            	$("#reservModal").show();
         	}
        },
        eventClick: function (info) {
        	// 이벤트 클릭 시 발생할 이벤트
            let eventTitle = info.event._def.title;
            // 이벤트 시작 날짜를 ISO 형식으로 변환
            // 이벤트의 시작과 종료 시간을 한국 시간으로 변환
            let eventStartUTC = new Date(info.event.start);
            let eventEndUTC = info.event.end ? new Date(info.event.end) : new Date(eventStartUTC.getTime() + 24 * 60 * 60 * 1000);

            // 한국 표준시(KST)로 변환
            let eventStartKST = new Date(eventStartUTC.toLocaleString('en-US', { timeZone: 'Asia/Seoul' }));
            let eventEndKST = new Date(eventEndUTC.toLocaleString('en-US', { timeZone: 'Asia/Seoul' }));

            // 날짜와 시간 분리
            let eventStartDate = eventStartKST.toISOString().split('T')[0];
            let eventStartTime = eventStartKST.toISOString().split('T')[1].substring(0, 5);
            let eventEndDate = eventEndKST.toISOString().split('T')[0];
            let eventEndTime = eventEndKST.toISOString().split('T')[1].substring(0, 5);
            let eventContent = info.event.extendedProps.content;

            console.log(eventStartDate + ' : ' + eventStartTime);
            // console.log(new Date(info.event.start.getTime() - 9 - (info.event.start.getTimezoneOffset() * 60000)).toISOString().split('T')[1].substring(0, 5));

            $('.eventName').val(eventTitle);
            $('#startDate').val(eventStartDate);
            $('#startTime').val(eventStartTime);
            $('#endDate').val(eventEndDate);
            $('#endTime').val(eventEndTime);
            $('#eventText').val(eventContent);
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
            	console.log(data)
            
              	// 서버에서 받은 데이터를 FullCalendar 형식으로 변환
              	const events = data.map(event => {
                
                // 서버에서 받은 날짜 문자열을 ISO 8601 형식으로 변환
                const startDateUTC = new Date(event.start_date + ' UTC');
                const endDateUTC = new Date(event.end_date + ' UTC');
                
                // 날짜 객체를 ISO 8601 문자열로 변환
                const start = startDateUTC.toISOString();
                const end = endDateUTC.toISOString();

                return {
                  	id: event.room_booking_seq,  
                  	title: event.dept_title,     
                  	start: start,                
                  	end: end                     
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

