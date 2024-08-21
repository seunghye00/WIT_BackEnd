<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form id="addVehicleForm" action="/reservation/admin/add?target=vehicle" method="post">
<div id="addVehicleModal" class="addTargetModal">
	<h1>
		차량 추가<span class="closeModal">&times</span>
	</h1>
	<div class="addTargetInfo">
		<ul>
			<li><span>차량 명</span>
				<div>
					<input type="text" name="name" id="name" data-label="차량 명" oninput='handleOnInput(this, 10)'>
				</div></li>
			<li><span>차량 번호</span>
				<div>
					<input type="number" name="license_plate" id="license_plate" min="1000" max="9999">
				</div></li>
			<li><span>예약 안내</span>
				<div>
					<textarea name="guidelines"></textarea>
				</div></li>
			<li>
				<div class="btns">
					<button id="addVehicle" type="button">완료</button>
					<button class="red closeModal" type="button">취소</button>
				</div>
			</li>
		</ul>
	</div>
</div>
</form>