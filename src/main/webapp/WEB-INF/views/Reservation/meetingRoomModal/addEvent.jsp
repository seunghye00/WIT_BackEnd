<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form action="/reservation/meetingRoom/addEvent" method="post" id="reservRoomForm">
<input type="hidden" value="${meetingRoomInfo.room_seq}" name="room_seq">
<div id="reservModal" class="modal">
	<div class="modalContent">
		<h1>
			회의실 예약<span class="modalClose">&times</span>
		</h1>
		<div class="calendarAdd">
			<ul>
				<li>
					<span>회의실 명</span>
					<div>
						<input type="text" value="${meetingRoomInfo.name}" readonly>
					</div>
				</li>
				<li>
					<span>예약 기간</span>
					<div>
						<input type="date" class="dateInput" id="bookingDate" readonly>&nbsp;&nbsp;
						<input type="time" class="dateInput" id="startTime" min="10:00" max="17:00" value="10:00">&nbsp;&nbsp;~&nbsp;&nbsp;
						<input type="time" class="dateInput" id="endTime" min="10:00" max="17:00" value="11:00">
						<input type="hidden" name="startDate" id="startDate">
						<input type="hidden" name="endDate" id="endDate">
					</div>
				</li>
				<li>
					<span>장소</span>
					<div>
						<input type="text" class="eventLocation" value="${meetingRoomInfo.location}" readonly>
					</div>
				</li>
				<li>
					<span>예약 목적</span>
					<div>
						<textarea id="purpose" name="purpose"></textarea>
					</div>
				</li>
				<li>
					<div class="btns">
						<button id="addMeetingReserv" type="button">완료</button>
						<button class="red" id="cancelReservBtn" type="button">취소</button>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
</form>