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
           	// 날짜 클릭 시 발생할 이벤트
            $('.startDate').val(info.dateStr);
            $("#reservModal").show();
            $(".modalClose").on("click", function () {
               $("#reservModal").hide();
            });
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
            let eventPurpose = info.event.extendedProps.purpose;

            console.log(eventStartDate + ' : ' + eventStartTime);
            // console.log(new Date(info.event.start.getTime() - 9 - (info.event.start.getTimezoneOffset() * 60000)).toISOString().split('T')[1].substring(0, 5));

            $('.eventName').val(eventTitle);
            $('#eventVehicleStartDate').val(eventStartDate);
            $('#eventVehicleStartTime').val(eventStartTime);
            $('#eventVehicleEndDate').val(eventEndDate);
            $('#eventVehicleEndTime').val(eventEndTime);
            $('#eventText').val(eventPurpose);
            $("#eventModal").show();
            $(".modalClose").on("click", function () {
               $("#eventModal").hide();
            });
        },
        events: function (fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                    	// 서버의 이벤트 데이터 엔드포인트
                        url: '/reservation/vehicleEvent', 
                        method: 'GET',
                        dataType: 'json',
                        data:{
                        	vehicleSeq : $('#vehicleSeq').val()
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
                                title: event.emp_no,
                             	// 변환된 시작 날짜
                                start: formatDate(event.start_date), 
                             	// 변환된 종료 날짜
                                end: formatDate(event.end_date),     
                                extendedProps: {
                                	vehicle_booking_seq : event.vehicle,
                                    driver: event.driver,
                                    purpose: event.purpose
                                }
                            })));
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
            let driver = $("#driver").val().trim();
            let purpose = $("textarea[name='purpose']").val().trim();
            let vehicleSeq = $("#vehicleSeq").val().trim();

            // 필수 입력 필드가 비어 있는지 확인
            if (!vehicleName || !startDate || !startTime || !endDate || !endTime || !driver || !purpose) {
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
