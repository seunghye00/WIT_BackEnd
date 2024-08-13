<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="/css/style.main.css">
<link rel="stylesheet" href="/css/wit.css">
<script defer src="/js/hsh.js"></script>
<script defer src="/js/wit.js"></script>
</head>
<body>
    <div class="container">
		<%@ include file="/WEB-INF/views/Includes/sideBar.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
               <%@ include file="/WEB-INF/views/Reservation/commons/sideToggle.jsp"%>
                <div class="sideContents reservation">
                    <div class="mainTitle">예약 관리 홈</div>
                    <div class="reservList">
                        <div class="subTitle">나의 예약 현황</div>
                        <div class="toolBar">
                            <ul>
                                <li>
                                    <a href="javascript:;" class="active">회의실</a>
                                </li>
                                <li>
                                    <a href="javascript:;">차량</a>
                                </li>
                            </ul>
                            <div class="searchBox">
                                <input type="text" placeholder="검색">
                                <button class="searchBtn">
                                    <i class="bx bx-search"></i>
                                </button>
                            </div>
                        </div>
                        <div class="listBox">
                            <div class="rows listHeader">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>회의실</span>
                                </div>
                                <div class="cols">
                                    <span>1층 회의실 회의실1</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>2024-07-27 10:00 ~ 2024-07-27 11:00</span>
                                </div>
                                <div class="cols">
                                    <span>미반납</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>분류</span>
                                </div>
                                <div class="cols">
                                    <span>항목</span>
                                </div>
                                <div class="cols">
                                    <span>예약 목적</span>
                                </div>
                                <div class="cols">
                                    <span>예약 기간</span>
                                </div>
                                <div class="cols">
                                    <span>반납 여부</span>
                                </div>
                            </div>
                        </div>
                        <div class="pagination">
                            <a href="javascript:;" class="prev"><i class='bx bx-chevron-left'></i></a>
                            <a href="javascript:;" class="active">1</a>
                            <a href="javascript:;">2</a>
                            <a href="javascript:;">3</a>
                            <a href="javascript:;">4</a>
                            <a href="javascript:;">5</a>
                            <a href="javascript:;" class="next active"><i class='bx bx-chevron-right'></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>