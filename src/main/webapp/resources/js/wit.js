// sidebar 공통요소 script
let btn = $('#btn');
let sideBar = $('.sideBar');

btn.on('click', function() {
	sideBar.toggleClass('active');
});

// 토글 이벤트 설정
const toggleItems = $('.toggleItem');
toggleItems.each(function() {
	const toggleItem = $(this);
    const toggleTit = toggleItem.find('.toggleTit');
    const subList = toggleItem.find('.subList');

    toggleTit.on('click', function() {
    	subList.toggleClass('active');
        toggleTit.toggleClass('active'); // 이미지 회전을 위해 클래스 추가
    });
});
// 툴바 활성화
const links = $('.toolBar a');
links.on('click', function() {
	links.removeClass('active'); // 모든 링크에서 active 클래스 제거
    $(this).addClass('active'); // 클릭한 링크에 active 클래스 추가
});


let globalWebSocket = new WebSocket('ws://192.168.45.236/global_chat');
	globalWebSocket.onopen = function (event) {
	    console.log("WebSocket is open now.");
	};

	globalWebSocket.onmessage = function(event) {
	    console.log("Received message:", event); // 수신된 메시지 로그 출력
	    console.log("Received message:", event.data); // 수신된 메시지 로그 출력
	    let data = JSON.parse(event.data);
	    if (data.type === 'notification') {
	        console.log("Notification message:", data.message);
	        addNotificationToModal(data.message);
	        showNotificationModal(); // 알림이 오면 모달 자동 띄우기
	    } else {
	        console.log("Unexpected message type:", data.type);
	    }
	};
	

	globalWebSocket.onerror = function(error) {
	    console.log("WebSocket error observed:", error);
	};

	globalWebSocket.onclose = function(event) {
	    console.log("WebSocket connection closed:", event);
	};
	// 알림을 모달에 추가하는 함수
	function addNotificationToModal(message) {
	    let notificationList = $("#notificationList");
	    let notificationItem = $("<li>").text(message);
	    notificationList.append(notificationItem);
	}
	
	// 알림이 오면 모달을 자동으로 띄우는 함수
	function showNotificationModal() {
	    $('#notificationModal').modal('show'); // Bootstrap 모달을 표시
	}