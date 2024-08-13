<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>자유게시판</title>
				<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
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
							<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a>
								<span class="toolTip">캘린더</span>
							</li>
							<li><a href="#"> <i class='bx bxs-message-dots'></i> <span class="navItem">메신저</span></a>
								<span class="toolTip">메신저</span>
							</li>
							<li><a href="#"> <i class='bx bx-clipboard'></i> <span class="navItem">전자결재</span></a> <span
									class="toolTip">전자결재</span></li>
							<li><a href="/attendance/attendance"> <i class='bx bxs-briefcase-alt-2'></i> <span
										class="navItem">근태관리</span></a>
								<span class="toolTip">근태관리</span>
							</li>
							<li><a href="#"> <i class='bx bxs-check-square'></i> <span class="navItem">예약</span></a>
								<span class="toolTip">예약</span>
							</li>
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
									${employee.role_code}</a></span> <span class="logOut"><a
									href="/employee/logout">LogOut</a></span>
						</div>
						<div class="contents">
							<div class="sideAbout">
								<div class="sideTxt">
									<h2 class="sideTit">게시판</h2>
								</div>
								<div class="sideBtnBox">
									<button id="writeBtn" class="plusBtn sideBtn">글 작성</button>
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
											<form action="/board/list" style="display:none" id="searchForm">
												<input type="hidden" name="searchTarget" class="hiddenInput">
												<input type="hidden" name="sortTarget" class="hiddenInput">
												<input type="text" name="searchTxt" placeholder="검색"
													class="hiddenInput">
											</form>
											<select class="form-select" aria-label="Default select example"
												id="searchTarget">
												<option selected value="title">제목</option>
												<option value="contents">내용</option>
											</select>

											<div class="searchBox">
												<input type="text" placeholder="검색" value="${searchTxt}" id="searchTxt">
												<button class="searchBtn" id="searchBtn">
													<i class='bx bx-search'></i>
												</button>
											</div>
										</div>

										<div class="sort">
											<select class="form-select" aria-label="Default select example"
												id="sortTarget">
												<option selected value="board_seq">최신순</option>
												<option value="views">조회수</option>
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

										<!-- 게시물 목록 출력 -->
										<!-- varStatus 를 이용하여 최신 게시물의 no를 1로 했다! -->
										<!-- 매퍼파일에서 최신순으로 내가 정렬을 해놨는데, 최신순으로 정렬을 했을때 사용가능!~  -->
										<!-- 이렇게도 할 수 있어 밍쥬야 jsp에서 번호를 수동으로 할당 해주는거래-->
										<c:forEach var="board" items="${list}" varStatus="status">
											<div class="rows notiConts">
												<div class="cols boardSeq">
													<span>${status.index + 1}</span>
												</div>
												<div class="cols boardTitle" onclick="toDetail(this)"
													data-seq="${board.board_seq}">
													<span>${board.title}</span>
												</div>
												<div class="cols boardWriter">
													<!-- 여기서 조인해서 emp_no 자리에 닉네임이 나오게끔 했어! -->
													<span>${board.emp_no}</span>
												</div>
												<div class="cols boardDate">
													<fmt:formatDate value="${board.write_date}" pattern="yyyy-MM-dd" />
												</div>
												<div class="cols boardView">
													<span>${board.views}</span>
												</div>
											</div>
										</c:forEach>
									</div>


									<div class="pagination">

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<script>
					// 처음에 서버에서 값을 보내줄 때 빈 문자열이 아니면 서버에서 보내준 값으로 설정
					if (${ searchTarget != "" }) {
						document.getElementById('searchTarget').value = "${ searchTarget }";
					}

					// 처음에 서버에서 값을 보내줄 때 빈 문자열이 아니면 서버에서 보내준 값으로 설정
					if (${ sortTarget != "" }) {
						document.getElementById('sortTarget').value = "${ sortTarget }";
					}


					document.getElementById('writeBtn').addEventListener('click',
						function () {
							window.location.href = '/board/write';
						});
					function toDetail(e) {
						$.ajax({
							url: "/board/views",
							data: {
								board_seq: $(e).data("seq")
							}

						}).done(function (response) {
							window.location.href = "${pageContext.request.contextPath}/board/detail?board_seq=" + $(e).data("seq")
						})

					}

					// 검색 버튼 누르면 검색 옵션, 정렬 옵션, 검색 내용 값 넣어주기
					$("#searchBtn").on("click", function () {
						let hiddenInput = $(".hiddenInput");
						hiddenInput.eq(0).val($("#searchTarget").val());
						hiddenInput.eq(1).val($("#sortTarget").val());
						hiddenInput.eq(2).val($("#searchTxt").val());

						$("#searchForm").submit();
					})

					// 정렬 옵션이 바뀌면 정렬 옵션값 넣어주고, 
					// 검색 옵션, 검색 내용 값은 맨 처음 서버에서 보내준 초기값으로 설정해준다!
					// 왜냐하면, 검색 버튼을 누르기 전이기 때문에 변한 값을 넣어주면 안된다!
					$("#sortTarget").on("change", function () {
						let hiddenInput = $(".hiddenInput");
						hiddenInput.eq(0).val("${ searchTarget }");
						hiddenInput.eq(1).val($("#sortTarget").val());
						hiddenInput.eq(2).val("${ searchTxt }");

						$("#searchForm").submit();
					})


					// 페이징
					let pageNation = $(".pagination");

					let cpage = ${ cpage }
					let record_total_count = ${ record_total_count }
					let record_count_per_page = ${ record_count_per_page }
					let navi_count_per_page = ${ navi_count_per_page }
					let pageTotalCount = Math.ceil(record_total_count / record_count_per_page);

					let startNavi = Math.floor((cpage - 1) / navi_count_per_page) * navi_count_per_page + 1;
					let endNavi = startNavi + navi_count_per_page - 1;

					if (endNavi > pageTotalCount) {
						endNavi = pageTotalCount;
					}

					let needPrev = true;
					if (startNavi == 1) {
						needPrev = false;
					}
					let needNext = true;
					if (endNavi == pageTotalCount) {
						needNext = false;
					}

					if (needPrev)
						pageNation.append("<a href='/board/list?searchTarget=${searchTarget}&searchTxt=${searchTxt}&sortTarget=${sortTarget}&cpage=" + (startNavi - 1) + "' class='prev " + (needPrev ? "active" : "disabled") + "'><i class='bx bx-chevron-left'></i></a>");

					for (let i = startNavi; i <= endNavi; i++) {
						pageNation.append("<a href='/board/list?searchTarget=${searchTarget}&searchTxt=${searchTxt}&sortTarget=${sortTarget}&cpage=" + i + "'>" + i + "</a> ");
					}
					if (needNext)
						pageNation.append("<a href='/board/list?searchTarget=${searchTarget}&searchTxt=${searchTxt}&sortTarget=${sortTarget}&cpage=" + (endNavi + 1) + "' class='next " + (needNext ? "active" : "disabled") + "' data-page='" + (endNavi + 1) + "'><i class='bx bx-chevron-right'></i></a>");



				</script>
			</body>

			</html>