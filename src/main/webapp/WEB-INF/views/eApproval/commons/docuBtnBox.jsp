<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${type eq 'saved'}">
		<button class="green docuReSaveBtn" type="button">임시 저장</button>
		<button class="red delDocu" type="button">삭제</button>
		<button class="grey" type="button">목록</button>
		<button class="purple refeBtn" type="button">참조선</button>
	</c:when>
	<c:when test="${type eq 'toAppr'}">
		<button class="ok" type="button">결재</button>
		<button class="red" type="button">반려</button>
		<button class="grey" type="button">목록</button>
		<button class="purple refeBtn" type="button">참조선</button>
	</c:when>
	<c:otherwise>
		<button class="green" type="button">코멘트</button>
		<button class="grey" type="button">목록</button>
		<button class="purple refeBtn" type="button">참조선</button>
	</c:otherwise>
</c:choose>