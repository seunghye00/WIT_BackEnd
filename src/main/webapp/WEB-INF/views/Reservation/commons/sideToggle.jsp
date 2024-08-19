<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="sideAbout">
	<div class="sideTxt">
		<a href="/reservation/home?type=meetingRoom&cPage=1">
			<h2 class="sideTit">예약관리</h2>
		</a>
	</div>
	<div class="addressListPrivate">
		<ul class="privateList">
			<li class="toggleItem">
				<c:choose>
					<c:when test="${empty meetingRoomInfo}">
						<h3 class="toggleTit">회의실</h3>
						<ul class="subList">
						<c:forEach items="${meetingRooms}" var="i">
							<li>
								<a href="/reservation/meetingRoom?roomSeq=${i.room_seq}">
									${i.name}
								</a>
							</li>
						</c:forEach>
						</ul>
					</c:when>
					<c:otherwise>
						<h3 class="toggleTit active">회의실</h3>
						<ul class="subList active">
						<c:forEach items="${meetingRooms}" var="i">
							<li>
								<a href="/reservation/meetingRoom?roomSeq=${i.room_seq}" 
									<c:if test="${i.room_seq eq meetingRoomInfo.room_seq}">class="active"</c:if>>
									${i.name}
								</a>
							</li>
						</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</li>
		</ul>
	</div>
	<div class="addressListGroup">
		<ul class="GroupList">
			<li class="toggleItem">
				<c:choose>
					<c:when test="${empty vehicleInfo}">
						<h3 class="toggleTit">차량</h3>
						<ul class="subList">
						<c:forEach items="${vehicles}" var="i">
							<li>
								<a href="/reservation/vehicle?vehicleSeq=${i.vehicle_seq}">
									${i.name}_${i.license_plate}
								</a>
							</li>
						</c:forEach>
						</ul>
					</c:when>
					<c:otherwise>
						<h3 class="toggleTit active">차량</h3>
						<ul class="subList active">
						<c:forEach items="${vehicles}" var="i">
							<li>
								<a href="/reservation/vehicle?vehicleSeq=${i.vehicle_seq}" 
									<c:if test="${vehicleInfo.vehicle_seq eq i.vehicle_seq}">class="active"</c:if>>
									${i.name}_${i.license_plate}
								</a>
							</li>
						</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</li>
		</ul>
	</div>
</div>