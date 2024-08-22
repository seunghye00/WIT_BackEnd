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
					<c:choose>
						<c:when test="${employee.role_code eq '사장'}">
							<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp" %>
						</c:when>
						<c:otherwise>
							<%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>
						</c:otherwise>
					</c:choose>
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

									<div class="addressListPrivate">
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

									<div class="addressListPrivate">
										<ul class="GroupList">
											<li class="toggleItem">
												<h3 class="toggleTit">
													공지 사항
												</h3>
												<ul class="subList">
													<li><a href="/board/list?bookmark=true&boardCode=2">북마크한 게시물</a>
													</li>

													<li><a href="/board/list?boardCode=2">공지 사항으로
															이동</a>
													</li>

													<c:if test="${employee.role_code == '사장'}">
														<li><a href="/board/write?boardCode=2">공지 사항 글
																작성</a></li>
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
									<c:choose>
										<c:when test="${adminReport == 'true'}">
											<div class="mainTitle">신고 현황 홈</div>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${board_code=='1'}">
													<c:choose>
														<c:when test="${report=='true'}">
															<div class="mainTitle">신고글 홈</div>
														</c:when>
														<c:when test="${bookmark=='false'}">
															<div class="mainTitle">자유 게시판 홈</div>
														</c:when>
														<c:when test="${bookmark=='true'}">
															<div class="mainTitle">북마크 홈</div>
														</c:when>
													</c:choose>
												</c:when>
												<c:when test="${board_code=='2'}">
													<c:choose>
														<c:when test="${bookmark == 'true'}">
															<div class="mainTitle">북마크 홈</div>
														</c:when>
														<c:otherwise>
															<div class="mainTitle">공지 사항 홈</div>
														</c:otherwise>
													</c:choose>
												</c:when>
											</c:choose>
										</c:otherwise>
									</c:choose>



									<div class="boardList">
										<div class="controls">
											<div class="search">
												<form action="/board/list" style="display:none" id="searchForm">
													<input type="hidden" name="searchTarget" class="hiddenInput">
													<input type="hidden" name="sortTarget" class="hiddenInput">
													<input type="text" name="searchTxt" placeholder="검색"
														class="hiddenInput">
													<input type="text" name="bookmark" id="bookmark">
													<input type="text" name="boardCode" id="board_code" value="1">
													<input type="text" name="report" id="report" value="false">
													<input type="text" name="adminReport" id="adminReport"
														value="false">
												</form>
												<select class="form-select" aria-label="Default select example"
													id="searchTarget">
													<option selected value="title">제목</option>
													<option value="contents">내용</option>
												</select>

												<div class="searchBox">
													<input type="text" placeholder="검색" value="${searchTxt}"
														id="searchTxt">
													<button class="searchBtn" id="searchBtn">
														<i class='bx bx-search'></i>
													</button>
												</div>
											</div>

											<div class="sort">
												<select class="form-select" aria-label="Default select example"
													id="sortTarget">
													<option selected value="board_seq">최신순</option>
													<c:choose>
														<c:when test="${adminReport=='true'}">
															<option value="views">신고 횟수</option>
														</c:when>
														<c:otherwise>
															<option value="views">조회수</option>
														</c:otherwise>
													</c:choose>

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
												<c:choose>
													<c:when test="${report=='true'}">
														<div class="cols boardView">신고유형</div>
													</c:when>
													<c:when test="${adminReport=='true'}">
														<div class="cols boardView">누적 신고 횟수</div>
														<div class="cols boardBtn">
															게시글 삭제
														</div>
													</c:when>
													<c:otherwise>
														<div class="cols boardView">조회수</div>
													</c:otherwise>
												</c:choose>

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
													<c:choose>
														<c:when test="${report=='true'}">
															<div class="cols boardDate">
																<fmt:formatDate value="${board.report_date}"
																	pattern="yyyy-MM-dd" />
															</div>
														</c:when>
														<c:otherwise>
															<div class="cols boardDate">
																<fmt:formatDate value="${board.write_date}"
																	pattern="yyyy-MM-dd" />
															</div>
														</c:otherwise>
													</c:choose>
													<c:choose>
														<c:when test="${report=='true'}">
															<div class="cols boardView">
																<span>${board.report_type}</span>
															</div>
														</c:when>
														<c:when test="${adminReport=='true'}">
															<div class="cols boardView">
																<span class="thisRList"
																	data-seq="${board.board_seq}">${board.count}</span>
															</div>
															<div class="cols boardWriter">
																<button class="deleteBoard"
																	onclick="deleteBoard(${board.board_seq})">삭제</button>
															</div>
														</c:when>
														<c:otherwise>
															<div class="cols boardView">
																<span>${board.views}</span>
															</div>
														</c:otherwise>
													</c:choose>
												</div>
											</c:forEach>
										</div>


										<div class="pagination" id="pagination">
										</div>
									</div>
								</div>
								<!--신고 현황 모달창-->
								<div id="modal" class="dialog">
									<div class="tb">
										<div class="inner">
											<div class=" top">
												<div class="title">신고내역</div>
											</div>
											<div class="ct">
												<div class="ctTitle">
													<div class="reportPer">신고자</div>
													<div class="reportRes">신고 사유</div>
													<div class="reportDate">신고 날짜</div>
												</div>

												<div class="ctContainer" style="display: flex; flex-direction: column;">

												</div>

											</div>
											<div class="reportControls">
												<a href="#" class="rClose">
													<button type="button" class="btn btn-primary"
														id="reportClose">닫기</button>
												</a>
											</div>
										</div>
									</div>
								</div>


							</div>
					</div>
				</div>
				<div class="reporttemp" style="display: none;">
					<div class="ctCont">
						<div class="reportPer"></div>
						<div class="reportRes"></div>
						<div class="reportDate"></div>
					</div>
				</div>

				<script>
					// 처음에 서버에서 값을 보내줄 때 빈 문자열이 아니면 서버에서 보내준 값으로 설정
					if (${ searchTarget != "" }) {
						document.getElementById('searchTarget').value = "${ searchTarget }";
					}

					if (${ sortTarget != "" }) {
						document.getElementById('sortTarget').value = "${ sortTarget }";
					}

					if (${ bookmark != "false" }) {
						document.getElementById('bookmark').value = "${ bookmark }";
					}

					if (${ board_code != "1" }) {
						document.getElementById('board_code').value = "${ board_code }";
					}

					if (${ report != "false" }) {
						document.getElementById('report').value = "${ report }";
					}

					if (${ adminReport != "false" }) {
						document.getElementById('adminReport').value = "${ adminReport }";
					}


					// 글작성 버튼 누르면 글 작성 페이지로 이동
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
							window.location.href = "${pageContext.request.contextPath}/board/detail?boardCode=${board_code}&board_seq=" + $(e).data("seq")
						})

					}

					// 신고현황 클릭 시
					$(".reportList").on("click", function () {
						window.location.href = "/board/list?adminReport=true";
					});

					// 신고 리스트 모달 열기 및 닫기
					$('.thisRList').on('click', function () {
						$.ajax({
							url: "/board/reportList",
							data: {
								board_seq: $(this).data("seq")
							}

						}).done((resp) => {
							var data = resp.reportList;
							if (Array.isArray(data) && data.length > 0) {
								let ctContainer = $(".ctContainer");
								ctContainer.html(""); // 기존 내용을 지우기
								data.forEach(function (contact) {
									console.log(contact);
									let clone = $(".reporttemp").find(".ctCont").clone(true);
									clone.css({
										display: "flex",
										flex: 1
									})
									let per = clone.find(".reportPer");
									let res = clone.find(".reportRes");
									let date = clone.find(".reportDate");
									per.html(contact.EMP_NO);
									res.html(contact.REPORT_TYPE);
									date.html(contact.REPORT_DATE);
									ctContainer.append(clone);
								});
							} else {
								$(".ctContainer").append('<div class="noData">데이터 없음</div>');
							}
						})
						$('#modal').css('display', 'block')
					})
					$('.rClose').on('click', function () {
						$('#modal').css('display', 'none')
					})

					// 검색 버튼 누르면 검색 옵션, 정렬 옵션, 검색 내용 값 넣어주기
					$("#searchBtn").on("click", function () {
						let hiddenInput = $(".hiddenInput");
						hiddenInput.eq(0).val($("#searchTarget").val());
						hiddenInput.eq(1).val($("#sortTarget").val());
						hiddenInput.eq(2).val($("#searchTxt").val());

						$("#searchForm").submit();
					})

					// 엔터키로 검색 가능하게 추가
					$("#searchTxt").on("keypress", function (event) {
						if (event.keyCode === 13) { // Enter 키의 keyCode는 13
							$("#searchBtn").click();
						}
					});

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
						pageNation.append("<a href='/board/list?searchTarget=${searchTarget}&searchTxt=${searchTxt}&sortTarget=${sortTarget}&boardCode=${board_code}&bookmark=${bookmark}&report=${report}&adminReport=${adminReport}&cpage=" + (startNavi - 1) + "' class='prev " + (needPrev ? "active" : "disabled") + "'><i class='bx bx-chevron-left'></i></a>");

					for (let i = startNavi; i <= endNavi; i++) {
						let page = $("<a href='/board/list?searchTarget=${searchTarget}&searchTxt=${searchTxt}&sortTarget=${sortTarget}&boardCode=${board_code}&bookmark=${bookmark}&report=${report}&adminReport=${adminReport}&cpage=" + i + "'>" + i + "</a> ");
						pageNation.append(page);
						if (i == cpage) {
							page.css({
								backgroundColor: '#558BCF',
								color: 'white',
								'border-radius': '100%',
								width: '40px',
								'text-align': 'center'
							})
						}
					}
					if (needNext)
						pageNation.append("<a href='/board/list?searchTarget=${searchTarget}&searchTxt=${searchTxt}&sortTarget=${sortTarget}&boardCode=${board_code}&bookmark=${bookmark}&report=${report}&adminReport=${adminReport}&cpage=" + (endNavi + 1) + "' class='next " + (needNext ? "active" : "disabled") + "' data-page='" + (endNavi + 1) + "'><i class='bx bx-chevron-right'></i></a>");


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

					// 삭제 기능
					function deleteBoard(boardSeq) {
						if (confirm("정말로 삭제하시겠습니까?")) {
							// 사용자에게 삭제 확인을 받았을 때만 삭제 요청
							location.href = "/board/deleteReport?board_seq=" + boardSeq;
						}
					}
				</script>
			</body>

			</html>