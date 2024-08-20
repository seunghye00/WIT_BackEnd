let globalWebSocket = new WebSocket('ws://192.168.1.4/global_chat');

globalWebSocket.onopen = function (event) {
    console.log("WebSocket is open now.");
};

globalWebSocket.onmessage = function(event) {
    console.log("Received message:", event); // 수신된 메시지 로그 출력
    console.log("Received message:", event.data); // 수신된 메시지 로그 출력
    let data = JSON.parse(event.data);
    if (data.type === 'notification') {
        console.log("Notification message:", data.message);
        showNotificationModal(data.message); // 알림이 오면 모달 자동 띄우기
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

// 알림이 오면 모달을 자동으로 띄우는 함수
function showNotificationModal(message) {
    let modal = document.getElementById("notificationModal");

    // 알림 내용 업데이트
    let notificationList = document.getElementById("notificationList");
    notificationList.innerHTML = ""; // 기존 알림을 모두 제거
    let notificationItem = document.createElement("li");
    notificationItem.textContent = message; // 서버에서 받은 메시지를 그대로 표시
    notificationList.appendChild(notificationItem);

    // 모달 표시
    modal.style.display = "block";
    modal.classList.add("show");

    // 모달 닫기 버튼 처리
    let closeBtn = modal.querySelector(".close");
    closeBtn.onclick = function() {
        modal.style.display = "none";
        modal.classList.remove("show");
    };

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            modal.classList.remove("show");
        }
    };
}
