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
						<input type="text" value="회의실 1" readonly>
					</div></li>
				<li><span>예약자</span>
					<div>
						<input type="text" value="인사부" readonly>&nbsp;&nbsp;<input
							type="text" value="이웡히" readonly>
					</div></li>
				<li><span>예약 기간</span>
					<div>
						<input type="date" id="startDate" class="startDate dateInput"
							readonly>&nbsp;&nbsp;<input type="time" id="startTime"
							class="startDate dateInput" readonly>&nbsp;&nbsp;~&nbsp;&nbsp;<input
							type="date" id="endDate" class="endDate dateInput" readonly>&nbsp;&nbsp;<input
							type="time" id="endTime" class="endDate dateInput" readonly>
					</div></li>
				<li><span>장소</span>
					<div>
						<input type="text" class="eventLocation" value="신설동 12 5층 505호"
							readonly>
					</div></li>
				<li><span>예약 목적</span>
					<div>
						<textarea id="calendarText" readonly>그냥 ~~~~</textarea>
					</div></li>
			</ul>
		</div>
	</div>
</div>