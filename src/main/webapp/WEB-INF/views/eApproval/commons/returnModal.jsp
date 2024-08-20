<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="returnModal">
	<input type="hidden" value="${docuInfo.document_seq}" id="docuSeq">
	<div class="returnModalTitle">
		반려 코멘트 작성
		<span class="closeModal">X</span>
	</div>
	<div class="returnComm">
		<textarea id="returnComm" data-label="반려 코멘트" oninput='handleOnInput(this, 300)'></textarea>
	</div>
	<div class="modalBtnBox">
		<button class="red docuReturn">완료</button>
		<button class="grey closeModal">취소</button>
	</div>
</div>