<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modalBack" id="commModalBack">
	<div class="commModal">
		<div class="commModalTitle">코멘트 목록</div>
		<div class="commList">
			<c:forEach items="${apprList}" var="i">
				<div class="apprList">
					<div class="approver">${i.name}${i.role_title}</div>
					<div class="comm">${i.comments}</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>