<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="header">
	<!--마이페이지로 이동-->
	<span class="myName"> <img src="/resources/img/푸바오.png"
		alt="프로필 사진" class="userImg"><a href="/employee/mypage">${loginName}
			${loginRole}</a></span> <span class="alert"><a href=""><i
			class='bx bx-bell'></i></a></span> <span class="logOut"><a
		href="/employee/logout"><i class='bx bx-log-in'></i></a></span>
</div>