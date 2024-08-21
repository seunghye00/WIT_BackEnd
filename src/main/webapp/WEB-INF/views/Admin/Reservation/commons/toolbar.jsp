<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="toolBar">
	<ul>
		<c:choose>
			<c:when test="${type eq 'meetingRoom'}">
				<li><a href="/reservation/admin/home?type=meetingRoom&cPage=1" class="active">회의실</a></li>
				<li><a href="/reservation/admin/home?type=vehicle&cPage=1">차량</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/reservation/admin/home?type=meetingRoom&cPage=1">회의실</a></li>
				<li><a href="/reservation/admin/home?type=vehicle&cPage=1" class="active">차량</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
	<div class="searchBox">
		<input type="text" id="searchTxt" placeholder="검색">
		<button class="searchBtn">
			<i class="bx bx-search"></i>
		</button>
	</div>
</div>