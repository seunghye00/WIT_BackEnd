<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>게시물 상세</title>
				<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
				<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
					integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
					crossorigin="anonymous" referrerpolicy="no-referrer" />
				<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
					rel="stylesheet">
				<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
				<link rel="stylesheet" href="/resources/css/style.main.css">
				<link rel="stylesheet" href="/resources/css/wit.css">
				<script defer src="/resources/js/boards.js"></script>
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
							</div>
						</div>

						<ul>
							<li><a href="/"> <i class='bx bxs-home-alt-2'></i> <span class="navItem">홈</span></a>
								<span class="toolTip">홈</span>
							</li>
							<li><a href="#"> <i class='bx bx-paperclip'></i> <span class="navItem">주소록</span></a>
								<span class="toolTip">주소록</span>
							</li>
							<li><a href="/board/list"> <i class="bx bxs-grid-alt"></i>
									<span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
							<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a>
								<span class="toolTip">캘린더</span>
							</li>
							<li><a href="#"> <i class='bx bxs-message-dots'></i> <span class="navItem">메신저</span></a>
								<span class="toolTip">메신저</span>
							</li>
							<li><a href="#"> <i class='bx bx-clipboard'></i> <span class="navItem">전자결재</span></a>
								<span class="toolTip">전자결재</span>
							</li>
							<li><a href="/attendance/attendance"> <i class='bx bxs-briefcase-alt-2'></i> <span
										class="navItem">근태관리</span></a>
								<span class="toolTip">근태관리</span>
							</li>
							<li><a href="#"> <i class='bx bxs-check-square'></i> <span class="navItem">예약</span></a>
								<span class="toolTip">예약</span>
							</li>
							<li><a href="#"> <i class='bx bx-sitemap'></i> <span class="navItem">조직도</span></a>
								<span class="toolTip">조직도</span>
							</li>
						</ul>
					</div>

					<div class="main-content">
						<div class="header">
							<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
							<span class="myName"><img src="/resources/img/푸바오.png" alt="프로필 사진" class="userImg"> <a
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
							</div>

							<!--자유게시판 영역-->
							<div class="sideContents board">
								<form action="/board/update" method="post" id="fboardUpdate"
									enctype="multipart/form-data" style="display:none">
									<input type="hidden" id="hiddenT" name="title" value="${board.title}">
									<input type="hidden" id="hiddenC" name="contents" value="${board.contents}">
									<input type="hidden" name="board_seq" value="${board.board_seq}">
									<input type="file" id="file" multiple name="files">
								</form>
								<c:choose>
									<c:when test="${board_code=='1'}">
										<div class="mainTitle">자유게시판 상세</div>
									</c:when>
									<c:when test="${board_code=='2'}">
										<div class="mainTitle">공지게시판 상세</div>
									</c:when>
								</c:choose>

								<div class="boardDetail">
									<div class="detail">
										<div class="detailTop">
											<div class="top">
												<div class="topTitle" contenteditable="false">${board.title}</div>
												<div class="topFile">
													<!-- data 속성으로 게시글과 사용자 정보를 저장함. -->
													<i class='bx bx-star' id="starIcon"
														data-board-seq="${board.board_seq}"
														data-emp-no="${employee.emp_no }"></i><i
														class='bx bx-file-blank' id="fileIcon"></i>
												</div>
											</div>
											<div class="top">
												<div class="writeAbout">
													<span>${board.emp_no}</span> <span>
														<fmt:formatDate value="${board.write_date}"
															pattern="yyyy-MM-dd" />
													</span> <span><i class="fa-regular fa-eye"></i>
														${board.views}</span>
												</div>

												<!-- 신고하기 버튼 -->
												<c:choose>
													<c:when test="${board_code=='1'}">
														<div class="writeReport">
															<button id="reportBtn">
																<i class='bx bx-message-alt-error'></i> 신고하기
															</button>
														</div>
													</c:when>
												</c:choose>
											</div>
										</div>

										<div class="detailCen" contenteditable="false">${board.contents}
										</div>
										<div class="docuFiles" style="display: none;">
											<label for="file">🔗 파일 선택</label>
											`
											<span class="uploadFiles"></span>

										</div>

										<div class="detailBott">
											<!-- 수정 및 삭제버튼 jstl 사용! -->
											<c:if test="${board.emp_no eq Nickname}">
												<button type="button" class="btn btn-outline-success" id="fboardCom"
													style="display:none">완료</button>
												<button type="button" class="btn btn-ouline-success" id="fboardCan"
													style="display:none">취소</button>
												<button type="button" class="btn btn-outline-success"
													id="fboardUpd">수정</button>
												<button type="button" class="btn btn-outline-success" id="fboardDel"
													onclick="deleteBoard(${board.board_seq})">삭제</button>
											</c:if>
											<button type="button" class="btn btn-outline-primary"
												onclick="location.href='/board/list'">목록으로</button>
										</div>
									</div>

									<!-- 파일 리스트 모달 -->
									<div class="files" id="fileModal">
										<h4>첨부 파일</h4>
										<div id="fileList">
											<c:forEach var="file" items="${files}">
												<div class="fileItem">
													<a
														href="/board/download?sysname=${file.sysname}&oriName=${file.oriname}">
														${file.oriname}
													</a>

													<!-- 
														1. 화면상 파일 삭제하기
														2. 수정 완료 버튼 누르면 파일 시퀀스 보내주기
													 -->

													<button class="fileDel" style="display: none;"
														data-seq="${file.board_files_seq}">x</button>
												</div>
											</c:forEach>
										</div>
									</div>

									<!-- reply 영역 -->
									<div class="replyWrapper">
										<span class="replyTxt"><i class='bx bx-message-alt-dots'></i>
											댓글 달기</span>

										<!-- 댓글 작성 폼 -->
										<div class="reply">
											<form action="/reply/registProc" method="post">
												<div class="replyCont">
													<textarea class="writeRly" contenteditable="true" name="contents"
														placeholder="입력할 수 있는 글자 수는 최대 900자입니다."></textarea>
													<input type="hidden" name="board_seq" value="${board.board_seq}">
												</div>
												<div class="replyBtn">
													<button type="submit" class="btn btn-outline-secondary"
														id="replyInst">작성하기</button>
												</div>
											</form>
										</div>
										<!-- 댓글 수 -->
										<div class="replyCount">
											<span>댓글 수 : </span><span>${replyList.size()}</span>
										</div>

										<!-- 댓글 리스트 -->
										<div class="replyLists">
											<c:forEach var="reply" items="${replyList}">
												<div class="replyList">
													<div class="replyTxt">
														<!--임시로 푸바오 사진 넣어놈~! -->
														<img src="/resources/img/푸바오.png" alt="">
														<span>${reply.emp_no}</span>
														<div class="replyDate">
															<fmt:formatDate value="${reply.write_date}"
																pattern="yyyy-MM-dd HH:mm" />
														</div>
													</div>
													<div class="reply">
														<div class="replyPrint" contenteditable="false">
															${reply.contents}
														</div>

														<div class="replyBtn">
															<c:if test="${reply.emp_no eq Nickname}">
																<!-- 수정 아이콘-->
																<img src="/resources/img/pen-to-square-solid.svg"
																	class="updateReply">

																<!-- 수정 완료 아이콘-->
																<i class='bx bx-check updateRly' style="display: none;"
																	data-seq="${reply.reply_seq}"> </i>
																<!-- 수정 취소 아이콘-->
																<i class='bx bx-x canRly' style="display: none;"
																	data-seq="${reply.reply_seq}"></i>

																<!-- 댓글 삭제 기능 -->
																<!--삭제 버튼 이미지 -->
																<img src="/resources/img/trash-solid.svg" alt="Delete"
																	style="cursor:pointer;"
																	onclick="submitDeleteForm(${reply.reply_seq});"
																	class="delRly">
																<button style="display: none;"
																	class="replyDelBtn"></button>
															</c:if>
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>

							<!--신고하기 모달창-->
							<div id="modal" class="dialog">
								<div class="tb">
									<div class="inner">
										<div class=" top">
											<div class="title">신고하기</div>
										</div>
										<div class="ct">
											<div class="reporter">
												<div class="reportNick">신고자 닉네임</div>
												<input class="reportInput" value="${board.emp_no}" readonly></input>
											</div>
											<div class="reportSort">
												<div class="sort">신고 사유</div>
												<div class="selectSort">
													<form action="/report/insert" id="reportForm">
														<select class="form-select form-select-sm"
															aria-label="Small select example" name="target">
															<option value="1" selected>욕설 및 비방</option>
															<option value="2">스팸 및 광고</option>
															<option value="3">음란물 및 부적절한 콘텐츠
															</option>
														</select>
														<input type="hidden" name="board_seq"
															value="${board.board_seq}">

													</form>
												</div>
											</div>
										</div>
										<div class="reportControls">
											<a href="#" class="rClose">
												<button type="button" class="btn btn-primary"
													id="reportClose">닫기</button>
											</a> <a href="#">
												<button type="button" class="btn btn-danger"
													id="reportInsert">신고하기</button>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>




				<script>

					// JSP에서 계산된 파일의 길이를 JavaScript로 전달합니다.
					let defaultFileLength = ${ filesSize };
					var filesLength = ${ filesSize };
					console.log(filesLength);
					// 삭제 이미지 클릭시 form 제출
					function submitDeleteForm(replySeq) {
						location.href = "/reply/delete?boardSeq=${board.board_seq}&replySeq=" + replySeq;
					}

					// 북마크 기능
					// 북마크 눌렀을 때 북마크한 아이콘 새로고침 해도유지됨
					if (${ bookmark }) { $('#starIcon').attr('class', 'bx bxs-star') }

					// 삭제 기능
					function deleteBoard(boardSeq) {
						if (confirm("정말로 삭제하시겠습니까?")) {
							// 사용자에게 삭제 확인을 받았을 때만 삭제 요청
							location.href = "/board/delete?board_seq=" + boardSeq;
						}
					}
					console.log("Login ID: ${Nickname}");
					console.log("Board emp_no: ${board.emp_no}");

					// 삭제할 파일 버튼
					let fileArr = [];
					$(".fileDel").on("click", function (e) {
						// 클릭한 버튼의 파일 대상
						console.log(e.target);
						console.log($(e.target).parent());

						defaultFileLength--
						filesLength--;
						fileArr.push($(e.target).data("seq"));
						$(e.target).parent().hide();
						console.log(fileArr)
					})

					$(document).ready(function () {
						// 수정 버튼 클릭 시
						$("#fboardUpd").on("click", function () {
							$("#fboardCom").show();
							$("#fboardCan").show();
							$("#fboardUpd").hide();
							$(".fileDel").show();
							$(".docuFiles").show();

							// 제목 내용 수정 가능하게 속성 지정
							$(".topTitle").attr("contenteditable", true);

							// 썸머노트 활성화
							$('.detailCen').summernote({
								height: 400, // 기본 높이 설정
								minHeight: null, // 최소 높이 설정
								maxHeight: null, // 최대 높이 설정
								focus: true, // 페이지 로드 시 포커스
								callbacks: {
									onInit: function () {
										// summernote 초기화 후 note-statusbar 요소 제거
										$('.note-statusbar').remove()
									}
								}
							});
						});

						// 완료 버튼 클릭 시 
						$("#fboardCom").on("click", function () {
							// 썸머노트 내용을 숨겨진 필드에 복사
							$("#hiddenC").val($(".detailCen").summernote('code'));
							$("#hiddenT").val($(".topTitle").html().trim());
							if (fileArr.length > 0) {
								$.ajax({
									url: "/uploadImage/delete",
									type: "get",
									data: {
										// 직렬화: object -> String으로 바꿔주는 방법
										files_seq: JSON.stringify(fileArr)
									}
								}).done(function (response) {
									// 폼 제출
									$("#fboardUpdate").submit();
								})
							} else {
								$("#fboardUpdate").submit();
							}

						});

						// 취소 버튼 클릭 시
						$("#fboardCan").on("click", function () {
							location.href = "/board/detail?board_seq=${board.board_seq}";
						});



						// 댓글 script
						// 댓글 수정 버튼 클릭 시
						$(".updateReply").on("click", function (e) {
							console.log(e.target);
							let update = $(e.target)
							// 댓글 수정 완료 버튼
							update.parent().find(".updateRly").show();
							// 댓글 수정 취소 버튼
							update.parent().find(".canRly").show();
							update.parent().find(".delRly").hide();
							update.hide();

							update.parent().parent().find(".replyPrint").attr("contenteditable", true);
						})

						// 댓글 수정 취소 버튼 클릭 시
						$(".canRly").on("click", function (e) {
							let cancel = $(e.target);
							cancel.parent().find('.updateReply').show();
							cancel.parent().find('.updateRly').hide();
							cancel.parent().find(".delRly").show();
							cancel.hide();
							location.href = "/board/detail?board_seq=${board.board_seq}";
						})



						// 댓글 수정 완료 버튼 클릭 시
						$(".updateRly").on("click", function (e) {
							let complete = $(e.target);
							let writeDate = complete.parents('.replyList').find(".replyTxt").find(".replyDate")

							$.ajax({
								url: "/reply/update",
								type: "post",
								data: {
									contents: complete.parent().parent().find('.replyPrint').html(),
									reply_seq: complete.data("seq"),



								}
							}).done(function (response) {

								writeDate.html(response);
								complete.parent().find('.updateReply').show();
								complete.parent().find(".delRly").show();
								complete.parent().find(".canRly").hide();
								complete.hide();
								console.log(response)
							})
						})


						// 북마크 클릭 이벤트 
						$("#starIcon").on("click", function () {
							// 현재 클릭한 요소
							var $this = $(this);
							var boardSeq = $(this).data("board-seq");
							var empNo = $(this).data("emp-no");

							$.ajax({
								url: "/bookmark/toggle", // 서버의 북마크 처리 엔드포인트
								method: "post", // 요청 메서드
								data: {
									board_seq: boardSeq,
									emp_no: empNo
								}
							}).done(function (response) {
								// 서버 응답 성공 시 아이콘 변경
								if ($this.hasClass("bx-star")) {
									$this.removeClass("bx-star").addClass("bxs-star");
								} else {
									$this.removeClass("bxs-star").addClass("bx-star");
								}
								console.log("북마크 업데이트 성공");
							})
						})
					});
					// 파일 아이콘 클릭 시 파일 리스트 보이게
					$(document).ready(function () {
						var fileModal = $("#fileModal");

						// 파일 아이콘 클릭했을 때 이벤트 핸들러 설정
						$("#fileIcon").on("click", function (event) {
							// 파일 모달창이 이미 보이면 숨김
							if (fileModal.is(":visible")) {
								fileModal.hide();
							} else {
								// 보이지 않으면 숨김
								fileModal.show();

								// 파일 아이콘의 오프셋(화면 상 위치)가져옴
								var iconOffset = $(this).offset();

								// 파일 리스트의 위치를 파일 아이콘 바로 아래로 설정하고 표시
								fileModal.css({
									// 파일 아이콘의 높이만큼 아래로 배치
									top: iconOffset.top + $(this).outerHeight() + "px",
									// 파일 아이콘의 왼쪽 위치와 동일하게 배치
									left: iconOffset.left + "px",
								});
							}
						});

						$(document).on("click", function (event) {
							// 문서의 아무 곳이나 클릭했을 때 이벤트 핸들러 설정
							if (!$(event.target).closest("#fileIcon,#fileModal").length) {
								fileModal.hide();
							}
						});

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
					});
					// 신고하기 제한
					$('#reportInsert').on('click', function () {
						$.ajax({
							url: '/report/check',
							data: {
								boardSeq: '${board.board_seq}',
							},
							type: 'post',
						}).done(function (resp) {
							if (resp == 'true') {
								$('#reportForm').submit()
							} else {
								alert('이미 신고된 게시물 입니다.')
							}
						})
					})
				</script>
			</body>

			</html>