    let btn = document.querySelector("#btn")
    let sideBar = document.querySelector(".sideBar")

    btn.onclick = function () {
        sideBar.classList.toggle("active")
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

    $('.cancelBtn').on('click', function () {
        location.reload();
    })

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
    })




    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
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
            events: [
                // 시간을 입력하지 않으면 오늘 정각부터 다음 날 정각까지
                {
                    title: 'All Day Event',
                    start: '2024-07-30'
                }
            ]
        });

        calendar.render();
    });