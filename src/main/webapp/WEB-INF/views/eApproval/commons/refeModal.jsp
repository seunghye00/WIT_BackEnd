<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="refeModal">
	<ul>
		<c:choose>
			<c:when test="${refeList != NULL}">
				<c:forEach items="${refeList}" var="i">
					<c:set var="refeInfo" value="${fn:split(i, ' ')}" />
					<li>${refeInfo[1]}${refeInfo[2]}</li>
					<input type="hidden" name="refeList" value="${refeInfo[0]}">
				</c:forEach>
			</c:when>
			<c:otherwise>
				<li>참조선 없음</li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>