<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="header">
    <!-- 마이페이지로 이동 -->
    <span class="myName"> 
	    <span class="myImgBox">
	        <img src="" alt="프로필 사진" class="userImg">
	    </span>
        <a href="/employee/mypage"></a>
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
        <a href="/employee/logout" onclick="return confirmLogout();">
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

function confirmLogout() {
    return confirm("로그아웃 하시겠습니까?");
}

$(document).ready(function() {
    $.ajax({
        url: '/employee/getSessionInfo',
        type: 'GET',
        success: function(response) {
            // 로그인 정보가 성공적으로 불러와졌을 때
            if (response.photo) {
                $('.myImgBox img').attr('src', response.photo);
            }
            if (response.name && response.role_code) {
                $('.myName a').text(response.role_code + ' ' + response.name);
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
        }
    });
});
</script>