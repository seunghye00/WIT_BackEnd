<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>지각 사유서 문서 결재</title>
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
					<div class="mainTitle">문서 작성 ( 지각 사유서 )</div>
					<input type="hidden" name="document_seq" value="${docuSeq}">
					<div class="document">
						<div class="choiBox">
							<button class="ok" type="button">결재</button>
							<button class="red" type="button">반려</button>
							<button class="grey" type="button">목록</button>
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
							<div class="docuWrite docuRead docuLateness">
								<form id="docuContForm">
									<table>
										<thead>
											<tr>
												<th>지각 일자</th>
												<td><input type="date" value="${docuDetail.late_date}" readonly></td>
												<th>긴급</th>
												<td>
													<div>
														<input type="checkbox" <c:if test="${docuInfo.emer_yn eq 'Y'}">checked</c:if> disabled> <label for="emerCheck">긴급 문서</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="3"><input type="text" value="${docuInfo.title}" readonly></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th>지각 사유</th>
												<td colspan="3"><textarea readonly>${docuDetail.reason}</textarea></td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
							<div class="docuFiles">
									<label>🔗 파일 목록</label> <span class="uploadFiles"></span>
								</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>