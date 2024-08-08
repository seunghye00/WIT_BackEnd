<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>글 작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">

<script src="/resources/js/writeBoard.js"></script>
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
				<li><a href="/employee/main"> <i class='bx bxs-home-alt-2'></i> <span
						class="navItem">홈</span></a> <span class="toolTip">홈</span></li>
				<li><a href="#"> <i class='bx bx-paperclip'></i> <span
						class="navItem">주소록</span></a> <span class="toolTip">주소록</span></li>
				<li><a href="/board/list"> <i class="bx bxs-grid-alt"></i>
						<span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
				<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span
						class="navItem">캘린더</span></a> <span class="toolTip">캘린더</span></li>
				<li><a href="#"> <i class='bx bxs-message-dots'></i> <span
						class="navItem">메신저</span></a> <span class="toolTip">메신저</span></li>
				<li><a href="#"> <i class='bx bx-clipboard'></i> <span
						class="navItem">전자결재</span></a> <span class="toolTip">전자결재</span></li>
				<li><a href="/attendance/attendance"> <i
						class='bx bxs-briefcase-alt-2'></i> <span class="navItem">근태관리</span></a>
					<span class="toolTip">근태관리</span></li>
				<li><a href="#"> <i class='bx bxs-check-square'></i> <span
						class="navItem">예약</span></a> <span class="toolTip">예약</span></li>
				<li><a href="#"> <i class='bx bx-sitemap'></i> <span
						class="navItem">조직도</span></a> <span class="toolTip">조직도</span></li>
			</ul>
		</div>
		<!-- 공통영역 끝 -->

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<!--마이페이지로 이동-->
				<span class="myName"> <img src="/resources/img/푸바오.png"
					alt="프로필 사진" class="userImg"> <a href="/employee/mypage">${employee.name}
						${employee.role_code}</a>
				</span> <span class="logOut"><a href="/employee/logout">LogOut</a></span>
			</div>
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
					<form action="/board/writeProc" method="post"
						enctype="multipart/form-data" id="submitForm">
						<input type="hidden" name="contents" id="contents">
						<div class="mainTitle">글 작성</div>
						<div class="writeWrapper">
							<input class="writeTitle" placeholder="제목을 입력하세요." name="title"></input>
							<div class="writeCont">
								<div id="summernote"></div>
							</div>
							<div class="formInputFileWrap">
								<input class="inputFile" id="upload" type="file" multiple
									name="files"> <label class="labelFile" for="upload">파일선택</label>
								<span class="spanFile" id="fileName">선택된 파일이 없습니다.</span>
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
    // 선택한 파일 이름 보여주는 스크립트
        document.getElementById('upload').addEventListener('change', function () {
            const files = this.files;
            const fileNames = Array.from(files).map(file => file.name).join(', ');
            document.getElementById('fileName').textContent = fileNames || '선택된 파일이 없습니다.';
        });
    </script>
</body>

</html>
