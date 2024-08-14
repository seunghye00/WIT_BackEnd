<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="header">
	<!--마이페이지로 이동-->
	<span class="myName"> 
		<img src="/resources/img/푸바오.png" alt="프로필 사진" class="userImg">
		<a href="/employee/mypage">${loginName} ${loginRole}</a></span> 
		<span class="alert">
			<a href="javascript:;" id="notificationBell" onclick="loadNotifications();" data-toggle="modal" data-target="#notificationModal">
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
//읽지 않은 메시지를 알림하는 함수
function displayUnreadMessageNotification(data) {
    let notificationArea = $("#notificationArea");
    let notification = $("<div>").addClass("notification").text(data.sender + "님의 새 메시지가 도착했습니다.");
    notificationArea.append(notification);
	console.log(data);
    // 5초 후에 알림을 사라지게 하는 예시
    setTimeout(function() {
        notification.fadeOut(500, function() {
            $(this).remove();
        });
    }, 5000);
}
</script>
