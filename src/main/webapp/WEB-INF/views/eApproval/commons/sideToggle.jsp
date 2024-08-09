<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="addressListPrivate">
	<ul class="privateList">
		<li class="toggleItem">
			<h3 class="toggleTit">결재하기</h3>
			<ul class="subList">
				<c:choose>
					<c:when test="${type eq 'todo'}">
						<li><a href="/eApproval/apprList?type=todo" class="active">결재 대기 문서</a></li>
						<li><a href="/eApproval/apprList?type=upcoming">결재 예정 문서</a></li>
					</c:when>
					<c:when test="${type eq 'upcoming'}">
						<li><a href="/eApproval/apprList?type=todo">결재 대기 문서</a></li>
						<li><a href="/eApproval/apprList?type=upcoming" class="active">결재 예정 문서</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/eApproval/apprList?type=todo">결재 대기 문서</a></li>
						<li><a href="/eApproval/apprList?type=upcoming">결재 예정 문서</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</li>
	</ul>
</div>
<div class="addressListGroup">
	<ul class="GroupList">
		<li class="toggleItem">
			<h3 class="toggleTit">개인 문서함</h3>
			<ul class="subList">
				<c:choose>
					<c:when test="${type eq 'write'}">
						<li><a href="/eApproval/privateList?type=write" class="active">기안 문서함</a></li>
						<li><a href="/eApproval/privateList?type=save">임시 저장 문서함</a></li>
						<li><a href="/eApproval/privateList?type=approved">결재 문서함</a></li>
						<li><a href="/eApproval/privateList?type=return">반려 문서함</a></li>
						<li><a href="/eApproval/privateList?type=view">참조 문서함</a></li>
					</c:when>
					<c:when test="${type eq 'save'}">
						<li><a href="/eApproval/privateList?type=write">기안 문서함</a></li>
						<li><a href="/eApproval/privateList?type=save" class="active">임시 저장 문서함</a></li>
						<li><a href="/eApproval/privateList?type=approved">결재 문서함</a></li>
						<li><a href="/eApproval/privateList?type=return">반려 문서함</a></li>
						<li><a href="/eApproval/privateList?type=view">참조 문서함</a></li>
					</c:when>
					<c:when test="${type eq 'approved'}">
						<li><a href="/eApproval/privateList?type=write">기안 문서함</a></li>
						<li><a href="/eApproval/privateList?type=save">임시 저장 문서함</a></li>
						<li><a href="/eApproval/privateList?type=approved" class="active">결재 문서함</a></li>
						<li><a href="/eApproval/privateList?type=return">반려 문서함</a></li>
						<li><a href="/eApproval/privateList?type=view">참조 문서함</a></li>
					</c:when>
					<c:when test="${type eq 'return'}">
						<li><a href="/eApproval/privateList?type=write">기안 문서함</a></li>
						<li><a href="/eApproval/privateList?type=save">임시 저장 문서함</a></li>
						<li><a href="/eApproval/privateList?type=approved">결재 문서함</a></li>
						<li><a href="/eApproval/privateList?type=return" class="active">반려 문서함</a></li>
						<li><a href="/eApproval/privateList?type=view">참조 문서함</a></li>
					</c:when>
					<c:when test="${type eq 'view'}">
						<li><a href="/eApproval/privateList?type=write">기안 문서함</a></li>
						<li><a href="/eApproval/privateList?type=save">임시 저장 문서함</a></li>
						<li><a href="/eApproval/privateList?type=approved">결재 문서함</a></li>
						<li><a href="/eApproval/privateList?type=return">반려 문서함</a></li>
						<li><a href="/eApproval/privateList?type=view" class="active">참조 문서함</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/eApproval/privateList?type=write">기안 문서함</a></li>
						<li><a href="/eApproval/privateList?type=save">임시 저장 문서함</a></li>
						<li><a href="/eApproval/privateList?type=approved">결재 문서함</a></li>
						<li><a href="/eApproval/privateList?type=return">반려 문서함</a></li>
						<li><a href="/eApproval/privateList?type=view">참조 문서함</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</li>
	</ul>
</div>