<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="companyEventModal" class="modal">
	<div class="modalContent calendarCont">
		<h1>
			일정 내용<span class="modalClose" id="eventModalClose">&times;</span>
		</h1>
		<div class="eventCheck">
		    <form id="companyEventEditForm" action="/events/editEvent" method="post">
		        <input type="hidden" name="events_seq" class="eventSeq">
		        <ul>
		            <li><span>일정명</span>
		                <div>
		                    <input type="text" class="eventName" id="compEventName" name="title" disabled>
		                </div>
		            </li>
		            <li><span>일정기간</span>
		                <div>
		                    <input type="date" id="compEventStartDate" class="eventStartDate startDate dateInput" name="editStartDate" disabled>
		                    <input type="time" id="compEventStartTime" class="eventStartTime startDate dateInput" name="editStartTime" disabled>
		                    ~
		                    <input type="date" id="compEventEndDate" class="eventEndDate endDate dateInput" name="editEndDate" disabled>
		                    <input type="time" id="compEventEndTime" class="eventEndTime endDate dateInput" name="editEndTime" disabled>
		                </div>
		            </li>
		            <li><span>전사 일정</span>
		                <div>
		                    <select class="choiEvent" name="calendar_seq" disabled>
		                        <c:forEach items="${clist}" var="dto">
		                            <option value="${dto.calendar_seq}">${dto.calendar_name}</option>
		                        </c:forEach>
		                    </select>
		                </div>
		            </li>
		            <li><span>장소</span>
		                <div>
		                    <input type="text" class="eventLocation" id="compEventLocation" name="location" disabled>
		                </div>
		            </li>
		            <li><span>내용</span>
		                <div>
		                    <textarea class="eventText" id="compEventText" name="content" disabled></textarea>
		                </div>
		            </li>
		            <li>
		                <c:if test="${employee.role_code eq 'R1'}">
		                    <div class="btns">
		                        <button type="button" id="companyEditBtn" class="editBtn">수정</button>
		                        <button type="submit" id="companyConfirmBtn" class="confirmBtn">확인</button>
		                        <button type="button" class="deleteBtn" id="eventDel">삭제</button>
		                        <button type="button" class="cancelBtn editCancelBtn">취소</button>
		                    </div>
		                </c:if>
		            </li>
		        </ul>
		        <input type="hidden" name="editStartAt" class="editStartAt" id="compEditStartAt">
		        <input type="hidden" name="editEndAt" class="editEndAt" id="compEditEndAt">
		    </form>
		</div>
	</div>
</div>