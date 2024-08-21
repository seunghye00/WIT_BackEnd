<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form id="addRoomForm" action="/reservation/admin/add?target=meetingRoom" method="post">
<div id="addRoomModal" class="addTargetModal">
	<h1>
		회의실 추가<span class="closeModal">&times</span>
	</h1>
	<div class="addTargetInfo">
		<ul>
			<li><span>회의실 명</span>
				<div>
					<input type="text" name="name" id="name" data-label="회의실 명" oninput='handleOnInput(this, 10)'>
				</div></li>
			<li><span>회의실 위치</span>
				<div>
					<input type="text" name="location" id="location" data-label="회의실 위치" oninput='handleOnInput(this, 10)'>
				</div></li>
			<li><span>수용 인원</span>
				<div>
					<input type="number" name="capacity" id="capacity" min="1">
				</div></li>
			<li><span>예약 안내</span>
				<div>
					<textarea name="guidelines"></textarea>
				</div></li>
			<li>
				<div class="btns">
					<button id="addRoom" type="button">완료</button>
					<button class="red closeModal" type="button">취소</button>
				</div>
			</li>
		</ul>
	</div>
</div>
</form>