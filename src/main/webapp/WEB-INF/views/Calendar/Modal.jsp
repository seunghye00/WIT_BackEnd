<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="personEventModal" class="modal">
	<div class="modalContent calendarCont">
		<h1>
			일정 내용<span class="modalClose" id="eventModalClose">&times;</span>
		</h1>
		<div class="eventCheck">
			<form id="eventEditForm" action="/events/editEvent" method="post">
				<input type="hidden" name="events_seq" class="eventSeq">
				<ul>
					<li><span>일정명</span>
						<div>
							<input type="text" class="eventName" id="perEventName" name="title" disabled>
						</div></li>
					<li><span>일정기간</span>
						<div>
							<input type="date" id="perEventStartDate"
								class="eventStartDate startDate dateInput" name="editStartDate" disabled>
							<input type="time" id="perEventStartTime"
								class="eventStartTime startDate dateInput" name="editStartTime" disabled>
							~ <input type="date" id="perEventEndDate" class="eventEndDate endDate dateInput"
								name="editEndDate" disabled> <input type="time"
								id="perEventEndTime" class="eventEndTime endDate dateInput" name="editEndTime"
								disabled>
						</div></li>
					<li><span>내 캘린더</span>
						<div>
							<select class="choiEvent" name="calendar_seq" disabled>
								<c:forEach items="${plist}" var="dto">
									<option value="${dto.calendar_seq}">${dto.calendar_name}</option>
								</c:forEach>
							</select>
						</div></li>
					<li><span>장소</span>
						<div>
							<input type="text" class="eventLocation" id="perEventLocation" name="location" disabled>
						</div></li>
					<li><span>내용</span>
						<div>
							<textarea class="eventText" name="content" id="perEventText" disabled></textarea>
						</div></li>
					<li>
						<div class="btns">
							<button type="button" id="editBtn" class="editBtn">수정</button>
							<button type="submit" id="perConfirmBtn" class="confirmBtn">확인</button>
							<button type="button" class="deleteBtn" id="eventDel">삭제</button>
							<button type="button" class="cancelBtn editCancelBtn">취소</button>
						</div>
					</li>
				</ul>
				<input type="hidden" name="editStartAt" class="editStartAt" id="perEditStartAt"> <input
					type="hidden" name="editEndAt" class="editEndAt" id="perEditEndAt">
			</form>
		</div>
	</div>
</div>