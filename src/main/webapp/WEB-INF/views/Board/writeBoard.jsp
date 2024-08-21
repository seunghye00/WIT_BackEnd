<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>글 작성</title>
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
			<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
				integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
				crossorigin="anonymous" referrerpolicy="no-referrer" />
			<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
			<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
			<link rel="stylesheet" href="/css/style.main.css">
			<link rel="stylesheet" href="/css/wit.css">
			<script src="/js/boards.js"></script>
		</head>

		<body>
			<div id="container">
				<%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>
					<!-- 공통영역 끝 -->

					<div class="main-content">
						<%@ include file="/WEB-INF/views/Includes/header.jsp" %>
							<div class="contents">
								<div class="sideAbout">
									<div class="sideTxt">
										<h2 class="sideTit">게시판</h2>
									</div>
									<div class="sideBtnBox">
										<button id="writeBtn" class="plusBtn sideBtn">자유 게시판 글 작성</button>
									</div>

									<div class="addressListGroup">
										<ul class="GroupList">
											<li class="toggleItem">
												<h3 class="toggleTit">
													자유 게시판
												</h3>
												<ul class="subList">
													<li><a href="/board/list?bookmark=true">북마크한 게시물</a></li>
													<li><a href="/board/list?report=true">신고한 게시물</a></li>
													<li><a href="/board/list">자유 게시판으로 이동</a></li>
												</ul>
											</li>
										</ul>
									</div>

									<div class="addressListGroup">
										<ul class="GroupList">
											<li class="toggleItem">
												<h3 class="toggleTit">
													공지 사항
												</h3>
												<ul class="subList">
													<li><a href="/board/list?bookmark=true&boardCode=2">북마크한 게시물</a>
													</li>

													<li><a href="/board/list?boardCode=2">공지 사항으로 이동</a></li>

													<c:if test="${employee.role_code == '사장'}">
														<li><a href="/board/write?boardCode=2">공지 사항 글 작성</a></li>
													</c:if>
												</ul>
											</li>
										</ul>
									</div>
									<c:if test="${employee.role_code == '사장'}">
										<div class="addressListGroup">
											<ul class="GroupList">
												<li class="toggleItem">
													<h3 class="reportList">
														신고 현황
													</h3>
												</li>
											</ul>
										</div>
									</c:if>
								</div>

								<div class="sideContents board">
									<form action="/board/writeProc" method="post" enctype="multipart/form-data"
										id="submitForm">
										<input type="hidden" name="contents" id="contents">
										<input type="hidden" name="boardCode" value="${board_code}">
										<div class="mainTitle">글 작성</div>
										<div class="writeWrapper">
											<input class="writeTitle" placeholder="제목을 입력하세요." name="title"></input>
											<div class="writeCont">
												<div id="summernote"></div>
											</div>
											<div class="docuFiles">
												<label for="file">🔗 파일 선택</label> <input type="file" id="file" multiple
													name="files"> <span class="uploadFiles"></span>
											</div>
											<div class="writeBtns">
												<button type="button" class="btn btn-secondary" id="writeList"
													onclick="location.href='/board/list'">뒤로가기</button>
												<button type="submit" class="btn btn-primary"
													id="writeInsert">등록하기</button>
											</div>
										</div>
									</form>
								</div>
							</div>
					</div>
			</div>
			<script>
				var filesLength = ${ filesSize };
				let defaultFileLength = ${ filesSize };

				// 주소록 토글 이벤트 설정
				const toggleItems = document.querySelectorAll('.toggleItem')
				toggleItems.forEach(function (toggleItem) {
					const toggleTit = toggleItem.querySelector('.toggleTit')
					const subList = toggleItem.querySelector('.subList')

					$(toggleTit).on('click', function () {
						subList.classList.toggle('active')
						toggleTit.classList.toggle('active') // 이미지 회전을 위해 클래스 추가
					})
				})

				// 신고현황 클릭 시
				$(".reportList").on("click", function () {
					window.location.href = "/board/list?adminReport=true";
				});
			</script>
		</body>

		</html>