<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="eventModal" class="modal">
	<div class="modalContent">
		<h1>
			회의실 예약 내용<span class="modalClose">&times</span>
		</h1>
		<div class="calendarAdd">
			<ul>
				<li><span>회의실 명</span>
					<div>
						<input type="text" id="roomName" readonly>
					</div></li>
				<li><span>예약자</span>
					<div>
						<input type="text" id="dept" readonly>&nbsp;&nbsp;<input
							type="text" id="empName" readonly>
					</div></li>
				<li><span>예약 기간</span>
					<div>
						<input type="date" id="eStartDate" class="startDate dateInput" readonly>&nbsp;&nbsp;
						<input type="time" id="eStartTime" class="startDate dateInput" readonly>&nbsp;&nbsp;~&nbsp;&nbsp;
						<input type="date" id="eEndDate" class="endDate dateInput" readonly>&nbsp;&nbsp;
						<input type="time" id="eEndTime" class="endDate dateInput" readonly>
					</div></li>
				<li><span>장소</span>
					<div>
						<input type="text" class="eventLocation" id="roomLocation" readonly>
					</div></li>
				<li><span>예약 목적</span>
					<div>
						<textarea id="bookingPurpose" readonly></textarea>
					</div></li>
			</ul>
		</div>
	</div>
</div>