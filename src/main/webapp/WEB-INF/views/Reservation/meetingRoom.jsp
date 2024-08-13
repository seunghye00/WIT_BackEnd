<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 예약</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script defer src="/js/reserv.js"></script>
<script defer src="/js/wit.js"></script></head>
<body>
    <div class="container">
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
				 <%@ include file="/WEB-INF/views/Reservation/commons/sideToggle.jsp"%>
                <div class="sideContents reservation meetingRooms">
                    <div class="mainTitle">회의실 [ 회의실1 ]</div>
                    <div class="reservBox">
                        <div class="calendar" id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 날짜 박스 눌렀을 시 모달 -->
        <div id="reservModal" class="modal">
            <div class="modalContent">
                <h1>회의실 예약<span class="modalClose">&times</span></h1>
                <div class="calendarAdd">
                    <ul>
                        <li>
                            <span>회의실 명</span>
                            <div><input type="text" value="회의실 1" readonly></div>
                        </li>
                        <li>
                            <span>예약 기간</span>
                            <div><input type="date" class="startDate dateInput">&nbsp;&nbsp;<input type="time"
                                    class="startDate dateInput">&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date"
                                    class="endDate dateInput">&nbsp;&nbsp;<input type="time" class="endDate dateInput">
                            </div>
                        </li>
                        <li>
                            <span>장소</span>
                            <div><input type="text" class="eventLocation" value="신설동 12 5층 505호" readonly></div>
                        </li>
                        <li>
                            <span>예약 목적</span>
                            <div><textarea id="calendarText"></textarea></div>
                        </li>
                        <li>
                            <div class="btns">
                                <button id="addBtn" class="okBtn">완료</button><button class="cancelBtn">취소</button>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- 일정을 클릭 시 모달 -->
        <div id="eventModal" class="modal">
            <div class="modalContent">
                <h1>회의실 예약 내용<span class="modalClose">&times</span></h1>
                <div class="calendarAdd">
                    <ul>
                        <li>
                            <span>회의실 명</span>
                            <div><input type="text" value="회의실 1" readonly></div>
                        </li>
                        <li>
                            <span>예약자</span>
                            <div>
                                <input type="text" value="인사부" readonly>&nbsp;&nbsp;<input type="text" value="이웡히"
                                    readonly>
                            </div>
                        </li>
                        <li>
                            <span>예약 기간</span>
                            <div><input type="date" id="startDate" class="startDate dateInput"
                                    readonly>&nbsp;&nbsp;<input type="time" id="startTime" class="startDate dateInput"
                                    readonly>&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" id="endDate"
                                    class="endDate dateInput" readonly>&nbsp;&nbsp;<input type="time" id="endTime"
                                    class="endDate dateInput" readonly>
                            </div>
                        </li>
                        <li>
                            <span>장소</span>
                            <div><input type="text" class="eventLocation" value="신설동 12 5층 505호" readonly></div>
                        </li>
                        <li>
                            <span>예약 목적</span>
                            <div><textarea id="calendarText" readonly>그냥 ~~~~</textarea></div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>