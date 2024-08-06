<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<div id="container">
		<div class="sideBar">
			<div class="top">
				<i class="bx bx-menu" id="btn"></i>
			</div>
			<div class="user">
				<div class="nickName">
					<p class="bold">Wit Works</p>
				</div>
			</div>

			<ul>
				<li><a href="/"> <i class='bx bxs-home-alt-2'></i> <span
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

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<span class="myName"><a href="/employee/mypage">${employee.name}
						${employee.role_code}</a></span> <span class="logOut"><a
					href="/employee/logout">LogOut</a></span>
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
					<div class="mainTitle">자유게시판 상세</div>
					<div class="boardDetail">
						<div class="detail">
							<div class="detailTop">
								<div class="top">
									<div class="topTitle">${board.title}</div>
									<div class="topFile">
										<i class='bx bx-star'></i> <i class='bx bx-file-blank'></i>
									</div>
								</div>
								<div class="top">
									<div class="writeAbout">
										<span>${board.emp_no}</span> <span><fmt:formatDate
												value="${board.write_date}" pattern="yyyy-MM-dd" /></span> <span><i
											class="fa-regular fa-eye"></i> ${board.views}</span>
									</div>
									<div class="writeReport">
										<button id="reportBtn">
											<i class='bx bx-message-alt-error'></i> 신고하기
										</button>
									</div>
								</div>
							</div>
							<div class="detailCen">${board.contents}</div>
							<div class="detailBott">
								<!-- 수정 및 삭제버튼 jstl 사용! -->
								<c:if test="${board.emp_no eq Nickname}">
									<button type="button" class="btn btn-outline-success"
										id="fboardUpd">수정</button>
									<button type="button" class="btn btn-outline-success"
										id="fboardDel" onclick="deleteBoard(${board.board_seq})">삭제</button>
								</c:if>
								<button type="button" class="btn btn-outline-primary"
									onclick="location.href='/board/list'">목록으로</button>
							</div>
						</div>

						<!-- 나중에 이부분 지워야해 밍쥬~ -->
						<!-- 나중에는 파일 아이콘? 클릭했을때 밑으로 내려오게끔 하기로 했으니깐! -->
						<div class="files">
							<h4>첨부 파일</h4>
							<c:forEach var="file" items="${files}">
									${file.oriname}
							</c:forEach>
						</div>

						<div class="replyWrapper">
							<span class="replyTxt"><i class='bx bx-message-alt-dots'></i>
								댓글 달기</span>
							<div class="reply">
								<div class="replyCont">
									<textarea class="writeRly" contenteditable="true"
										placeholder="입력가능한 글자수는 최대 300자임~"></textarea>
								</div>
								<div class="replyBtn">
									<button type="button" class="btn btn-outline-secondary"
										id="replyInst">작성하기</button>
								</div>
							</div>

							<div class="replyCount">
								<span>댓글 수 : </span><span>0</span>
							</div>

							<div class="replyList">
								<c:forEach var="reply" items="${replies}">
									<div class="replyTxt">
										<img src="../images/프로필.jpg" alt=""> <span>${reply.emp_no}</span>
										<span class="replyDate"><fmt:formatDate
												value="${reply.write_date}" pattern="yyyy-MM-dd" /></span>
									</div>
									<div class="reply">
										<div class="replyPrint">${reply.contents}</div>
										<div class="replyBtn">
											<img src="../images/pen-to-square-solid.svg" alt=""> <img
												src="../images/trash-solid.svg" alt="">
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>

				<div id="modal" class="dialog">
					<div class="tb">
						<div class="inner">
							<div class=" top">
								<div class="title">신고하기</div>
							</div>
							<div class="ct">
								<div class="reporter">
									<div class="reportNick">신고자 닉네임</div>
									<input class="reportInput"></input>
								</div>
								<div class="reportSort">
									<div class="sort">신고 사유</div>
									<div class="selectSort">
										<select class="form-select form-select-sm"
											aria-label="Small select example">
											<option selected>욕설 및 비방</option>
											<option value="1">스팸 및 광고</option>
											<option value="2">음란물 및 부적절한 콘텐츠</option>
										</select>
									</div>
								</div>
							</div>
							<div class="reportControls">
								<a href="#" class="rClose">
									<button type="button" class="btn btn-primary" id="reportClose"
										onclick="closeModal()">닫기</button>
								</a> <a href="#">
									<button type="button" class="btn btn-danger" id="report">신고하기</button>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
    function deleteBoard(boardSeq) {
        if (confirm("정말로 삭제하시겠습니까?")) {
            // 사용자에게 삭제 확인을 받았을 때만 삭제 요청
            location.href = "/board/delete?board_seq=" + boardSeq;
        }
    }

    console.log("Login ID: ${Nickname}");
    console.log("Board emp_no: ${board.emp_no}");

</script>

</body>
</html>
