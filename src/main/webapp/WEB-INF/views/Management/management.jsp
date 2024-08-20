<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script defer src="/resources/js/mky.js"></script>
</head>
<body>
<div class="container">
        <%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp" %>
        <div class="main-content">
            <%@ include file="/WEB-INF/views/Includes/header.jsp" %>
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <h2 class="sideTit">사원관리</h2>
                    </div>
                    <div class="addressListPrivate">
                        <ul class="privateList">
                            <li class="toggleItem">
                            	<a href="javascript:;"> <h3 class="addressTit">사원 정보 관리</h3></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="sideContents addressCont">
		            <form action="/employee/manageSearch" id="searchForm" class="manageForm">
						<div class="mainTitle addressTit">사원 정보 관리</div>
						<div class="manageTool">
							<div class="search">
								<select name="column">
									<option selected value="NAME">이름</option>
									<option value="EMP_NO">사번</option>
								</select>
								<div class="searchBox">
									<input type="text" id="searchInput" placeholder="검색" name="keyword">
									<button class="searchBtn" id="searchBtn" type="submit">
										<i class='bx bx-search'></i>
									</button>
								</div>
							</div>
							<div class="regiBtn">
								<button type="button" onclick="window.location.href='/employee/register_form'">
									신규 사원 등록
								</button>	
							</div>
						</div>
						<div class="tableCont">
	                        <div class="listBox">
	                            <div class="rows listHeader">
	                                <div class="cols">
	                                    <span>사번</span>
	                                </div>
	                                <div class="cols">
	                                    <span>이름</span>
	                                </div>
	                                <div class="cols">
	                                    <span>부서</span>
	                                </div>
	                                <div class="cols">
	                                    <span>직급</span>
	                                </div>
	                                <div class="cols">
	                                    <span>입사일</span>
	                                </div>
	                                <div class="cols">
	                                    <span>퇴사일</span>
	                                </div>
	                            </div>
	                            <div id="results">
		                            <c:forEach var="list" items="${manageList}">
									    <div class="rows" onclick="handleRowClick(event, this)" data-seq="${list.EMP_NO}">
									        <div class="cols">
									            <span>${list.EMP_NO}</span>
									        </div>
									        <div class="cols">
									            <span>${list.NAME}</span>
									        </div>
									        <div class="cols">
									            <span>${list.DEPT_TITLE}</span>
									        </div>
									        <div class="cols">
									            <span>${list.ROLE_TITLE}</span>
									        </div>
									        <div class="cols">
									            <span>${list.JOIN_DATE}</span>
									        </div>
									        <div class="cols">
									            <span>${list.QUIT_DATE}</span>
									        </div>
									    </div>
									</c:forEach>
								</div>
	                        </div>
	                    </div>
	                    <div class="pagination" id="pagination"></div>
		            </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
	//페이징
	$(document).ready(function(){
		loadPage();
		$('#searchForm').off('submit').on('submit', handleSearchFormSubmit);
	})
	
	function loadPage(params = { cpage: 1 }, url = '/employee/manageLoad') {
        $.ajax({
            url: url,
            type: 'GET',
            data: params,
            dataType: 'json',
            success: function(response) {
                var data = response.manageList;
                $('#results').empty();
                if (Array.isArray(data) && data.length > 0) {
                    data.forEach(function(contact) {
                        var $row = $('<div>', {
                            class: 'rows',
                            onclick: 'handleRowClick(event, this)',
                            'data-seq': contact.EMP_NO
                        });
                        var $colEmpNo = $('<div>', { class: 'cols' }).append($('<span>').text(contact.EMP_NO || ''));
                        var $colName = $('<div>', { class: 'cols' }).append($('<span>').text(contact.NAME || ''));
                        var $colDeptTitle = $('<div>', { class: 'cols' }).append($('<span>').text(contact.DEPT_TITLE || ''));
                        var $colRoleTitle = $('<div>', { class: 'cols' }).append($('<span>').text(contact.ROLE_TITLE || ''));
                        var $colJoinDate = $('<div>', { class: 'cols' }).append($('<span>').text(contact.JOIN_DATE || ''));
                        var $colQuitDate = $('<div>', { class: 'cols' }).append($('<span>').text(contact.QUIT_DATE || ''));

                        $row.append($colEmpNo, $colName, $colDeptTitle, $colRoleTitle, $colJoinDate, $colQuitDate);
                        $('#results').append($row);
                    });
                } else {
                    $('#results').append('<div class="noData">데이터 없음</div>');
                }

                let pageNation = $("#pagination");
                pageNation.empty();
                let cpage = response.cpage;
                let record_total_count = response.totPage;
                let record_count_per_page = response.recordCountPerPage;
                let navi_count_per_page = response.naviCountPerPage;
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
                        column: $('select[name="column"]').val()
                    };
                    loadPage(params, url);
                });
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                console.error('Response Text:', xhr.responseText);
                alert('Failed to fetch data.');
            }
        });
    }
	function handleSearchFormSubmit(event) {
	    event.preventDefault();
	    var keyword = $('#searchInput').val();
	    var column = $('select[name="column"]').val();
	    loadPage({ keyword: keyword, column: column, cpage: 1 }, '/employee/manageSearch');
	}
	
	function handleRowClick(event, element) {
	    var empNo = $(element).data('seq');
	    if (empNo) {
	        // managementDetail.jsp로 이동하면서 empNo를 파라미터로 전달
	        window.location.href = '/employee/managementDetail?empNo=' + empNo;
	    } else {
	        alert('해당 사원의 정보를 가져올 수 없습니다.');
	    }
	}
</script>
</html>