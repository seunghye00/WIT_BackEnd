<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹 주소록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script defer src="/resources/js/mky.js"></script>
</head>
<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>
        <div class="main-content">
            <%@ include file="/WEB-INF/views/Includes/header.jsp" %>	
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <h2 class="sideTit">주소록</h2>
                    </div>
                    <div class="addressListPrivate">
                        <ul class="privateList">
                            <li class="toggleItem">
                            	<a href="/addressbook/addressbook"> <h3 class="addressTit">개인 주소록</h3></a>
                            </li>
                        </ul>
                    </div>
                    <div class="addressListGroup">
                        <ul class="GroupList">
                            <li class="toggleItem">
                                <h3 class="toggleTit active">그룹 주소록</h3>
                                <ul class="subList active">
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="sideContents addressCont">
                    <div class="mainTitle addressTit">전체 주소록</div>
                    <form class="searchBox" id="searchForm" action="/employee/search">
                        <input type="text" id="searchInput" placeholder="검색" name="keyword">
                        <button class="searchBtn" type="submit" >
                            <i class='bx bx-search'></i>
                        </button>
                    </form>
                    <div class="tableCont">
                        <div class="toolBar">
                            <ul>
                                <li><a href="javascript:;" class="active" onclick="loadPage({chosung: '', category: currentCategory, cpage: 1})">전체</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄱ', category: currentCategory, cpage: 1})">ㄱ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄴ', category: currentCategory, cpage: 1})">ㄴ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄷ', category: currentCategory, cpage: 1})">ㄷ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄹ', category: currentCategory, cpage: 1})">ㄹ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅁ', category: currentCategory, cpage: 1})">ㅁ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅂ', category: currentCategory, cpage: 1})">ㅂ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅅ', category: currentCategory, cpage: 1})">ㅅ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅇ', category: currentCategory, cpage: 1})">ㅇ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅈ', category: currentCategory, cpage: 1})">ㅈ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅊ', category: currentCategory, cpage: 1})">ㅊ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅋ', category: currentCategory, cpage: 1})">ㅋ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅌ', category: currentCategory, cpage: 1})">ㅌ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅍ', category: currentCategory, cpage: 1})">ㅍ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅎ', category: currentCategory, cpage: 1})">ㅎ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'a-z', category: currentCategory, cpage: 1})">a-z</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: '0-9', category: currentCategory, cpage: 1})">0-9</a></li>
                            </ul>
                        </div>
                        <div class="listBox">
                            <div class="rows listHeader">
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
                                <c:forEach var="item" items="${addressBookGroupList}">
								    <div class="rows" onclick="handleRowClick(event, this) data-empno="${item.EMP_NO}">
								        <div class="cols">
								            <span>${item.NAME}</span>
								        </div>
								        <div class="cols">
								            <span>${item.PHONE}</span>
								        </div>
								        <div class="cols">
								            <span>${item.EMAIL}</span>
								        </div>
								        <div class="cols">
								            <span>${item.DEPT_TITLE}</span>
								        </div>
								    </div>
								</c:forEach>
                                <c:if test="${empty addressBookGroupList}">
                                    <div class="noData">데이터 없음</div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="pagination" id="pagination"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- 그룹 주소록 상세 조회 -->
	<div id="viewContactModal" class="modal">
	    <div class="modal-content">
	        <div class="popTit">연락처 조회</div>
	        <div class="formBox">
	            <div class="leftForm">
	                <div class="formGroup">
	                    <label for="viewPhoto">사진</label>
	                    <div class="photoWrapper">
	                        <img src="placeholder.jpg" alt="사진" id="viewPhoto">
	                    </div>
	                </div>
	                <div class="formGroup">
	                    <label for="viewName">이름</label> 
	                    <span id="viewName"></span>
	                </div>
	                <div class="formGroup">
	                    <label for="viewDept">그룹</label> 
	                    <span id="viewDept"></span>
	                </div>
	            </div>
	            <div class="rightForm">
	                <div class="formGroup">
	                    <label for="viewPosition">직위</label> 
	                    <span id="viewPosition"></span>
	                </div>
	                <div class="formGroup">
	                    <label for="viewEmail">이메일</label> 
	                    <span id="viewEmail"></span>
	                </div>
	                <div class="formGroup">
	                    <label for="viewPhone">휴대폰</label> 
	                    <span id="viewPhone"></span>
	                </div>
	                <div class="formGroup">
	                    <label for="viewAddress">주소</label> 
	                    <span id="viewAddress"></span>
	                </div>
	            </div>
	        </div>
	        <div class="actions">
	            <button type="button" onclick="closePopup('viewContactModal')">목록</button>
	        </div>
	    </div>
	</div>
    <script>
    let btn = document.querySelector("#btn")
    let sideBar = document.querySelector(".sideBar")
    let currentChosung  = '전체';
    let currentCategory = '전체';
    
    btn.onclick = function () {
        sideBar.classList.toggle("active");
    };
    
    $(document).ready(function() {
    	loadCategoriesGroup();
        $('.toolBar a').off('click').on('click', handleToolBarClick);
        $('#searchForm').off('submit').on('submit', handleSearchFormSubmit);
    });
   
    function loadGroupPage(params = { cpage: 1 }, url = '/employee/groupAddressTool') {
        $.ajax({
            url: url,
            type: 'GET',
            data: params,
            dataType: 'json',
            success: function(response) {
                var data = response.addressBookGroupList;
                $('#results').empty();
                if (Array.isArray(data) && data.length > 0) {
                    data.forEach(function(contact) {
                    	console.log(contact);
                        var $row = $('<div>', {
                            class: 'rows',
                            onclick: 'handleRowClick(this)',
                            'data-empno': contact.EMP_NO
                        });
                        var $colName = $('<div>', { class: 'cols' }).append($('<span>').text(contact.NAME || ''));
                        var $colPhone = $('<div>', { class: 'cols' }).append($('<span>').text(contact.PHONE || ''));
                        var $colEmail = $('<div>', { class: 'cols' }).append($('<span>').text(contact.EMAIL || ''));
                        var $colDept = $('<div>', { class: 'cols' }).append($('<span>').text(contact.DEPT_TITLE || ''));

                        $row.append($colName, $colPhone, $colEmail, $colDept);
                        $('#results').append($row);
                    });
                } else {
                    $('#results').append('<div class="noData">데이터 없음</div>');
                }

                let pageNation = $("#pagination");
                pageNation.empty();

                let cpage = response.cpage;
                let record_total_count = response.totPage;
                let record_count_per_page = 10;
                let navi_count_per_page = 5;
                let pageTotalCount = Math.ceil(record_total_count / record_count_per_page);

                let startNavi = Math.floor((cpage - 1) / navi_count_per_page) * navi_count_per_page + 1;
                let endNavi = startNavi + navi_count_per_page - 1;

                if (endNavi > pageTotalCount) {
                    endNavi = pageTotalCount;
                }

                let needPrev = cpage > 1;
                let needNext = cpage < pageTotalCount;

                pageNation.append("<a href='#' class='prev " + (needPrev ? "active" : "disabled") + "' data-page='" + (cpage - 1) + "'><i class='bx bx-chevron-left'></i></a>");
                
                for (let i = startNavi; i <= endNavi; i++) {
                    if (cpage == i) {
                        pageNation.append("<a class='active' href='#' data-page='" + i + "'>" + i + "</a> ");
                    } else {
                        pageNation.append("<a href='#' data-page='" + i + "'>" + i + "</a> ");
                    }
                }

                pageNation.append("<a href='#' class='next " + (needNext ? "active" : "disabled") + "' data-page='" + (cpage + 1) + "'><i class='bx bx-chevron-right'></i></a>");

                $('#pagination a').click(function(event) {
                    event.preventDefault();
                    if ($(this).hasClass('disabled')) {
                        return;
                    }
                    var page = $(this).data('page');
                    var params = {
                        cpage: page,
                        keyword: $('#searchInput').val(),
                        chosung: currentChosung,
                        category: currentCategory
                    };
                    loadGroupPage(params, url);
                });
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                console.error('Response Text:', xhr.responseText);
                alert('Failed to fetch data.');
            }
        });
    }
    
	// 주소록 ajax 검색과 툴바 
	function handleToolBarClick(event) {
	    event.preventDefault();
	    var chosung = $(this).text();
	    if (chosung === '전체') {
	        chosung = '';
	    }
	    currentChosung = chosung;
	    $('.toolBar a').removeClass('active');
	    $(this).addClass('active');
	    loadGroupPage({ chosung: chosung, cpage: 1, category: currentCategory }, '/employee/groupAddressTool');
	}
	
	function handleSearchFormSubmit(event) {
	    event.preventDefault();
	    var keyword = $('#searchInput').val();
	    $('.toolBar a').removeClass('active');
	    $('.toolBar a:first').addClass('active');
	    currentChosung = '전체';
	    loadGroupPage({ keyword: keyword, cpage: 1 }, '/employee/search');
	}
	
	// 카테고리 
    function loadCategoriesGroup() {
        $.ajax({
            url: '/employee/getCategories',
            type: 'GET',
            dataType: 'json',
            success: function(categories) {
            	console.log(categories);
                let categoryList = $('.GroupList .subList');
                categoryList.empty();
                categoryList.append('<li><a href="javascript:;" onclick="loadCategoryData(\'전체\')" class="active">전체</a></li>');
                categories.forEach(function(category) {
                    categoryList.append('<li><a href="javascript:;" onclick="loadCategoryData(\'' + category.DEPT_TITLE + '\')">' + category.DEPT_TITLE + '</a></li>');
                });
                loadGroupPage();
            },
            error: function(xhr, status, error) {
                console.error('Failed to load categories:', status, error);
            }
        });
    }

	function loadCategoryData(category) {
        currentCategory = category;
        $('.mainTitle').text(category + " 주소록");
        $('.subList a').removeClass('active');
        $('.subList a').each(function() {
            if ($(this).text() === category) {
                $(this).addClass('active');
            }
        });
        loadGroupPage({ category: category, cpage: 1, chosung: currentChosung }, '/employee/groupAddressTool');
    }
	
	// 주소록 상세 조회
	function fillViewForm(contact) {
		console.log(contact);
	    document.getElementById('viewName').textContent = contact.NAME !== null && contact.NAME !== undefined ? contact.NAME : '-';
	    document.getElementById('viewPhone').textContent = contact.PHONE !== null && contact.PHONE !== undefined ? contact.PHONE : '-';
	    document.getElementById('viewEmail').textContent = contact.EMAIL !== null && contact.EMAIL !== undefined ? contact.EMAIL : '-';
	    document.getElementById('viewDept').textContent = contact.DEPT_TITLE !== null && contact.DEPT_TITLE !== undefined ? contact.DEPT_TITLE : '-';
	    document.getElementById('viewPosition').textContent = contact.ROLE_TITLE !== null && contact.ROLE_TITLE !== undefined ? contact.ROLE_TITLE : '-';
	    document.getElementById('viewAddress').textContent = contact.ADDRESS !== null && contact.ADDRESS !== undefined ? contact.ADDRESS : '-';
	
	    /* if (contact.photo && contact.photo !== 'default.jpg') {
	        const encodedPhoto = encodeURIComponent(contact.photo);
	        document.getElementById('viewPhoto').src = '/uploads/' + encodedPhoto;
	    } else {
	        document.getElementById('viewPhoto').src = '';
	    } */
	
	    document.getElementById('viewContactModal').style.display = 'block';
	}
	
	function fetchContactDetails(emp_no) {
	    $.ajax({
	        url: '/employee/getContactDetails',
	        type: 'GET',
	        data: { emp_no: emp_no },
	        dataType: 'json',
	        success: function(contact) {
	            console.log('Fetched contact details:', contact);
	            fillViewForm(contact);
	        },
	        error: function(xhr, status, error) {
	            console.error('Failed to fetch contact details:', status, error);
	            console.log('Sent emp_no:', emp_no);
	            alert('Failed to fetch contact details.');
	        }
	    });
	}
	
	function handleRowClick(row) {    
	        let emp_no = row.getAttribute('data-empno');
	        console.log('Selected emp_no:', emp_no);
	        fetchContactDetails(emp_no);	
	}
	
	function closePopup(modalId) {
	    var modal = document.getElementById(modalId);
	    modal.style.display = 'none';
	}
    </script>
</body>
</html>
