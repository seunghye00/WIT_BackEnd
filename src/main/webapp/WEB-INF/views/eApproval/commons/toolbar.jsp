<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="toolBar">
	<ul>
		<c:choose>
			<c:when test="${type eq 'todo' or type eq 'upcoming'}">
				<c:choose>
					<c:when test="${docuCode eq 'M1'}">
						<li><a href="/eApproval/apprList?type=${type}">전체</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M1"
							class="active">업무 기안</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M2">휴가
								신청서</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M3">지각
								사유서</a></li>
					</c:when>
					<c:when test="${docuCode eq 'M2'}">
						<li><a href="/eApproval/apprList?type=${type}">전체</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M1">업무
								기안</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M2"
							class="active">휴가 신청서</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M3">지각
								사유서</a></li>
					</c:when>
					<c:when test="${docuCode eq 'M3'}">
						<li><a href="/eApproval/apprList?type=${type}">전체</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M1">업무
								기안</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M2">휴가
								신청서</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M3"
							class="active">지각 사유서</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/eApproval/apprList?type=${type}" class="active">전체</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M1">업무
								기안</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M2">휴가
								신청서</a></li>
						<li><a href="/eApproval/apprList?type=${type}&docuCode=M3">지각
								사유서</a></li>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${docuCode eq 'M1'}">
						<li><a href="/eApproval/privateList?type=${type}">전체</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M1"
							class="active">업무 기안</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M2">휴가
								신청서</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M3">지각
								사유서</a></li>
					</c:when>
					<c:when test="${docuCode eq 'M2'}">
						<li><a href="/eApproval/privateList?type=${type}">전체</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M1">업무
								기안</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M2"
							class="active">휴가 신청서</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M3">지각
								사유서</a></li>
					</c:when>
					<c:when test="${docuCode eq 'M3'}">
						<li><a href="/eApproval/privateList?type=${type}">전체</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M1">업무
								기안</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M2">휴가
								신청서</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M3"
							class="active">지각 사유서</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/eApproval/privateList?type=${type}"
							class="active">전체</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M1">업무
								기안</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M2">휴가
								신청서</a></li>
						<li><a href="/eApproval/privateList?type=${type}&docuCode=M3">지각
								사유서</a></li>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>

	</ul>
	<div class="searchBox">
		<input type="text" placeholder="검색">
		<button class="searchBtn">
			<i class="bx bx-search"></i>
		</button>
	</div>
</div>