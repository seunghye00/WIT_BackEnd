<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>휴가 신청서 문서 ( 임시 저장 )</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script defer src="/js/hsh.js"></script>
<script defer src="/js/file.js"></script>
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
						<button class="plusBtn sideBtn"  id="startApprBtn">새 결재 진행</button>
						<%@ include file="/WEB-INF/views/eApproval/commons/newWriteModal.jsp" %>
					</div>
					<%@ include file="/WEB-INF/views/eApproval/commons/sideToggle.jsp"%>
				</div>
				<div class="sideContents eApprWrite eApprSaved">
					<div class="mainTitle">임시 저장 문서 ( 휴가 신청서 )</div>
					<div class="document">
						<div class="choiBox">
							<button class="leaveUpdate" type="button">결재 요청</button>
							<%@ include file="/WEB-INF/views/eApproval/commons/docuBtnBox.jsp"%>
							<%@ include file="/WEB-INF/views/eApproval/commons/refeModal.jsp"%>
						</div>
						<div class="docuCont">
							<div class="docuInfo">
								<div class="infoTable">
									<table>
										<tbody>
											<tr>
												<th>기안자</th>
												<td>${writerInfo.name}</td>
											</tr>
											<tr>
												<th>소속</th>
												<td>${writerInfo.dept_title}</td>
											</tr>
											<tr>
												<th>작성일</th>
												<td>
													<fmt:formatDate value="${docuInfo.write_date}" pattern="yyyy-MM-dd HH:mm" />
												</td>
											</tr>
											<tr>
												<th>문서번호</th>
												<td>${docuInfo.document_seq}</td>
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
													<td>${i.role_title}</td>
												</c:forEach>
											</tr>
											<tr>
												<th>결재자</th>
												<c:forEach items="${apprList}" var="i">
													<td>
														<c:if test="${i.status eq '결재 완료'}">
															<img src="/img/icon/stamp.png" alt="approvedStamp"><br>
														</c:if>
														${i.name}
													</td>
												</c:forEach>
											</tr>
											<tr>
												<th>결재일</th>
												<c:forEach items="${apprList}" var="i">
													<td>
														<fmt:formatDate value="${i.approved_date}" pattern="yyyy-MM-dd HH:mm" />
													</td>
												</c:forEach>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="docuWrite docuLeave">
								<form id="docuContForm" action="/eApproval/update" method="post">
									<input type="hidden" name="docu_code" id="docuCode" value="M2">
									<input type="hidden" name="document_seq" value="${docuInfo.document_seq}" id="docuSeq">
									<table>
										<thead>
											<tr>
												<th>휴가 종류</th>
												<td><select name="leave_type" id="leaveType">
														<option value="연차">연차</option>
														<option value="지각">지각</option>
														<option value="조퇴">조퇴</option>
														<option value="경조사">경조사</option>
														<option value="병가">병가</option>
														<option value="공가">공가</option>
													</select>
												<th>기간 및 일시</th>
												<td colspan="2"><input type="date" id="startLeaveDay"
													name="startDate" min="${today}" value="${docuDetail.start_date}">
													<span>~</span> <input type="date" id="endLeaveDay"
													name="endDate" min="${today}" value="${docuDetail.end_date}"></td>
												<th>긴급</th>
												<td>
													<div>
														<input type="hidden" id="emerChecked" name="emer_yn" value="N">
														<input type="checkbox" id="emerCheck" <c:if test="${docuInfo.emer_yn eq 'Y'}">checked</c:if>> 
														<label for="emerCheck">긴급 문서</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>반차 여부</th>
												<td colspan="2">
                                                	<span>
                                                		<input type="checkbox" id="startDay" <c:if test="${docuDetail.start_day_checked eq 'Y'}">checked</c:if>>
                                                		<input type="hidden" id="startDayChecked" name="start_day_checked" value="Y"> 
                                                		<label for="startDay">시작일</label>
													</span> ( 
													<span>
														<input type="checkbox" id="startDayAM" <c:if test="${docuDetail.start_day_am_checked eq 'Y'}">checked</c:if>>
														<input type="hidden" id="startDayAMChecked" name="start_day_am_checked" value="Y">
														<label for="startDayAM">오전</label>
													</span> 
													<span>
														<input type="checkbox" id="startDayPM" <c:if test="${docuDetail.start_day_pm_checked eq 'Y'}">checked</c:if>>
														<input type="hidden" id="startDayPMChecked" name="start_day_pm_checked" value="Y"> 
														<label for="startDayPM">오후</label>
													</span> ) <br> 
													<span> 
														<input type="checkbox" id="endDay" <c:if test="${docuDetail.end_day_checked eq 'Y'}">checked</c:if>>
														<input type="hidden" id="endDayChecked" name="end_day_checked" value="Y"> 
														<label for="endDay">종료일</label>
													</span> ( 
													<span>
														<input type="checkbox" id="endDayAM" <c:if test="${docuDetail.end_day_am_checked eq 'Y'}">checked</c:if>>
														<input type="hidden" id="endDayAMChecked" name="end_day_am_checked" value="Y">
														<label for="endDayAM">오전</label>
													</span> 
													<span>
														<input type="checkbox" id="endDayPM" <c:if test="${docuDetail.end_day_pm_checked eq 'Y'}">checked</c:if>>
														<input type="hidden" id="endDayPMChecked" name="end_day_pm_checked" value="Y"> 
														<label for="endDayPM">오후</label>
													</span> )
												</td>
												<th>연차 일수</th>
												<td colspan="3">
													<span> 잔여 연차 :&nbsp;&nbsp; <input
													class="readOnly" type="text" value="${remaingLeaves}"
													id="remainingLeaves" readonly>
													</span> <span> 신청 연차 :&nbsp;&nbsp; <input type="text"
													id="applyLeaves" class="readOnly" name="request_leave_days"
													value="${docuDetail.request_leave_days}" readonly>
													</span>
											</td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="6"><input type="text" name="title"
													id="writeDocuTitle" value="${docuInfo.title}" oninput='handleOnInput(this, 33)'
													data-label="문서 제목"></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>휴가 사유</th>
												<td colspan="6"><textarea name="reason" id="reason" oninput='handleOnInput(this, 1333)'
														data-label="문서 내용">${docuDetail.reason}</textarea></td>
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