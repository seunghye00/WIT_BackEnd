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
				<link rel="stylesheet" href="/css/style.main.css">
				<link rel="stylesheet" href="/css/wit.css">
				<script defer src="/js/wit.js"></script>
				<script defer src="/js/boards.js"></script>
			</head>


			<body>
				<div id="container">
					<c:choose>
						<c:when test="${employee.role_code eq '사장'}">
							<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp" %>
						</c:when>
						<c:otherwise>
							<%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>
						</c:otherwise>
					</c:choose>
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
												<h3 class="toggleTit">자유 게시판</h3>
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
												<h3 class="toggleTit">공지 사항</h3>
												<ul class="subList">
													<li><a href="/board/list?bookmark=true&boardCode=2">북마크한
															게시물</a></li>

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
													<h3 class="reportList">신고 현황</h3>
												</li>
											</ul>
										</div>
									</c:if>
								</div>

								<!--자유게시판 영역-->
								<div class="sideContents board">
									<form action="/board/update" method="post" id="fboardUpdate"
										enctype="multipart/form-data" style="display: none">
										<input type="hidden" id="hiddenT" name="title" value="${board.title}"> <input
											type="hidden" id="hiddenC" name="contents" value="${board.contents}"> <input
											type="hidden" name="board_seq" value="${board.board_seq}">
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
													<div class="topTitle" contenteditable="false">${board.title}
													</div>
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
																<c:if test="${board.emp_no != Nickname}">
																	<button id="reportBtn">
																		<i class='bx bx-message-alt-error'></i> 신고하기
																	</button>
																</c:if>
															</div>
														</c:when>
													</c:choose>
												</div>
											</div>

											<div class="detailCen" contenteditable="false">${board.contents}
											</div>
											<div class="docuFiles" style="display: none;">
												<label for="file">🔗 파일 선택</label> ` <span class="uploadFiles"></span>

											</div>

											<div class="detailBott">
												<!-- 수정 및 삭제버튼 jstl 사용! -->
												<!--본인 작성 or 관리자 버튼 보이게-->
												<c:if test="${board.emp_no eq Nickname || employee.role_code == '사장'}">
													<button type="button" class="btn btn-outline-success" id="fboardCom"
														style="display: none">완료</button>
													<button type="button" class="btn btn-ouline-success" id="fboardCan"
														style="display: none">취소</button>
													<button type="button" class="btn btn-outline-success"
														id="fboardUpd">수정</button>
													<button type="button" class="btn btn-outline-success" id="fboardDel"
														onclick="deleteBoard(${board.board_seq},${board_code})">삭제</button>
												</c:if>
												<button type="button" class="btn btn-outline-primary"
													onclick="location.href='/board/list?boardCode=${board_code}&bookmark=${bookmark}&report=${report}&adminReport=${adminReport}'">목록으로</button>
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
															${file.oriname} </a>
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
												<form action="/reply/registProc" method="post" id="replyInsertForm">
													<div class="replyCont">
														<textarea class="writeRly" contenteditable="true"
															name="contents"
															placeholder="입력할 수 있는 글자 수는 최대 900자입니다."></textarea>
														<input type="hidden" name="board_seq"
															value="${board.board_seq}">

														<input type="hidden" name="boardCode" id="board_code" value="1">
														<input type="hidden" name="bookmark" id="bookmark">
														<input type="hidden" name="report" id="report" value="false">
													</div>
													<div class="replyBtn">
														<button type="button" class="btn btn-outline-secondary"
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
															<span class="myImgBox"> <img src="${employee.photo}"
																	alt="프로필 이미지" class="userImg">
															</span> <span>${reply.emp_no}</span>
															<div class="replyDate">
																<fmt:formatDate value="${reply.write_date}"
																	pattern="yyyy-MM-dd HH:mm" />
															</div>
														</div>
														<div class="reply">
															<div class="replyPrint" contenteditable="false">
																${reply.contents}</div>

															<div class="replyBtn">
																<c:if
																	test="${reply.emp_no eq Nickname || employee.role_code == '사장'}">
																	<!-- 수정 아이콘-->
																	<img src="/resources/img/pen-to-square-solid.svg"
																		class="updateReply">

																	<!-- 수정 완료 아이콘-->
																	<i class='bx bx-check updateRly'
																		style="display: none;"
																		data-seq="${reply.reply_seq}"> </i>
																	<!-- 수정 취소 아이콘-->
																	<i class='bx bx-x canRly' style="display: none;"
																		data-seq="${reply.reply_seq}"></i>

																	<!-- 댓글 삭제 기능 -->
																	<!--삭제 버튼 이미지 -->
																	<img src="/resources/img/trash-solid.svg"
																		alt="Delete" style="cursor: pointer;"
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
												<div class="titleTxt">
													이 글이 커뮤니티 가이드라인을 위반한다고 생각되시면 신고 사유를 작성해 주세요. <br> 접수된 신고는
													검토 후 필요한 조치를 취하겠습니다.
												</div>
											</div>
											<div class="ct">
												<div class="reporter">
													<div class="reportNick">신고자 닉네임</div>
													<input class="reportInput" value="${Nickname}" readonly></input>
												</div>
												<div class="reportSort">
													<div class="sort">신고 사유</div>
													<div class="selectSort">
														<form action="/report/insert" id="reportForm">
															<select class="form-select form-select-sm"
																aria-label="Small select example" name="target">
																<option value="1" selected>욕설 및 비방</option>
																<option value="2">스팸 및 광고</option>
																<option value="3">음란물 및 부적절한 콘텐츠</option>
															</select> <input type="hidden" name="board_seq"
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

					// JSP에서 계산된 파일의 길이를 JavaScript로 전달합니다.
					let defaultFileLength = ${ filesSize };
					var filesLength = ${ filesSize };
					console.log(filesLength);

					// 삭제 이미지 클릭시 form 제출
					function submitDeleteForm(replySeq) {
						$.ajax({
							url: "/reply/delete",
							data: {
								boardSeq: ${ board.board_seq },
							replySeq: replySeq
                        	}

                    	}).done(function (response) {
								location.reload()
							})
               		}

					// 북마크 기능
					// 북마크 눌렀을 때 북마크한 아이콘 새로고침 해도유지됨
					if (${ bookmarkCheck }) { $('#starIcon').attr('class', 'bx bxs-star') }

					// 삭제 기능
					function deleteBoard(boardSeq, boardCode) {
						if (confirm("정말로 삭제하시겠습니까?")) {
							// 사용자에게 삭제 확인을 받았을 때만 삭제 요청
							location.href = "/board/delete?board_seq=" + boardSeq + "&board_code=" + boardCode;
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
									},
									onImageUpload: function (files) {
										let file = files[0]
										let formData = new FormData()
										formData.append('file', file)
										$.ajax({
											url: `/board/uploadImg?boardSeq=-1`, // 이미지를 저장할 서버 URL
											type: 'POST',
											data: formData,
											contentType: false,
											processData: false,
											success: function (resp) {
												console.log(resp)
												// 서버에서 받은 이미지 URL을 에디터에 삽입
												$('.detailCen').summernote(
													'insertImage',
													`/uploads/board/images/` + resp
												)

												// 추가적인 정보가 필요하다면, 이를 사용하여 다른 작업 수행
												//    const width = resp.width
												//  const height = resp.height
												// 예: 이미지 크기 조절, 추가 데이터 처리 등
											},
											error: function (jqXHR, textStatus, errorThrown) {
												console.error(
													'이미지 업로드 실패:',
													textStatus,
													errorThrown
												)
											},
										})
									},
								}
							});
						});

						// 완료 버튼 클릭 시 
						$("#fboardCom").on("click", function () {
							event.preventDefault(); // 기본 동작 막기

							// 썸머노트 내용을 숨겨진 필드에 복사
							$("#hiddenC").val($(".detailCen").summernote('code'));
							$("#hiddenT").val($(".topTitle").html().trim());


							// 제목과 내용 값 가져오기
							let title = $("#hiddenT").val().trim(); // 제목 공백 제거
							let contentHtml = $("#hiddenC").val(); // HTML 코드 가져오기
							let contentText = $('<div>').html(contentHtml).text().trim(); // HTML 태그를 제거하고 텍스트만 추출

							// 제목과 내용 유효성 검사
							if (title === '') {
								alert("제목을 입력해 주세요.");
								return;
							}
							if (title.length > 25) {
								alert("최대 제목 길이를 초과했습니다.");
								return;
							}
							if (contentText === '') {
								alert("내용을 입력해 주세요.");
								return;
							}
							if (contentHtml.length > 1000) {
								alert("최대 내용 길이를 초과했습니다.");
								return;
							}


							// if (title === '') {
							// 	alert("제목을 입력해 주세요.");
							// }
							// else if (title.length > 25) {
							// 	alert("최대 제목 길이를 초과했습니다.");
							// }
							// else if (contentText === '') {
							// 	alert("내용을 입력해 주세요.");
							// }
							// else (contentHtml.length > 1000) {
							// 	alert("최대 내용 길이를 초과했습니다.");
							// }


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

							cancel.parent().parent().find(".replyPrint").attr("contenteditable", false);
							location.reload()
						})


						// 댓글 수정 완료 버튼 클릭 시
						$(".updateRly").on("click", function (e) {
							// 댓글 글자 수 제한 함수
							// limitReplyLength();
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
								complete.parent().parent().find(".replyPrint").attr("contenteditable", false);
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

					// 신고현황 클릭 시
					$(".reportList").on("click", function () {
						window.location.href = "/board/list?adminReport=true";
					});

					// 댓글 이미지 보이기
					$(document).ready(function () {
						$.ajax({
							url: '/employee/getSessionInfo',
							type: 'GET',
							success: function (response) {
								// 로그인 정보가 성공적으로 불러와졌을 때
								if (response.photo) {
									$('.myImgBox img').attr('src', response.photo);
								}
							},
							error: function (xhr, status, error) {
								console.error('AJAX Error:', status, error);
							}
						});
					});

					// // 댓글 글자 수 제한 함수
					// function limitReplyLength() {
					// 	const maxLength = 900

					// 	// 댓글 작성 시
					// 	$('.writeRly').on('input', function () {
					// 		if ($(this).val().length > maxLength) {
					// 			$(this).val($(this).val().slice(0, maxLength))
					// 			alert('900자를 초과할 수 없습니다.')
					// 		}
					// 	})

					// 	// 댓글 수정 시
					// 	$('.replyPrint').on('input', function () {
					// 		if ($(this).text().length > maxLength) {
					// 			$(this).text($(this).text().slice(0, maxLength))
					// 			alert('900자를 초과할 수 없습니다.')
					// 		}
					// 	})
					// }


					$(document).ready(function () {
						// 댓글 작성 시
						$('.writeRly').on('input', function () {
							limitReplyLength(this);
						});

						// 댓글 완료시
						$("#replyInst").on("click", function () {
							if ($(".writeRly").val().length > 0) {
								$("#replyInsertForm").submit();
							}
							else {
								alert('댓글 내용을 입력하세요.');
							}

						})

						// 댓글 수정 시
						$(document).on('input', '.replyPrint', function () {
							limitReplyLength(this);
						});

						function limitReplyLength(element) {
							const maxLength = 900;
							let value;

							if ($(element).is('.writeRly')) {
								value = $(element).val();
							} else if ($(element).is('.replyPrint')) {
								value = $(element).text();
							}

							if (value.trim().length === 0) {
								alert('공백만 입력할 수 없습니다.');
								return;
							}

							if (value.length > maxLength) {
								if ($(element).is('.writeRly')) {
									$(element).val(value.slice(0, maxLength));
								} else if ($(element).is('.replyPrint')) {
									$(element).text(value.slice(0, maxLength));
								}
								alert('900자를 초과할 수 없습니다.');
							}
						}
					});

				</script>
			</body>

			</html>