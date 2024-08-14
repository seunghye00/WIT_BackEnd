<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 예약</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.global.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script defer src="/js/wit.js"></script>
<script defer src="/js/reservMeeting.js"></script>
</head>
<body>
    <div class="container">
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
				 <%@ include file="/WEB-INF/views/Reservation/commons/sideToggle.jsp"%>
                <div class="sideContents reservation meetingRooms">
                    <div class="mainTitle">회의실 [ ${meetingRoomInfo.name} ] <span>최대 수용 인원 : ${meetingRoomInfo.capacity}명</span></div>
                    <input type="hidden" value="${meetingRoomInfo.room_seq}" id="roomSeq">
                    <div class="reservBox">
                        <div class="calendar" id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/views/Reservation/meetingRoomModal/addEvent.jsp"%>
    	<%@ include file="/WEB-INF/views/Reservation/meetingRoomModal/viewEvent.jsp"%>
    </div>
</body>
</html>