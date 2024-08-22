<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.global.min.js"></script>
<script defer src="/js/wit.js"></script>
<script defer src="/js/reservHome.js"></script>
</head>
<body>
	<div class="container">
		<%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/Includes/header.jsp"%>
			<div class="contents">
				<%@ include file="/WEB-INF/views/Admin/Reservation/commons/sideToggle.jsp"%>
				<div class="sideContents reservation reservHome">
					<div class="mainTitle">예약 관리 홈</div>
					<div class="reservList">
						<div class="subTitle">나의 예약 현황</div>
						<%@ include file="/WEB-INF/views/Admin/Reservation/commons/toolbar.jsp"%>
						<c:choose>
							<c:when test="${type eq 'meetingRoom'}">
								<div class="listBox roomList">
									<div class="rows listHeader">
										<div class="cols">
											<span>회의실 명</span>
										</div>
										<div class="cols">
											<span>회의실 위치</span>
										</div>
										<div class="cols">
											<span>예약 목적</span>
										</div>
										<div class="cols">
											<span>예약일</span>
										</div>
										<div class="cols">
											<span>예약 시간</span>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty list}">
											<div class="rows emptyReservList">
												<c:choose>
													<c:when test="${listType eq 'all'}">
														<p>예약 정보가 없습니다.</p>
													</c:when>
													<c:when test="${listType eq 'search'}">
														<p>검색 결과가 없습니다.</p>
													</c:when>
												</c:choose>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${list}" var="i">
												<div class="rows">
													<div class="cols">
														<span>${i.room_name}</span>
													</div>
													<div class="cols">
														<span>${i.location}</span>
													</div>
													<div class="cols">
														<span>${i.purpose}</span>
													</div>
													<div class="cols">
														<span>
															<fmt:formatDate value="${i.start_date}" pattern="yyyy-MM-dd" />
														</span>
													</div>
													<div class="cols">
														<span>
															<fmt:formatDate value="${i.start_date}" pattern="HH:mm" />
															&nbsp;&nbsp;~&nbsp;&nbsp;
															<fmt:formatDate value="${i.end_date}" pattern="HH:mm" />
														</span>
													</div>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</c:when>
							<c:otherwise>
								<div class="listBox vehicleList">
									<div class="rows listHeader">
										<div class="cols">
											<span>차량 명</span>
										</div>
										<div class="cols">
											<span>차량 번호</span>
										</div>
										<div class="cols">
											<span>예약 목적</span>
										</div>
										<div class="cols">
											<span>예약일</span>
										</div>
										<div class="cols">
											<span>반납일</span>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty list}">
											<div class="rows emptyReservList">
												<c:choose>
													<c:when test="${listType eq 'all'}">
														<p>예약 정보가 없습니다.</p>
													</c:when>
													<c:when test="${listType eq 'search'}">
														<p>검색 결과가 없습니다.</p>
													</c:when>
												</c:choose>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${list}" var="i">
												<div class="rows">
													<div class="cols">
														<span>${i.name}</span>
													</div>
													<div class="cols">
														<span>${i.license_plate}</span>
													</div>
													<div class="cols">
														<span>${i.purpose}</span>
													</div>
													<div class="cols">
														<span>
															<fmt:formatDate value="${i.start_date}" pattern="yyyy-MM-dd" />
														</span>
													</div>
													<div class="cols">
														<span>
															<fmt:formatDate value="${i.end_date}" pattern="yyyy-MM-dd" />
														</span>
													</div>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</c:otherwise>
						</c:choose>
						<%@ include file="/WEB-INF/views/Admin/Reservation/commons/pagination.jsp"%>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>