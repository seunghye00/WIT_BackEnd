<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>지각 사유서 문서 ( 임시 저장 )</title>
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
						<a href="/eApproval/home">
							<h2 class="sideTit">전자 결재</h2>
						</a>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn disabled">새 결재 진행</button>
						<%@ include file="/WEB-INF/views/eApproval/commons/newWriteModal.jsp" %>
					</div>
					<%@ include file="/WEB-INF/views/eApproval/commons/sideToggle.jsp"%>
				</div>
				<div class="sideContents eApprWrite">
					<div class="mainTitle">임시 저장 문서 ( 지각 사유서 )</div>
					<div class="document">
						<div class="choiBox">
							<button class="latenessUpdate" type="button">결재 요청</button>
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
												<th>기안일</th>
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
							<div class="docuWrite docuLateness">
								<form id="docuContForm">
									<input type="hidden" name="docu_code" value="M3">
									<table>
										<thead>
											<tr>
												<th>지각 일자</th>
												<td><input type="date" value="${docuDetail.late_date}" max="${today}" id="lateDay" name="late_date"></td>
												<th>긴급</th>
												<td>
													<div>
														<input type="checkbox" id="emerCheck" value="Y"
															name="emer_yn" <c:if test="${docuInfo.emer_yn eq 'Y'}">checked</c:if>> <label for="emerCheck">긴급 문서</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="3"><input type="text" name="title"
													id="writeDocuTitle" oninput='handleOnInput(this, 33)'
													data-label="문서 제목" value="${docuInfo.title}"></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>지각 사유</th>
												<td colspan="3"><textarea name="reason" id="reason" oninput='handleOnInput(this, 1333)'
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