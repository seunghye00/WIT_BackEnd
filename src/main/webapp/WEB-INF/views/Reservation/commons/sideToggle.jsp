<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="sideAbout">
	<div class="sideTxt">
		<a href="/reservation/home">
			<h2 class="sideTit">예약관리</h2>
		</a>
	</div>
	<div class="addressListPrivate">
		<ul class="privateList">
			<li class="toggleItem">
				<h3 class="toggleTit">회의실</h3>
				<ul class="subList">
					<li><a href="/reservation/meetingRoom">회의실 1</a></li>
					<li><a href="/reservation/meetingRoom">회의실 2</a></li>
					<li><a href="/reservation/meetingRoom">회의실 3</a></li>
					<li><a href="/reservation/meetingRoom">회의실 4</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="addressListGroup">
		<ul class="GroupList">
			<li class="toggleItem">
				<h3 class="toggleTit">차량</h3>
				<ul class="subList">
					<li><a href="/reservation/vehicle">BMW X6_9688</a></li>
					<li><a href="/reservation/vehicle">싼타페_7574</a></li>
					<li><a href="/reservation/vehicle">마이바흐_1106</a></li>
					<li><a href="/reservation/vehicle">G90_9720</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>