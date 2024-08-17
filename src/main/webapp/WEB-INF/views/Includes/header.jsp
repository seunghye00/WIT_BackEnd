<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="header">
    <!-- 마이페이지로 이동 -->
    <span class="myName"> 
        <img src="/resources/img/푸바오.png" alt="프로필 사진" class="userImg">
        <a href="/employee/mypage">${loginName} ${loginRole}</a>
    </span> 
    <span class="alert">
        <a href="javascript:;" id="notificationBell" data-toggle="modal" data-target="#notificationModal">
            <i class="bx bxs-bell"></i>
            <c:if test="${notiCount > 0}">
                <span class="badge">${notiCount}</span> <!-- 알림 개수 표시 -->
            </c:if>
        </a>
    </span> 
    <span class="logOut">
        <a href="/employee/logout">
            <i class='bx bx-log-in'></i>
        </a>
    </span>
</div>

<!-- 알림 모달 -->
<div class="aram_modal fade" id="notificationModal" tabindex="-1" role="dialog" aria-labelledby="notificationModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="notificationModalLabel">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <ul id="notificationList">
          <!-- 알림 목록이 여기에 동적으로 추가됩니다 -->
        </ul>
      </div>
    </div>
  </div>
</div>
<script>
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
</script>
