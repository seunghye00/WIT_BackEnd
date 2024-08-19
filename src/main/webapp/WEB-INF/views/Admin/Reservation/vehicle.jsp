<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 예약</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script defer src="/js/reserv.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.global.min.js"></script>
<script defer src="/js/wit.js"></script></head></head>

<body>
    <div class="container">
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
            <div class="contents">
                <%@ include file="/WEB-INF/views/Reservation/commons/sideToggle.jsp"%>
                <div class="sideContents reservation vehicles">
                    <div class="mainTitle" >차량 [ ${vehicleInfo.name}_${vehicleInfo.license_plate} ]</div>
                    <input type="hidden" value="${vehicleInfo.vehicle_seq}" id="vehicleSeq">
                    <div class="reservBox">
                        <div class="calendar" id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 날짜 박스 눌렀을 시 모달 -->
        <div id="reservModal" class="modal">
            <div class="modalContent">
                <h1>차량 예약<span class="modalClose">&times</span></h1>
                <div class="calendarAdd">
                <form id="vehicleForm" action="/reservation/saveVehicle" method="post">
                    <ul>
                        <li>
                            <span>차량 명</span>
                            <div><input type="text" id="vehicleName" value="${vehicleInfo.name}" readonly></div>
                        </li>
                        <li>
                            <span>예약 기간</span>
                            <div><input type="date" class="startDate dateInput" id="startDate" name="startDate">&nbsp;
                            <input type="time" class="startDate dateInput" id="startTime" name="startTime">&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" class="endDate dateInput" id="endDate" name="endDate">&nbsp;
                            <input type="time" class="endDate dateInput" id ="endTime" name="endTime">
                            </div>
                        </li>
                        <li>
                            <span>탑승자</span>
                            <div><input type="text" id="passenger" name="passenger"></div>
                        </li>
                        <li>
                            <span>예약 목적</span>
                            <div><textarea id="calendarText" name="purpose"></textarea></div>
                        </li>
                        <li>
                            <div class="btns">
                                <button type="submit" id="addBtn" class="okBtn">완료</button><button class="cancelBtn">취소</button>
                            </div>
                        </li>
                    </ul>
                    <input type="hidden" id="vehicleSeq" name="vehicle_seq" value="${vehicleInfo.vehicle_seq }">
                    <input type="hidden" name="vehicleStartAt" id="vehicleStartAt">
                    <input type="hidden" name="vehicleEndAt" id="vehicleEndAt">
                    <input type="hidden" name="dept_title" id="deptTitle">
                    <input type="hidden" name="name" id="name">
                    </form>
                </div>
            </div>
        </div>
        <!-- 일정을 클릭 시 모달 -->
        <div id="eventModal" class="modal">
            <div class="modalContent">
                <h1>차량 예약 내용<span class="modalClose">&times</span></h1>
                <div class="calendarAdd">
                    <ul>
                        <li>
                            <span>차량 명</span>
                            <div><input type="text" id="eventVehicleName" value="${vehicleInfo.name}" readonly></div>
                        </li>
                        <li>
                            <span>예약자</span>
                            <div><input type="text" id="eventDeptTitle" readonly>&nbsp;&nbsp;<input type="text" id="eventName"
                                    readonly></div>
                        </li>
                        <li>
                            <span>예약 기간</span>
                            <div><input type="date" id="eventVehicleStartDate" class="startDate dateInput"
                                    readonly>&nbsp;&nbsp;<input type="time" id="eventVehicleStartTime" class="startDate dateInput"
                                    readonly>&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" id="eventVehicleEndDate"
                                    class="endDate dateInput" readonly>&nbsp;&nbsp;<input type="time" id="eventVehicleEndTime"
                                    class="endDate dateInput" readonly>
                            </div>
                        </li>
                        <li>
                            <span>탑승자</span>
                            <div><input type="text" id="eventPassenger" readonly></div>
                        </li>
                        <li>
                            <span>예약 목적</span>
                            <div><textarea id="eventText" readonly></textarea></div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>