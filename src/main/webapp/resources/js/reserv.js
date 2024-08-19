$('.cancelBtn').on('click', function () {
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

$('#addBtn').on('click', function () {
   // 입력 필드값 변수에 저장
   let eventName = $('#eventName').val();
    let startDate = $('#startDate').val();
    let startTime = $('#startTime').val();
    let endDate = $('#endDate').val();
    let endTime = $('#endTime').val();
    let calendar = $('#choiCalendar').val();
    let eventLocation = $('#eventLocation').val();
    let calendarText = $('#calendarText').val();

    // 입력 필드에서 가져온 값을 사용하여 이벤트 객체 생성
    let event = {
       eventName: eventName,
        startDate: startDate,
        startTime: startTime,
        endDate: endDate,
        endTime: endTime,
        calendar: calendar,
        eventLocation: eventLocation,
        calendarText: calendarText
    };

    $('#calendarModal').hide();
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
        		alert('이벤트는 오늘 이후 날짜에만 생성할 수 있습니다.');
        		return;
    		}

    // 선택한 날짜가 다른 이벤트의 시작일과 종료일 사이에 있는지 확인
    const isEventInRange = events.some(event => {
        // 이벤트 시작 날짜 (Date 객체)
        const eventStartDate = new Date(event.start.toISOString().split('T')[0]);
        // 이벤트 종료 날짜 (Date 객체)
        const eventEndDate = new Date(event.end ? event.end.toISOString().split('T')[0] : eventStartDate);

        // 이벤트의 종료일이 없다면 시작 날짜만 체크, 있다면 종료일도 포함해서 체크
        return selectedDate >= eventStartDate && selectedDate <= eventEndDate;
    });

    if (isEventInRange) {
        alert('선택한 날짜에 이미 이벤트가 있거나 기간 내에 포함됩니다. 다른 날짜를 선택해주세요.');
    } else {
        // 선택한 날짜에 이벤트가 없고, 오늘 이후일 경우 예약 모달을 보여줌
        $('.startDate').val(info.dateStr);
        $("#reservModal").show();
        $(".modalClose").on("click", function() {
            $("#reservModal").hide();
        });
    }
        },
        eventClick: function (info) {
        
        console.log(info);
    
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
            
            let eventPassenger = info.event.extendedProps.passenger;
            let eventPurpose = info.event.extendedProps.purpose;
            let eventDeptTitle = info.event.extendedProps.deptTitle;
            let eventName = info.event.extendedProps.name;

            console.log(eventStartDate + ' : ' + eventStartTime);
            // console.log(new Date(info.event.start.getTime() - 9 - (info.event.start.getTimezoneOffset() * 60000)).toISOString().split('T')[1].substring(0, 5));

            $('.eventName').val(eventTitle);
            $('#eventVehicleStartDate').val(eventStartDate);
            $('#eventVehicleStartTime').val(eventStartTime);
            $('#eventVehicleEndDate').val(eventEndDate);
            $('#eventVehicleEndTime').val(eventEndTime);
            $('#eventPassenger').val(eventPassenger);
            $('#eventDeptTitle').val(eventDeptTitle);
            $('#eventText').val(eventPurpose);
            $('#eventName').val(eventName);
            $("#eventModal").show();
            $(".modalClose").on("click", function () {
               $("#eventModal").hide();
            });
        },
        events: function (fetchInfo, successCallback, failureCallback) {
 			$.ajax({
    		// 서버의 이벤트 데이터 엔드포인트
    			url: '/reservation/allVehicleBooking',
    			method: 'GET',
    			dataType: 'json',
    			data: {
        			vehicleSeq: $('#vehicleSeq').val()
   	 			},
    			success: function (data) {
        			console.log(data); // 서버로부터 받은 데이터를 콘솔에 출력

        		// 날짜와 시간을 ISO 8601 형식으로 변환하는 함수
        		function formatDate(dateStr) {
            		let date = new Date(dateStr);
            		let year = date.getFullYear();
            		let month = (date.getMonth() + 1).toString().padStart(2, '0');
            		let day = date.getDate().toString().padStart(2, '0');
            		let hours = date.getHours().toString().padStart(2, '0');
            		let minutes = date.getMinutes().toString().padStart(2, '0');
            		let seconds = date.getSeconds().toString().padStart(2, '0');

            		return year + '-' + month + '-' + day + 'T' + hours + ':' + minutes + ':' + seconds;
        		}

        		// 이벤트 데이터 매핑 및 색상 지정
        		successCallback(data.map(event => {
            		let color = '#3788D8'; // 기본 색상

            		if (event.dept_title === '인사부') {
               	 		color = '#81DAC6';
            		} else if (event.dept_title === '영업부') {
                		color = '#C8DD9F';
            		} else if (event.dept_title === 'IT부') {
                		color = '#F5D48F';
            		} else if (event.dept_title === '마케팅부') {
                		color = '#F28376';
            		} else if (event.dept_title === '기술지원부') {
                		color = '#C4A4D1';
            		}

            		return {
                		title: event.name,
                		start: formatDate(event.start_date), // 변환된 시작 날짜
                		end: formatDate(event.end_date), // 변환된 종료 날짜
                		color: color,
               			extendedProps: {
                    		passenger: event.passenger,
                    		purpose: event.purpose,
                    		deptTitle: event.dept_title,
                    		name: event.name
                	}
            	};
        	}));
    	},
    	error: function () {
        	alert('이벤트를 불러오는데 실패했습니다.');
        	failureCallback();
    	}
	});

                }
    });

    calendar.render();
});

document.getElementById('vehicleForm').addEventListener('submit', function (event){
	// 기본 폼 제출 동작을 막음
            event.preventDefault();
            console.log("폼태그 동작 확인");

            // 필수 입력 필드들을 확인
            let vehicleName = $("#vehicleName").val().trim();
            let startDate = $("#startDate").val().trim();
            let startTime = $("#startTime").val().trim();
            let endDate = $("#endDate").val().trim();
            let endTime = $("#endTime").val().trim();
            let passenger = $("#passenger").val().trim();
            let deptTitle = $("#deptTitle").val().trim();
            let purpose = $("textarea[name='purpose']").val().trim();
            let vehicleSeq = $("#vehicleSeq").val().trim();

            // 필수 입력 필드가 비어 있는지 확인
            if (!vehicleName || !startDate || !startTime || !endDate || !endTime || !passenger || !purpose) {
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
            $("#vehicleStartAt").val(startTimestamp);
            $("#vehicleEndAt").val(endTimestamp);

            // 모든 검증을 통과한 후 폼 제출
            event.target.submit();
        });
