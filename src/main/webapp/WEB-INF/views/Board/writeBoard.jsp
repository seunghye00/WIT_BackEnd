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
				<div class="sideBar">
					<div class="top">
						<i class="bx bx-menu" id="btn"></i>
					</div>
					<div class="user">
						<img src="/resources/img/WIT_logo1.png" alt="로고" class="userImg">
						<div class="nickName">
							<p class="bold">Wit Works</p>
							<p></p>
						</div>
					</div>

					<ul>
						<li><a href="/"> <i class='bx bxs-home-alt-2'></i> <span class="navItem">홈</span></a> <span
								class="toolTip">홈</span></li>
						<li><a href="#"> <i class='bx bx-paperclip'></i> <span class="navItem">주소록</span></a> <span
								class="toolTip">주소록</span></li>
						<li><a href="/board/list"> <i class="bx bxs-grid-alt"></i>
								<span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
						<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a> <span
								class="toolTip">캘린더</span></li>
						<li><a href="#"> <i class='bx bxs-message-dots'></i> <span class="navItem">메신저</span></a> <span
								class="toolTip">메신저</span></li>
						<li><a href="#"> <i class='bx bx-clipboard'></i> <span class="navItem">전자결재</span></a> <span
								class="toolTip">전자결재</span></li>
						<li><a href="/attendance/attendance"> <i class='bx bxs-briefcase-alt-2'></i> <span
									class="navItem">근태관리</span></a>
							<span class="toolTip">근태관리</span>
						</li>
						<li><a href="#"> <i class='bx bxs-check-square'></i> <span class="navItem">예약</span></a> <span
								class="toolTip">예약</span></li>
						<li><a href="#"> <i class='bx bx-sitemap'></i> <span class="navItem">조직도</span></a> <span
								class="toolTip">조직도</span></li>
					</ul>
				</div>
				<!-- 공통영역 끝 -->

				<div class="main-content">
					<div class="header">
						<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
						<!--마이페이지로 이동-->
						<span class="myName"> <img src="/resources/img/푸바오.png" alt="프로필 사진" class="userImg"> <a
								href="/employee/mypage">${employee.name}
								${employee.role_code}</a>
						</span> <span class="logOut"><a href="/employee/logout">LogOut</a></span>
					</div>
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
											<li><a href="/board/list?bookmark=true&boardCode=2">북마크한 게시물</a></li>
											<li><a href="/board/list?boardCode=2">공지 사항으로 이동</a></li>
										</ul>
									</li>
								</ul>
							</div>

							<!-- <div class="addressListPrivate">
																<ul class="privateList">
																	<li class="toggleItem">
																		<h3 class="toggleTit active">
																			<a href="/board/list">
																				<h3 class="sideTit">
																					자유 게시판
																				</h3>
																			</a>
																			<ul class="subList actice">
																				<li class="newList"><a href="/board/list?boardCode=2">공지 사항</a></li>
																			</ul>
																		</h3>
							
																	</li>
																</ul>
															</div> -->

							<!-- <div class="addressListGroup">
																<ul class="GroupList">
																	<li class="toggleItem">
																		<h3 class="toggle">
																			<a href="/board/list?bookmark=true">북마크한 게시물</a>
																		</h3>
																	</li>
																</ul>
															</div> -->
							<!-- <div class="addressListGroup">
																<ul class="GroupList">
																	<li class="toggleItem">
																		<h3 class="toggle">
																			<a href="/board/list?report=true">신고한 게시물</a>
																		</h3>
																	</li>
																</ul>
															</div> -->
						</div>

						<div class="sideContents board">
							<form action="/board/writeProc" method="post" enctype="multipart/form-data" id="submitForm">
								<input type="hidden" name="contents" id="contents">
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
										<button type="submit" class="btn btn-primary" id="writeInsert">등록하기</button>
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
			</script>
		</body>

		</html>