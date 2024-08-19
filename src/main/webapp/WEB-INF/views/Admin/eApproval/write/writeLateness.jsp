<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>지각 사유서 문서 작성</title>
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
						<a href="/eApproval/home">
							<h2 class="sideTit">전자 결재</h2>
						</a>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn disabled">새 결재 진행</button>
					</div>
					<%@ include file="/WEB-INF/views/eApproval/commons/sideToggle.jsp"%>
				</div>
				<div class="sideContents eApprWrite">
					<div class="mainTitle">문서 작성 ( 지각 사유서 )</div>
					<input type="hidden" name="document_seq" value="${docuSeq}">
					<div class="document">
						<div class="choiBox">
							<button class="ok latenessWrite" type="button">결재 요청</button>
							<button class="green docuSaveBtn docuLatenessSave" type="button">임시
								저장</button>
							<button class="red cancelWrite" type="button">취소</button>
							<button class="purple refeBtn" type="button">참조선</button>
							<%@ include file="/WEB-INF/views/eApproval/commons/refeModal.jsp"%>
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
												<td>${docuSeq}</td>
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
							<div class="docuWrite docuLateness">
								<form id="docuContForm">
									<input type="hidden" name="docu_code" value="M3">
									<table>
										<thead>
											<tr>
												<th>지각 일자</th>
												<td><input type="date" max="${today}" value="${today}" id="lateDay" name="late_date"></td>
												<th>긴급</th>
												<td>
													<div>
														<input type="hidden" id="emerChecked" name="emer_yn" value="N">
														<input type="checkbox" id="emerCheck"> 
														<label for="emerCheck">긴급 문서</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="3"><input type="text" name="title"
													id="writeDocuTitle" oninput='handleOnInput(this, 33)'
													data-label="문서 제목"></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>지각 사유</th>
												<td colspan="3"><textarea name="reason" id="reason" oninput='handleOnInput(this, 1333)'
														data-label="문서 내용"></textarea></td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
							<div class="docuFiles">
								<label for="file">🔗 파일 선택</label> 
								<input type="file" id="file" name="file" multiple> 
								<span class="uploadFiles"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>