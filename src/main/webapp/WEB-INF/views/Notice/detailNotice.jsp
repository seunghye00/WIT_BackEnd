<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시판 상세</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="/resources/js/boards.js"></script>
</head>
<body>
	<div id="container">
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<!-- 공통영역 끝 -->
		<div class="main-content">

			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">게시판</h2>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn">글 작성</button>
					</div>
					<div class="addressListPrivate">
						<ul class="privateList">
							<li class="toggleItem">
								<h3 class="toggle">
									<a href="board.html">공지사항</a>
								</h3>

							</li>
						</ul>
					</div>
					<div class="addressListGroup">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggle">
									<a href="free_board.html">자유 게시판</a>
								</h3>

							</li>
						</ul>
					</div>
				</div>
				<div class="sideContents board">
					<div class="mainTitle">공지사항 상세</div>
					<div class="boardDetail">
						<div class="detail">
							<div class="detailTop">
								<div class="top">
									<div class="topTitle">[공지] 집에 가고 싶어요 춥고 배고파요</div>
									<div class="topFile">
										<i class='bx bx-file-blank'></i>
									</div>
								</div>
								<div class="top">
									<span>백민주</span> <span>2024-07-28</span> <span><i
										class="fa-regular fa-eye"></i> 300</span>
								</div>
							</div>
							<div class="detailCen">게시판 글 내용 영역입니다.</div>
							<div class="detailBott">
								<button type="button" class="btn btn-outline-success"
									id="boardUpd">수정</button>
								<button type="button" class="btn btn-outline-success"
									id="boardDel">삭제</button>
								
								<button type="button" class="btn btn-outline-primary"
									id="boardList" onclick="location.href='/notice/notice'">목록으로</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>