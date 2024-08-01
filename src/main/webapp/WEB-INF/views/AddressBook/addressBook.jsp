<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<script defer src="/resources/js/mky.js"></script>
<style>
#results {
	display: flex;
	flex-direction: column;
	flex: 1;
}
</style>
</head>
<body>
	<div class="container">
		<div class="sideBar">
			<div class="top">
				<i class="bx bx-menu" id="btn"></i>
			</div>
			<div class="user">
				<img src="../images/logo/WIT_logo1.png" alt="logo" class="userImg">
				<div class="nickName">
					<p class="bold">Wit Works</p>
					<p></p>
				</div>
			</div>
			<ul>
				<li><a href="#"> <i class='bx bxs-home-alt-2'></i> <span
						class="navItem">홈</span></a> <span class="toolTip">홈</span></li>
				<li><a href="#"> <i class='bx bx-paperclip'></i> <span
						class="navItem">주소록</span></a> <span class="toolTip">주소록</span></li>
				<li><a href="board2.html"> <i class="bx bxs-grid-alt"></i>
						<span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
				<li><a href="#"> <i class='bx bx-calendar-alt'></i> <span
						class="navItem">캘린더</span></a> <span class="toolTip">캘린더</span></li>
				<li><a href="#"> <i class='bx bxs-message-dots'></i> <span
						class="navItem">메신저</span></a> <span class="toolTip">메신저</span></li>
				<li><a href="#"> <i class='bx bx-clipboard'></i> <span
						class="navItem">전자결재</span></a> <span class="toolTip">전자결재</span></li>
				<li><a href="#"> <i class='bx bxs-briefcase-alt-2'></i> <span
						class="navItem">근태관리</span></a> <span class="toolTip">근태관리</span></li>
				<li><a href="#"> <i class='bx bxs-check-square'></i> <span
						class="navItem">예약</span></a> <span class="toolTip">예약</span></li>
				<li><a href="#"> <i class='bx bx-sitemap'></i> <span
						class="navItem">조직도</span></a> <span class="toolTip">조직도</span></li>
			</ul>
		</div>

		<div class="main-content">
			<div class="header">
				<span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
				<span class="myName"> <img src="../images/프로필.jpg"><a
					href="#">문경원 부장</a></span> <span class="logOut"><a href="#">LogOut</a></span>
			</div>
			<div class="contents">
				<div class="sideAbout">
					<div class="sideTxt">
						<h2 class="sideTit">주소록</h2>
					</div>
					<div class="sideBtnBox">
						<button class="plusBtn sideBtn" onclick="openAddContactPopup()">연락처
							추가</button>
					</div>
					<div class="addressListPrivate">
						<ul class="privateList">
							<li class="toggleItem">
								<h3 class="toggleTit">개인 주소록</h3>
								<ul class="subList">
									<li><a href="javascript:;" class="active">전체</a></li>
									<li><a href="javascript:;">주 거래처</a></li>
									<li><a href="javascript:;">스터디</a></li>
									<li class="newList"><a href="javascript:;"><i
											class='bx bx-plus-medical'></i><span>연락처 주소록</span> 추가</a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="addressListGroup">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggleTit">그룹 주소록</h3>
								<ul class="subList">
									<li><a href="javascript:;">전체</a></li>
									<li><a href="javascript:;">인사부</a></li>
									<li><a href="javascript:;">영업부</a></li>
									<li><a href="javascript:;">IT부</a></li>
									<li><a href="javascript:;">마케팅부</a></li>
									<li><a href="javascript:;">기술지원부</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div class="sideContents addressCont">
					<div class="mainTitle addressTit">전체 주소록</div>
					<div class="searchBox">
						<input type="text" placeholder="검색">
						<button class="searchBtn">
							<i class='bx bx-search'></i>
						</button>
					</div>
					<div class="tableCont">
						<div class="toolBar">
							<ul>
								<li><a href="javascript:;" class="active">전체</a></li>
								<li><a href="javascript:;">ㄱ</a></li>
								<li><a href="javascript:;">ㄴ</a></li>
								<li><a href="javascript:;">ㄷ</a></li>
								<li><a href="javascript:;">ㄹ</a></li>
								<li><a href="javascript:;">ㅁ</a></li>
								<li><a href="javascript:;">ㅂ</a></li>
								<li><a href="javascript:;">ㅅ</a></li>
								<li><a href="javascript:;">ㅇ</a></li>
								<li><a href="javascript:;">ㅈ</a></li>
								<li><a href="javascript:;">ㅊ</a></li>
								<li><a href="javascript:;">ㅋ</a></li>
								<li><a href="javascript:;">ㅌ</a></li>
								<li><a href="javascript:;">ㅍ</a></li>
								<li><a href="javascript:;">ㅎ</a></li>
								<li><a href="javascript:;">a-z</a></li>
								<li><a href="javascript:;">0-9</a></li>
							</ul>
							<button class="deleteBtn">
								<i class='bx bx-trash'></i>
							</button>
						</div>
						<div class="listBox">
							<div class="rows listHeader">
								<div class="cols">
									<input type="checkbox" id="checkAll">
								</div>
								<div class="cols">
									<span>이름</span>
								</div>
								<div class="cols">
									<span>휴대폰</span>
								</div>
								<div class="cols">
									<span>이메일</span>
								</div>
								<div class="cols">
									<span>그룹</span>
								</div>
							</div>
							<div id="results">
								<c:forEach var="item" items="${addressBookList}">
									<div class="rows" onclick="handleRowClick(event, this)">
										<div class="cols">
											<span><input type="checkbox" class="individual"></span>
										</div>
										<div class="cols">
											<span>${item.name}</span>
										</div>
										<div class="cols">
											<span>${item.phone}</span>
										</div>
										<div class="cols">
											<span>${item.email}</span>
										</div>
										<div class="cols">
											<span>${item.category}</span>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="pagination" id="pagination"></div>
				</div>
			</div>
		</div>
	</div>
	<div id="popupModal" class="modal">
		<div class="modal-content">
			<div class="popTit" id="popupTitle"></div>
			<form class="addressForm" id="addressForm">
				<div class="formBox">
					<div class="leftForm">
						<div class="formGroup">
							<label for="photo">사진</label>
							<div class="photoWrapper">
								<img src="placeholder.jpg" alt="사진" id="photo">
								<button type="button" onclick="removePhoto()">삭제</button>
								<input type="file" id="photoUpload" accept="image/*"
									onchange="previewPhoto(event)"> <label
									for="photoUpload">등록</label>
							</div>
						</div>
						<div class="formGroup">
							<label for="name">이름</label> <input type="text" id="name"
								name="name">
						</div>
						<div class="formGroup">
							<label for="company">회사</label> <input type="text" id="company"
								name="company">
						</div>
						<div class="formGroup">
							<label for="group">그룹</label> <input type="text" id="group"
								name="group">
						</div>
					</div>
					<div class="rightForm">
						<div class="formGroup">
							<label for="position">직위</label> <input type="text" id="position"
								name="position">
						</div>
						<div class="formGroup">
							<label for="email">이메일</label> <input type="text" id="email"
								name="email">
						</div>
						<div class="formGroup">
							<label for="phone">휴대폰</label> <input type="text" id="phone"
								name="phone">
						</div>
						<div class="formGroup">
							<label for="address">주소</label> <input type="text" id="address"
								name="address">
						</div>
					</div>
				</div>
				<div class="actions">
					<button type="button" class="save">저장</button>
					<button type="button" class="delete" style="display: none;">삭제</button>
					<button type="button" onclick="closePopup()">목록</button>
				</div>
			</form>
		</div>
	</div>

	<script>
        let btn = document.querySelector("#btn")
        let sideBar = document.querySelector(".sideBar")

        btn.onclick = function () {
            sideBar.classList.toggle("active")
        };

        // 페이지네이션 스크립트
        let pageNation = $("#pagination");
        let cpage = 1;
        let record_total_count = 53;
        let record_count_per_page = 10;
        let navi_count_per_page = 5;
        let pageTotalCount = 0;
        if (record_total_count % record_count_per_page > 0) {
            pageTotalCount = record_total_count / record_count_per_page + 1;
        } else {
            pageTotalCount = record_total_count / record_count_per_page;
        }        
        // 네비게이터의 시작 값
        let startNavi = Math.floor(( cpage - 1 ) / navi_count_per_page) * navi_count_per_page + 1;
        // 네비게이터의 끝 값 
        let endNavi = startNavi + navi_count_per_page - 1;
                
        if (endNavi > pageTotalCount) {
            endNavi = pageTotalCount;
        }
                
        let needNext = true;
        let needPrev = true;
                
        if(startNavi == 1) {
            needPrev = false;
        }
                
        if(endNavi == pageTotalCount) {
            needNext = false;
        }
                
        if(needPrev) {pageNation.append("<a href='/addressbook/addressbook?cpage=" + (startNavi-1) +"'><i class='bx bx-chevron-left'></i></a>");}        
        for(let i = startNavi; i <= endNavi; i++) {
            if(cpage == i) {
                pageNation.append("<a class='active' href='/addressbook/addressbook?cpage="+i+"'>" + i + "</a> ");
            } else {
                pageNation.append("<a href='/addressbook/addressbook?cpage="+i+"'>" + i + "</a> ");
            }
        }
        if(needNext) {
            pageNation.append("<a href='/addressbook/addressbook?cpage=" + (endNavi+1) +"'><i class='bx bx-chevron-right'></i></a>");
        }  
        
        $(document).ready(function() {
            $('.toolBar a').click(function(event) {
                event.preventDefault(); // 기본 동작을 막고 AJAX 호출 수행

                $('.toolBar a').removeClass('active');
                $(this).addClass('active');

                var chosung = $(this).text();
                if (chosung === '전체') {
                    chosung = ''; // 전체를 선택하면 빈 문자열로 검색
                }

                console.log("Chosen category:", chosung);

                $.ajax({
                    url: '/addressbook/addressTool',
                    type: 'GET',
                    data: { chosung: chosung },
                    dataType: 'json',
                    success: function(response) {
                        console.log("Server response:", response);
                        var data = response.addressBookList;
                        $('#results').empty();
                        if (Array.isArray(data)) {
                            data.forEach(function(contact) {
                                var $row = $('<div>', {
                                    class: 'rows',
                                    onclick: 'handleRowClick(event, this)'
                                });

                                var $colCheckbox = $('<div>', { class: 'cols' }).append($('<span>').append($('<input>', { type: 'checkbox', class: 'individual' })));
                                var $colName = $('<div>', { class: 'cols' }).append($('<span>').text(contact.name || ''));
                                var $colPhone = $('<div>', { class: 'cols' }).append($('<span>').text(contact.phone || ''));
                                var $colEmail = $('<div>', { class: 'cols' }).append($('<span>').text(contact.email || ''));
                                var $colCategory = $('<div>', { class: 'cols' }).append($('<span>').text(contact.category || ''));

                                $row.append($colCheckbox, $colName, $colPhone, $colEmail, $colCategory);
                                $('#results').append($row);
                            });
                        } else {
                            console.error('Response does not contain a valid addressBookList:', response);
                            alert('Failed to fetch data: Invalid response format.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', status, error);
                        console.error('Response Text:', xhr.responseText);
                        alert('Failed to fetch data.');
                    }
                });
            });
        });
        console.log("Results HTML:", $('#results').html());

    </script>
</body>
</html>
