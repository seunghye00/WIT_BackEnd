<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>휴가 신청서 문서 결재</title>
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
		<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp" %>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<a href="/eApproval/admin/home">
							<h2 class="sideTit">전자 결재</h2>
						</a>
					</div>
					<%@ include file="/WEB-INF/views/Admin/eApproval/commons/sideToggle.jsp"%>
				</div>
				<div class="sideContents eApprWrite eApprAppr">
					<div class="mainTitle">문서 결재 ( 휴가 신청서 )</div>
					<div class="document">
						<div class="choiBox">
							<%@ include file="/WEB-INF/views/eApproval/commons/docuBtnBox.jsp"%>
							<%@ include file="/WEB-INF/views/eApproval/commons/apprModal.jsp"%>
							<%@ include file="/WEB-INF/views/eApproval/commons/returnModal.jsp"%>
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
												<th>기안일</th>
												<td><fmt:formatDate value="${docuInfo.write_date}"
														pattern="yyyy-MM-dd HH:mm" /></td>
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
													<td><c:if test="${i.status eq '결재 완료'}">
															<img src="/img/icon/stamp.png" alt="approvedStamp">
															<br>
														</c:if> ${i.name}</td>
												</c:forEach>
											</tr>
											<tr>
												<th>결재일</th>
												<c:forEach items="${apprList}" var="i">
													<td><fmt:formatDate value="${i.approved_date}"
															pattern="yyyy-MM-dd HH:mm" /></td>
												</c:forEach>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="docuWrite docuRead docuLeave">
								<table>
									<thead>
										<tr>
											<th>휴가 종류</th>
											<td><select name="leave_type" id="leaveType" disabled>
													<option value="${docuDetail.leave_type}">${docuDetail.leave_type}</option>
											</select></td>
											<th>기간 및 일시</th>
											<td colspan="2"><input type="date" id="startLeaveDay"
												name="start_date" value="${docuDetail.start_date}" readonly>
												<span>~</span> <input type="date" id="endLeaveDay"
												name="end_date" value="${docuDetail.end_date}" readonly></td>
											<th>긴급</th>
											<td>
												<div>
													<input type="checkbox"
														<c:if test="${docuInfo.emer_yn eq 'Y'}">checked</c:if>
														disabled> <label for="emerCheck">긴급 문서</label>
												</div>
											</td>
										</tr>
										<tr>
											<th>반차 여부</th>
											<td colspan="2"><span> <input type="checkbox"
													id="startDay"
													<c:if test="${docuDetail.start_day_checked eq 'Y'}">checked</c:if>
													disabled> <label for="startDay">시작일</label>
											</span> ( <span> <input type="checkbox" id="startDayAM"
													<c:if test="${docuDetail.start_day_am_checked eq 'Y'}">checked</c:if>
													disabled> <label for="startDayAM">오전</label>
											</span> <span> <input type="checkbox" id="startDayPM"
													<c:if test="${docuDetail.start_day_pm_checked eq 'Y'}">checked</c:if>
													disabled> <label for="startDayPM">오후</label>
											</span> ) <br> <span> <input type="checkbox" id="endDay"
													<c:if test="${docuDetail.end_day_checked eq 'Y'}">checked</c:if>
													disabled> <label for="endDay">종료일</label>
											</span> ( <span> <input type="checkbox" id="endDayAM"
													<c:if test="${docuDetail.end_day_am_checked eq 'Y'}">checked</c:if>
													disabled> <label for="endDayAM">오전</label>
											</span> <span> <input type="checkbox" id="endDayPM"
													<c:if test="${docuDetail.end_day_pm_checked eq 'Y'}">checked</c:if>
													disabled> <label for="endDayPM">오후</label>
											</span> )</td>
											<th>연차 일수</th>
											<td colspan="3"><span> 잔여 연차 :&nbsp;&nbsp; <input
													class="readOnly" type="text" value="${remaingLeaves}"
													id="remainingLeaves" readonly>
											</span> <span> 신청 연차 :&nbsp;&nbsp; <input type="text"
													id="applyLeaves" class="readOnly"
													value="${docuDetail.request_leave_days}" readonly>
											</span></td>
										</tr>
										<tr>
											<th>제목</th>
											<td colspan="6"><input type="text"
												value="${docuInfo.title}" readonly></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>휴가 사유</th>
											<td colspan="6"><textarea readonly>${docuDetail.reason}</textarea></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="docuFiles">
								<label class="disabled">🔗 파일 목록</label> 
								<span class="uploadFiles">
								<c:if test="${!empty files}">
									<c:forEach items="${files}" var="i">
										<a href="/eApproval/downloadFiles?fileSeq=${i.document_files_seq}">
    										<span>${i.oriname}</span>
										</a>
									</c:forEach>
								</c:if>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>