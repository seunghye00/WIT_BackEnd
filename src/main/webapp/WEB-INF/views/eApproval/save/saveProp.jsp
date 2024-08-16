<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>업무 기안 문서 ( 임시 저장 )</title>
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
						<button class="plusBtn sideBtn" id="startApprBtn">새 결재 진행</button>
						<%@ include file="/WEB-INF/views/eApproval/commons/newWriteModal.jsp" %>
					</div>
					<%@ include file="/WEB-INF/views/eApproval/commons/sideToggle.jsp"%>
				</div>
				<div class="sideContents eApprWrite">
					<div class="mainTitle">임시 저장 문서 ( 업무 기안 )</div>
					<div class="document">
						<div class="choiBox">
							<button class="propUpdate" type="button">결재 요청</button>
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
							<div class="docuWrite docuProp">
								<form id="docuContForm" action="/eApproval/update" method="post">
									<input type="hidden" name="docu_code" value="M1">
									<input type="hidden" name="document_seq" value="${docuInfo.document_seq}" id="docuSeq">
									<table>
										<thead>
											<tr>
												<th>시행일자</th>
												<td><input type="date" id="effDate" min="${today}"
													value="${docuDetail.eff_date}" name="eff_date"></td>
												<th>협조부서</th>
												<td><input type="text" name="dept_title" id="collaboDept" oninput='handleOnInput(this, 20)' value="${docuDetail.dept_title}"
													data-label="협조 부서"></td>
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
												<th>제목</th>
												<td colspan="5"><input type="text" name="title"
													id="writeDocuTitle" oninput='handleOnInput(this, 33)'
													data-label="문서 제목" value="${docuInfo.title}"></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="6"><textarea name="contents"
														id="writeDocuConts" oninput='handleOnInput(this, 1333)'
														data-label="문서 내용">${docuDetail.contents}</textarea></td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
							<form id="fileInputForm" action="/eApproval/uploadFiles" method="post"
								enctype="multipart/form-data">
								<div class="docuFiles">
									<label for="file">🔗 파일 선택</label> <input type="file" id="file" name="file"
										multiple> <span class="uploadFiles"></span>
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