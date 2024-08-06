<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script defer src="/js/hsh.js"></script>
</head>
<body>
	<!-- 공통영역 -->
	<div class="container">
		<div class="sideBar">
			<div class="top">
				<i class="bx bx-menu" id="btn"></i>
			</div>
			<div class="user">
				<img src="메인게임.webp" alt="me" class="userImg">
				<div class="nickName">
					<p class="bold">Wit Works</p>
					<p></p>
				</div>
			</div>

			<ul>
				<li><a href="#"> <i class='bx bxs-home-alt-2'></i> <span
						class="navItem">홈</span>
				</a> <span class="toolTip">홈</span></li>
				<li><a href="#"> <i class='bx bx-paperclip'></i> <span
						class="navItem">주소록</span>
				</a> <span class="toolTip">주소록</span></li>
				<li><a href="board2.html"> <i class="bx bxs-grid-alt"></i>
						<span class="navItem">게시판</span>
				</a> <span class="toolTip">게시판</span></li>
				<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span
						class="navItem">캘린더</span>
				</a> <span class="toolTip">캘린더</span></li>
				<li><a href="#"> <i class='bx bxs-message-dots'></i> <span
						class="navItem">메신저</span>
				</a> <span class="toolTip">메신저</span></li>
				<li><a href="#"> <i class='bx bx-clipboard'></i> <span
						class="navItem">전자결재</span>
				</a> <span class="toolTip">전자결재</span></li>
				<li><a href="#"> <i class='bx bxs-briefcase-alt-2'></i> <span
						class="navItem">근태관리</span>
				</a> <span class="toolTip">근태관리</span></li>
				<li><a href="#"> <i class='bx bxs-check-square'></i> <span
						class="navItem">예약</span>
				</a> <span class="toolTip">예약</span></li>
				<li><a href="#"> <i class='bx bx-sitemap'></i> <span
						class="navItem">조직도</span>
				</a> <span class="toolTip">조직도</span></li>

			</ul>
		</div>
		<!-- 공통역역 끝 -->

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<!--마이페이지로 이동-->
				<span class="myName"> <img src="메인게임.webp"><a href=" #">백민주
						사원</a></span> <span class="logOut"><a href="#">LogOut</a></span>
			</div>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">전자 결재</h2>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn disabled">새 결재 진행</button>
					</div>
					<div class="addressListPrivate">
						<ul class="privateList">
							<li class="toggleItem">
								<h3 class="toggleTit">결재하기</h3>
								<ul class="subList">
									<li><a href="javascript:;">결재 대기 문서</a></li>
									<li><a href="javascript:;">결재 수신 문서</a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="addressListGroup">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggleTit">개인 문서함</h3>
								<ul class="subList">
									<li><a href="javascript:;">기안 문서함</a></li>
									<li><a href="javascript:;">임시 저장함</a></li>
									<li><a href="javascript:;">결재 문서함</a></li>
									<li><a href="javascript:;">참조 문서함</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div class="sideContents eApprWrite">
					<form id="docuWriteForm" action="/eApproval/docuProp/write" method="post">
						<div class="mainTitle">문서 작성 ( 업무 기안 )</div>
						<input type="hidden" name="document_seq" value="${docuSeq}">
						<input type="hidden" name="docu_code" value="${docuCode}">
						<div class="document">
							<div class="choiBox">
								<button class="ok" type="button">결재 요청</button>
								<button class="green propSave" type="button">임시 저장</button>
								<button class="red cancelWrite" type="button">취소</button>
								<button class="grey refeBtn" type="button">참조선</button>
								<div class="refeModal">
									<ul>
										<c:choose>
											<c:when test="${refeList != NULL}">
												<c:forEach items="${refeList}" var="i">
												<c:set var="refeInfo" value="${fn:split(i, ' ')}" />
													<li>${refeInfo[1]} ${refeInfo[2]}</li>
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
														<td>${apprInfo[1]}
															<input type="hidden" name="apprList" value="${apprInfo[0]}">														
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
								<div class="docuWrite docuProp">
									<table>
										<thead>
											<tr>
												<th>시행일자</th>
												<td><input type="date" id="impleDate" min="${today}"
													value="${today}" name="eff_date"></td>
												<th>협조부서</th>
												<td><input type="text" id="collaboDept" name="dept_title"></td>
												<th>긴급</th>
												<td>
													<div>
														<input type="checkbox" id="emerCheck" value="Y" name="emer_yn"> 
														<label for="emerCheck">긴급 문서</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="5"><input type="text" id="title" name="title">
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="6"><textarea name="contents" id=""></textarea></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="docuFiles">
									<label for="file">🔗 파일 선택</label> <input type="file" id="file"
										multiple> <span class="uploadFiles"></span>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>