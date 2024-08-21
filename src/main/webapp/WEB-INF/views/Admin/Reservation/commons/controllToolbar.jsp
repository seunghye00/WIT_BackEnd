<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="toolBar">
	<ul>
		<c:choose>
			<c:when test="${controll eq 'meetingRoom' && purpose eq 'notice'}">
				<li><a href="/reservation/admin/bookingControll?type=meetingRoom&seq=1&purpose=notice" class="active">이용 안내</a></li>
				<li><a href="/reservation/admin/bookingControll?type=meetingRoom&purpose=controll">관리</a></li>
			</c:when>
			<c:when test="${controll eq 'meetingRoom' && purpose eq 'controll'}">
				<li><a href="/reservation/admin/bookingControll?type=meetingRoom&seq=1&purpose=notice">이용 안내</a></li>
				<li><a href="/reservation/admin/bookingControll?type=meetingRoom&purpose=controll" class="active">관리</a></li>
				<button id="addRoomList">추가</button>
				<%@ include file="/WEB-INF/views/Admin/Reservation/commons/addRoomList.jsp"%>
			</c:when>
			<c:when test="${controll eq 'vehicle' && purpose eq 'notice'}">
				<li><a href="/reservation/admin/bookingControll?type=vehicle&seq=1&purpose=notice" class="active">이용 안내</a></li>
				<li><a href="/reservation/admin/bookingControll?type=vehicle&purpose=controll">관리</a></li>
			</c:when>
			<c:when test="${controll eq 'vehicle' && purpose eq 'controll'}">
				<li><a href="/reservation/admin/bookingControll?type=vehicle&seq=1&purpose=notice">이용 안내</a></li>
				<li><a href="/reservation/admin/bookingControll?type=vehicle&purpose=controll" class="active">관리</a></li>
				<button id="addVehicleList">추가</button>
				<%@ include file="/WEB-INF/views/Admin/Reservation/commons/addVehicleList.jsp"%>
			</c:when>
		</c:choose>
	</ul>
</div>