<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="addressListPrivate">
	<ul class="privateList">
		<li class="toggleItem">
			<c:choose>
				<c:when test="${type eq 'todo'}">
					<h3 class="toggleTit active">결재하기</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/apprList?type=todo&cPage=1" class="active">결재 대기 문서</a></li>
						<li><a href="/eApproval/admin/apprList?type=upcoming&cPage=1">결재 예정 문서</a></li>
					</ul>
				</c:when>
				<c:when test="${type eq 'upcoming'}">
					<h3 class="toggleTit active">결재하기</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/apprList?type=todo&cPage=1">결재 대기 문서</a></li>
						<li><a href="/eApproval/admin/apprList?type=upcoming&cPage=1"
							class="active">결재 예정 문서</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<h3 class="toggleTit">결재하기</h3>
					<ul class="subList">
						<li><a href="/eApproval/admin/apprList?type=todo&cPage=1">결재 대기 문서</a></li>
						<li><a href="/eApproval/admin/apprList?type=upcoming&cPage=1">결재 예정 문서</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</li>
	</ul>
</div>
<div class="addressListPrivate">
	<ul class="GroupList">
		<li class="toggleItem">
			<c:choose>
				<c:when test="${type eq 'approved'}">
					<h3 class="toggleTit active">개인 문서함</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/privateList?type=approved&cPage=1"
							class="active">결재 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=return&cPage=1">반려 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=view&cPage=1">참조 문서함</a></li>
					</ul>
				</c:when>
				<c:when test="${type eq 'return'}">
					<h3 class="toggleTit active">개인 문서함</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/privateList?type=approved&cPage=1">결재 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=return&cPage=1"
							class="active">반려 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=view&cPage=1">참조 문서함</a></li>
					</ul>
				</c:when>
				<c:when test="${type eq 'view'}">
					<h3 class="toggleTit active">개인 문서함</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/privateList?type=approved&cPage=1">결재 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=return&cPage=1">반려 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=view&cPage=1" class="active">참조
								문서함</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<h3 class="toggleTit">개인 문서함</h3>
					<ul class="subList">
						<li><a href="/eApproval/admin/privateList?type=approved&cPage=1">결재 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=return&cPage=1">반려 문서함</a></li>
						<li><a href="/eApproval/admin/privateList?type=view&cPage=1">참조 문서함</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</li>
	</ul>
</div>
<div class="addressListGroup">
	<ul class="privateList">
		<li class="toggleItem">
			<c:choose>
				<c:when test="${type eq 'appr'}">
					<h3 class="toggleTit active">문서 보관함</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/docuList?type=appr&cPage=1" class="active">업무 기안</a></li>
						<li><a href="/eApproval/admin/docuList?type=leave&cPage=1">휴가 신청서</a></li>
						<li><a href="/eApproval/admin/docuList?type=lateness&cPage=1">지각 사유서</a></li>
					</ul>
				</c:when>
				<c:when test="${type eq 'leave'}">
					<h3 class="toggleTit active">문서 보관함</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/docuList?type=appr&cPage=1">업무 기안</a></li>
						<li><a href="/eApproval/admin/docuList?type=leave&cPage=1" class="active">휴가 신청서</a></li>
						<li><a href="/eApproval/admin/docuList?type=lateness&cPage=1">지각 사유서</a></li>
					</ul>
				</c:when>
				<c:when test="${type eq 'lateness'}">
					<h3 class="toggleTit active">문서 보관함</h3>
					<ul class="subList active">
						<li><a href="/eApproval/admin/docuList?type=appr&cPage=1">업무 기안</a></li>
						<li><a href="/eApproval/admin/docuList?type=leave&cPage=1">휴가 신청서</a></li>
						<li><a href="/eApproval/admin/docuList?type=lateness&cPage=1" class="active">지각 사유서</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<h3 class="toggleTit">문서 보관함</h3>
					<ul class="subList">
						<li><a href="/eApproval/admin/docuList?type=appr&cPage=1">업무 기안</a></li>
						<li><a href="/eApproval/admin/docuList?type=leave&cPage=1">휴가 신청서</a></li>
						<li><a href="/eApproval/admin/docuList?type=lateness&cPage=1">지각 사유서</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</li>
	</ul>
</div>