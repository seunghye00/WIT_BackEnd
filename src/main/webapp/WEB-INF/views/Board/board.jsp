<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/resources/js/boards.js"></script>

</head>
<body>
	<!-- 공통영역 -->
	<div id="container">
		<div class="sideBar">
			<div class="top">
				<i class="bx bx-menu" id="btn"></i>
			</div>
			<div class="user">
<!-- 				<img src="메인게임.webp" alt="me" class="userImg"> -->
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
		<!-- 공통영역 끝 -->

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<!--마이페이지로 이동-->
				<span class="myName"> <!-- 				 <img src="메인게임.webp"> --> <a href=" #">백민주
						사원</a></span> <span class="logOut"><a href="#">LogOut</a></span>
			</div>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">게시판</h2>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn"><a href="/board/write">글 작성</button>
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
					<div class="mainTitle">자유 게시판 홈</div>
					<div class="boardList">
						<div class="controls">
							<div class="search">
								<select class="form-select" aria-label="Default select example"
									id="searchOpt">
									<option selected>제목</option>
									<option value="1">내용</option>
								</select>

								<div class="searchBox">
									<input type="text" placeholder="검색">
									<button class="searchBtn">
										<i class='bx bx-search'></i>
									</button>
								</div>
							</div>


							<div class="sort">
								<select class="form-select" aria-label="Default select example"
									id="sortOpt">
									<option selected>최신순</option>
									<option value="1">조회수</option>
								</select>
							</div>

						</div>

						<div class="notiList">
							<div class="rows notiHeader">
								<div class="cols boardSeq">
									<span>No.</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>날짜</span>
								</div>
								<div class="cols boardView">조회수</div>

							</div>
							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>
							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>
							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>

							<div class="rows notiConts">
								<div class="cols boardSeq">
									<span>1</span>
								</div>
								<div class="cols boardTitle">
									<span>글 제목 영역입니다.</span>
								</div>
								<div class="cols boardWriter">
									<span>작성자</span>
								</div>
								<div class="cols boardDate">
									<span>2024-07-28 17:11</span>
								</div>
								<div class="cols boardView">
									<span>300</span>
								</div>
							</div>
						</div>

						<div class="pagination">
							<a href="javascript:;" class="prev "><i
								class='bx bx-chevron-left'></i></a> <a href="javascript:;"
								class="active">1</a> <a href="javascript:;">2</a> <a
								href="javascript:;">3</a> <a href="javascript:;">4</a> <a
								href="javascript:;">5</a> <a href="javascript:;"
								class="next active"><i class='bx bx-chevron-right'></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>