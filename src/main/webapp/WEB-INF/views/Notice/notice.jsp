<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시판</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
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
						<a href="wirte_free_board.html"><button
								class="plusBtn sideBtn">글 작성</button></a>
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
					<div class="addressListGroup" id="toBoard">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggle">
									<a href="/board/list">자유 게시판</a>
								</h3>
							</li>
						</ul>
					</div>
				</div>
				<div class="sideContents board">
					<div class="mainTitle">공지사항 홈</div>
					<div class="boardList">
						<div class="controls">
							<div class="search">
								<form action="/notice/search">
									<!-- 검색 조건 선택 -->
									<select id="searchOpt" name="searchNotice">
										<option value="title"
											${param.searchNotice == 'title' ? 'selected' : ''}>제목</option>
										<option value="contents"
											${param.searchNotice == 'contents' ? 'selected' : ''}>내용</option>
									</select>

									<!-- 검색어 입력 -->
									<div class="searchBox">
										<input type="text" name="keyword" value="${param.keyword}"
											placeholder="검색">
										<button class="searchBtn">
											<i class='bx bx-search'></i>
										</button>
									</div>								
								</form>
								<!-- 정렬 옵션 선택 -->
									<div class="sort">
										<!-- 정렬 옵션 선택 -->
										<!-- onchange="this.form.submit()" : 정렬 옵션을 선택할 때마다 폼이 자동으로 제출됨 -->
										<select class="formSelect" id="sortOpt" name="sortOpt"
											onchange="this.form.submit()">
											<option value="latest"
												${param.sortOpt == 'latest' ? 'selected' : ''}>최신순</option>
											<option value="views"
												${param.sortOpt == 'views' ? 'selected' : '' }>조회수</option>
										</select>

										<!-- 같은 검색어와 조건을 유지하려면 hidden 필드를 사용하여 검색 조건과 검색어를 포함.-->
										<input type="hidden" name="keyword" value="${param.keyword}">
										<input type="hidden" name="searchNotice"
											value="${param.searchNotice }">
									</div>
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
								<div class="cols boardView">
									<span>조회수</span>
								</div>
							</div>

							<c:forEach var="i" items="${list}">
								<div class="rows notiConts"
									onclick="location.href='/notice/detailNotice?seq=${i.notice_seq }'">
									<div class="cols boardSeq">
										<span>${i.notice_seq }</span>
									</div>
									<div class="cols boardTitle">
										<span>${i.title }</a></span>
									</div>
									<div class="cols boardWriter">
										<span>${i.emp_no}</span>
									</div>
									<div class="cols boardDate">
										<fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd" />
									</div>
									<div class="cols boardView">
										<span>${i.views }</span>
									</div>
								</div>
							</c:forEach>

						</div>

					</div>
					<div class="pagination">
						<a href="javascript:;" class="prev "><i
							class='bx bx-chevron-left'></i></a> <a href="javascript:;"
							class="active">1</a> <a href="javascript:;">2</a> <a
							href="javascript:;">3</a> <a href="javascript:;">4</a> <a
							href="javascript:;">5</a> <a href="javascript:;"
							class="next active"><i class='bx bx-chevron-right'></i> </a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>