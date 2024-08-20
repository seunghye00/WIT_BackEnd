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
				<div class="sideContents reservationControll">
					<div class="mainTitle">예약 항목 관리</div>
					<div class="reservList">
						<%@ include file="/WEB-INF/views/Admin/Reservation/commons/controllToolbar.jsp"%>
						<c:choose>
							<c:when test="${controll eq 'meetingRoom' && purpose eq 'notice'}">
							<div class="controllBox">
								<div class="listBox roomList">
									<div class="rows listHeader">
										<div class="cols">
											<span>회의실 명</span>
										</div>
										<div class="cols">
											<span>회의실 위치</span>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty meetingRooms}">
											<div class="rows emptyReservList">
												<p>등록된 회의실이 없습니다.</p>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${meetingRooms}" var="i">
												<a href="/reservation/admin/bookingControll?type=meetingRoom&seq=${i.room_seq}&purpose=notice">
												<div class="rows ${target.room_seq eq i.room_seq ? 'active' : ''}">
													<div class="cols">
														<span>${i.name}</span>
													</div>
													<div class="cols">
														<span>${i.location}</span>
													</div>
												</div>
												</a>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="guidelinesBox">
									<div class="title">
										[${target.name}] 예약 안내 사항
									</div>
									<c:choose>
										<c:when test="${empty target.guidelines}">
											<div class="cont emptyCont">
												<textarea id="guideLine">등록된 안내 사항이 없습니다.</textarea>
											</div>
										</c:when>
										<c:otherwise>
											<div class="cont">
												<textarea id="guideLine">${target.guidelines}</textarea>
											</div>
										</c:otherwise>
									</c:choose>
									<div class="btns">
										<button id="updateGuideLines">수정</button>
										<button class="red">취소</button>
									</div>
								</div>
							</div>
							</c:when>
							<c:when test="${controll eq 'meetingRoom' && purpose eq 'controll'}">
							<div class="controllBox updateStatus">
								<div class="listBox roomList">
									<div class="rows listHeader">
										<div class="cols">
											<span>회의실 명</span>
										</div>
										<div class="cols">
											<span>회의실 위치</span>
										</div>
										<div class="cols">
											<span>예약 가능 여부</span>
										</div>
										<div class="cols">
											<span>상태 변경</span>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty allList}">
											<div class="rows emptyReservList">
												<p>등록된 회의실이 없습니다.</p>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${allList}" var="i">
												<div class="rows">
													<div class="cols">
														<span>${i.name}</span>
													</div>
													<div class="cols">
														<span>${i.location}</span>
													</div>
													<div class="cols">
														<span <c:if test="${i.status eq '예약 불가능'}">class="unavailable"</c:if>>${i.status}</span>
													</div>
													<div class="cols">
														<span>
															<a href="/reservation/admin/updateStatus?target=meetingRoom&seq=${i.room_seq}&status=${i.status}">
																<button>변경</button>
															</a>
														</span>
													</div>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							</c:when>
							<c:when test="${controll eq 'vehicle' && purpose eq 'notice'}">
							<div class="controllBox">
								<div class="listBox vehicleList">
									<div class="rows listHeader">
										<div class="cols">
											<span>차량 명</span>
										</div>
										<div class="cols">
											<span>차량 번호</span>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty vehicles}">
											<div class="rows emptyReservList">
												<p>등록된 차량이 없습니다.</p>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${vehicles}" var="i">
											<a href="/reservation/admin/bookingControll?type=vehicle&seq=${i.vehicle_seq}&purpose=notice">
												<div class="rows ${target.vehicle_seq eq i.vehicle_seq ? 'active' : ''}">
													<div class="cols">
														<span>${i.name}</span>
													</div>
													<div class="cols">
														<span>${i.license_plate}</span>
													</div>
												</div>
											</a>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="guidelinesBox">
									<div class="title">
										[${target.name}_${target.license_plate}] 예약 안내 사항
									</div>
									<c:choose>
										<c:when test="${empty target.guidelines}">
											<div class="cont emptyCont">
												<textarea id="guideLine">등록된 안내 사항이 없습니다.</textarea>
											</div>
										</c:when>
										<c:otherwise>
											<div class="cont">
												<textarea id="guideLine">${target.guidelines}</textarea>
											</div>
										</c:otherwise>
									</c:choose>
									<div class="btns">
										<button id="updateGuideLines">수정</button>
										<button class="red">취소</button>
									</div>
								</div>
							</div>
							</c:when>
							<c:when test="${controll eq 'vehicle' && purpose eq 'controll'}">
							<div class="controllBox updateStatus">
								<div class="listBox vehicleList">
									<div class="rows listHeader">
										<div class="cols">
											<span>차량 명</span>
										</div>
										<div class="cols">
											<span>차량 번호</span>
										</div>
										<div class="cols">
											<span>예약 가능 여부</span>
										</div>
										<div class="cols">
											<span>상태 변경</span>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty allList}">
											<div class="rows emptyReservList">
												<p>등록된 차량이 없습니다.</p>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${allList}" var="i">
												<div class="rows">
													<div class="cols">
														<span>${i.name}</span>
													</div>
													<div class="cols">
														<span>${i.license_plate}</span>
													</div>
													<div class="cols">
														<span <c:if test="${i.status eq '예약 불가능'}">class="unavailable"</c:if>>${i.status}</span>
													</div>
													<div class="cols">
														<span>
															<a href="/reservation/admin/updateStatus?target=vehicle&seq=${i.vehicle_seq}&status=${i.status}">
																<button>변경</button>
															</a>
														</span>
													</div>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>