<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>휴가 신청서 작성</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script defer src="/js/hsh.js"></script>
<script defer src="/js/wit.js"></script>
</head>

<body>
	<div class="container">
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">전자 결재</h2>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn disabled">새 결재 진행</button>
					</div>
					<%@ include file="/WEB-INF/views/eApproval/commons/sideToggle.jsp"%>
				</div>
				<div class="sideContents eApprWrite">
					<div class="mainTitle">문서 작성 ( 휴가 신청서 )</div>
					<div class="document">
						<div class="choiBox">
							<button class="ok leaveWrite" type="button">결재 요청</button>
							<button class="green docuSaveBtn docuLeaveSave" type="button">임시
								저장</button>
							<button class="red cancelWrite" type="button">취소</button>
							<button class="grey refeBtn" type="button">참조선</button>
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
						</div>
						<div class="docuCont">
							<div class="docuInfo">
								<div class="infoTable">
									<table>
										<tbody>
											<tr>
												<th>기안자</th>
												<td>${empInfo.name}</td>
											</tr>
											<tr>
												<th>소속</th>
												<td>${empInfo.dept_title}</td>
											</tr>
											<tr>
												<th>기안일</th>
												<td>${today}</td>
											</tr>
											<tr>
												<th>문서번호</th>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="apprTable">
									<table>
										<thead>
											<tr>
												<th>결재 순서</th>
												<th>최초</th>
												<th>중간</th>
												<th>최종</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>직급</th>
												<c:forEach items="${apprList}" var="i">
													<c:set var="apprInfo" value="${fn:split(i, ' ')}" />
													<td>${apprInfo[2]}</td>
												</c:forEach>
											</tr>
											<tr>
												<th>결재자</th>
												<c:forEach items="${apprList}" var="i">
													<c:set var="apprInfo" value="${fn:split(i, ' ')}" />
													<td>${apprInfo[1]}<input type="hidden" name="apprList"
														value="${apprInfo[0]}">
													</td>
												</c:forEach>
											</tr>
											<tr>
												<th>결재일</th>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="docuWrite docuLeave">
								<form id="docuContForm">
									<input type="hidden" name="docu_code" value="M2">
									<table>
										<thead>
											<tr>
												<th>휴가 종류</th>
												<td><select name="leave_type" id="leaveType">
														<option value="1">연차</option>
														<option value="2">지각</option>
														<option value="3">조퇴</option>
														<option value="4">경조사</option>
														<option value="5">병가</option>
												</select></td>
												<th>기간 및 일시</th>
												<td colspan="2"><input type="date" id="startLeaveDay" name="start_date" min="${today}"> <span>~</span>
													<input type="date" id="endLeaveDay" name="end_date" min="${today}"></td>
												<th>긴급</th>
												<td>
													<div>
														<input type="checkbox" id="emerCheck" value="Y"
															name="emer_yn"> <label for="emerCheck">긴급
															문서</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>반차 여부</th>
												<td colspan="2"><span> <input type="checkbox"
														id="startDay"> <label for="startDay">시작일</label>
												</span> ( <span><input type="checkbox" id="startDayAM">
														<label for="startDayAM">오전</label></span> <span><input
														type="checkbox" id="startDayPM"> <label
														for="startDayPM">오후</label></span> ) <br> <span> <input
														type="checkbox" id="endDay"> <label for="endDay">종료일</label>
												</span> ( <span><input type="checkbox" id="endDayAM">
														<label for="endDayAM">오전</label></span> <span><input
														type="checkbox" id="endDayPM"> <label
														for="endDayPM">오후</label></span> )</td>
												<th>연차 일수</th>
												<td colspan="3"><span> 잔여 연차 :&nbsp;&nbsp;<input class="readOnly"
														type="text" value="${remaingLeaves}" readonly>
												</span> <span> 신청 연차 :&nbsp;&nbsp;<input type="text" class="readOnly"
														readonly>
												</span></td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="6"><input type="text" name="title"
													id="writeDocuTitle" oninput='handleOnInput(this, 33)'
													data-label="문서 제목"></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>휴가 사유</th>
												<td colspan="6"><textarea name="reason" id="reason" oninput='handleOnInput(this, 1333)'
														data-label="문서 내용"></textarea></td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
							<form id="fileInputForm" action="/eApproval/uploadFiles"
								method="post" enctype="multipart/form-data">
								<div class="docuFiles">
									<label for="file">🔗 파일 선택</label> <input type="file" id="file"
										name="file" multiple> <span class="uploadFiles"></span>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>