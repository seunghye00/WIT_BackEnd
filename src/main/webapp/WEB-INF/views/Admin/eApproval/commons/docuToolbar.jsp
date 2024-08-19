<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="toolBar">
	<ul>
		<c:choose>
			<c:when test="${status eq '진행중'}">
				<li><a href="/eApproval/admin/docuList?type=${type}&cPage=1">전체</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=진행중&cPage=1"
					class="active">진행중</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=완료&cPage=1">완료</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=반려&cPage=1">반려</a></li>
			</c:when>
			<c:when test="${status eq '완료'}">
				<li><a href="/eApproval/admin/docuList?type=${type}&cPage=1">전체</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=진행중&cPage=1"
					class="active">진행중</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=완료&cPage=1" class="active">완료</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=반려&cPage=1">반려</a></li>
			</c:when>
			<c:when test="${status eq '반려'}">
				<li><a href="/eApproval/admin/docuList?type=${type}&cPage=1">전체</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=진행중&cPage=1">진행중</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=완료&cPage=1">완료</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=반려&cPage=1" class="active">반려</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/eApproval/admin/docuList?type=${type}&cPage=1" class="active">전체</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=진행중&cPage=1">진행중</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=완료&cPage=1">완료</a></li>
				<li><a
					href="/eApproval/admin/docuList?type=${type}&status=반려&cPage=1">반려</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
	<div class="searchBox">
		<input type="hidden" value="${type}" id="listType"> <input
			type="hidden" value="${status}" id="status">
		<c:choose>
			<c:when test="${keyword != null}">
				<input type="text" placeholder="검색" id="searchTxt"
					value="${keyword}">
			</c:when>
			<c:otherwise>
				<input type="text" placeholder="검색" id="searchTxt">
			</c:otherwise>
		</c:choose>
		<button class="searchBtn">
			<i class="bx bx-search"></i>
		</button>
	</div>
</div>