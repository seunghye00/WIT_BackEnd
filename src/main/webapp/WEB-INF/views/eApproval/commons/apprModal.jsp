<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="apprModal">
	<input type="hidden" value="${docuInfo.document_seq}" id="docuSeq">
	<div class="apprModalTitle">
		결재 코멘트 작성 
		<span class="closeModal">X</span>
	</div>
	<div class="apprComm">
		<textarea id="apprComm" data-label="결재 코멘트" oninput='handleOnInput(this, 300)'></textarea>
	</div>
	<div class="modalBtnBox">
		<button class="docuAppr" type="button">결재</button>
		<button class="green docuAllAppr" type="button">전결</button>
		<button class="grey closeModal" type="button">취소</button>
	</div>
</div>