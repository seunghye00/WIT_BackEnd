<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>반려 문서함</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.main.css">
    <link rel="stylesheet" href="/css/wit.css">
    <script defer src="/js/wit.js"></script>
    <script defer src="/js/hsh.js"></script>
</head>

<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>	
        <div class="main-content">
            <%@ include file="/WEB-INF/views/Includes/header.jsp"%>
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <a href="/eApproval/home">
                            <h2 class="sideTit">전자 결재</h2>
                        </a>
                    </div>
                    <div class="sideBtnBox">
                        <button class="plusBtn sideBtn" id="startApprBtn">새 결재 진행</button>
                        <%@ include file="/WEB-INF/views/eApproval/commons/newWriteModal.jsp" %>
					</div>
					<%@ include file="/WEB-INF/views/eApproval/commons/sideToggle.jsp" %>
				</div>
                <div class="sideContents eApproval">
                    <div class="mainTitle">반려 문서함</div>
                    <div class="docuList docuBox">
                        <%@ include file="/WEB-INF/views/eApproval/commons/toolbar.jsp"%>
                        <div class="listBox returnList">
                            <div class="rows listHeader">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>문서 양식</span>
                                </div>
                                <div class="cols">
                                    <span>긴급</span>
                                </div>
                                <div class="cols">
                                    <span>제목</span>
                                </div>
                                <div class="cols">
                                    <span>기안자</span>
                                </div>
                                <div class="cols">
                                    <span>반려일</span>
                                </div>
                            </div>
                            <c:choose>
								<c:when test="${empty docuList}">
									<div class="rows emptyDocuList">
										<c:choose>
											<c:when test="${keyword == null}">
												<p>반려된 문서가 없습니다.</p>
											</c:when>
											<c:otherwise>
												<p>검색한 결과가 없습니다.</p>
											</c:otherwise>
										</c:choose>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${docuList}" var="i">
										<a href="/eApproval/readDocu?docuSeq=${i.document_seq}">
										<div class="rows">
											<div class="cols">
												<span><fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd" /></span>
											</div>
											<div class="cols">
												<span>${i.name}</span>
											</div>
											<div class="cols">
												<span>
												<c:if test="${i.emer_yn eq 'Y'}">
													<img src="/img/icon/siren.png" class="emer">
												</c:if>
												</span>
											</div>
											<div class="cols">
												<span>${i.title}</span>
											</div>
											<div class="cols">
												<span>${i.writer}</span>
											</div>
											<div class="cols">
												<span><fmt:formatDate value="${i.done_date}" pattern="yyyy-MM-dd" /></span>
											</div>
										</div>
										</a>
									</c:forEach>
								</c:otherwise>
							</c:choose>
                        </div>
                        <%@ include file="/WEB-INF/views/eApproval/commons/pagination.jsp"%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>