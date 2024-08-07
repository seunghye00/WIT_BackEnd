<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.main.css">
    <link rel="stylesheet" href="/css/wit.css">
    <script defer src="/js/wit.js"></script>
    <script defer src="/js/hsh.js"></script>
</head>

<body>
    <!-- 공통영역 -->
    <div class="container">
        <%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>	
        <!-- 공통역역 끝 -->

        <div class="main-content">
            <div class="header">
                <span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
                <!--마이페이지로 이동-->
                <span class="myName">
                    <img src="/img/WIT_logo1.png"><a href=" #">백민주 사원</a></span>
                <span class="logOut"><a href="#">LogOut</a></span>
            </div>
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <a href="/eApproval/home">
                            <h2 class="sideTit">전자 결재</h2>
                        </a>
                    </div>
                    <div class="sideBtnBox">
                        <button class="plusBtn sideBtn" id="startApprBtn">새 결재 진행</button>
                        <div class="eApprModal docuChoiModal">
                            <div class="eApprModalTitle">
								문서 양식 선택 <span class="closeModal">X</span>
							</div>
							<div class="choiCont">
								<ul id="docuNameList"></ul>
							</div>
							<div class="modalBtnBox">
								<button class="next">다음</button>
								<button class="cancel red">취소</button>
							</div>
                        </div>
                        <div class="eApprModal apprChoiModal">
                            <div class="eApprModalTitle">
                                결재선 선택
                                <span class="closeModal">X</span>
                            </div>
                            <div class="choiCont">
                                <div class="deptList">
									<ul id="deptList"></ul>
								</div>
                                <div class="employeeList">
									<ul id="employeeList"></ul>
								</div>
                                <div class="arrBtns">
									<button id="addAppr">
										<img src="/img/toggle.png" alt="">
									</button>
									<button id="delAppr">
										<img src="/img/toggle.png" alt="">
									</button>
									<div style="padding: 30px 0;"></div>
									<button id="addRefe">
										<img src="/img/toggle.png" alt="">
									</button>
									<button id="delRefe">
										<img src="/img/toggle.png" alt="">
									</button>
								</div>
                                <div class="resultAppr">
                                    <div class="apprList list">
										<p>결재 순서</p>
										<ul>
											<li id="firAppr">
												<div>첫번째 결재자</div>
											</li>
											<li id="secAppr">
												<div>두번째 결재자</div>
											</li>
											<li id="thirAppr">
												<div>세번째 결재자</div>
											</li>
										</ul>
									</div>
									<div class="refeList list">
										<p>참조 목록</p>
										<ul id="refeList"></ul>
									</div>
                                </div>
                            </div>
                            <div class="modalBtnBox">
                                <button class="done">완료</button>
                                <button class="prev red">이전</button>
                            </div>
                        </div>
                    </div>
                    <div class="addressListPrivate">
						<ul class="privateList">
							<li class="toggleItem">
								<h3 class="toggleTit">결재하기</h3>
								<ul class="subList">
									<li><a href="/eApproval/apprList?type=todo">결재 대기 문서</a></li>
									<li><a href="/eApproval/apprList?type=upcoming">결재 예정 문서</a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="addressListGroup">
						<ul class="GroupList">
							<li class="toggleItem">
								<h3 class="toggleTit">개인 문서함</h3>
								<ul class="subList">
									<li><a href="/eApproval/privateList?type=write" class="active">기안 문서함</a></li>
									<li><a href="/eApproval/privateList?type=save">임시 저장 문서함</a></li>
									<li><a href="/eApproval/privateList?type=approved">결재 문서함</a></li>
									<li><a href="/eApproval/privateList?type=return">반려 문서함</a></li>
									<li><a href="/eApproval/privateList?type=view">참조 문서함</a></li>
								</ul>
							</li>
						</ul>
					</div>
                </div>
                <div class="sideContents eApproval">
                    <div class="mainTitle">기안 문서함</div>
                    <div class="docuList docuBox">
                        <div class="toolBar">
                            <ul>
                            	<li>
                                    <a href="javascript:;" class="active">전체</a>
                                </li>
                                <li>
                                    <a href="javascript:;">업무 기안</a>
                                </li>
                                <li>
                                    <a href="javascript:;">휴가 신청서</a>
                                </li>
                                <li>
                                    <a href="javascript:;">지각 사유서</a>
                                </li>
                            </ul>
                            <div class="searchBox">
                                <input type="text" placeholder="검색">
                                <button class="searchBtn">
                                    <i class="bx bx-search"></i>
                                </button>
                            </div>
                        </div>
                        <div class="listBox progList">
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
                                    <span>결재 상태</span>
                                </div>
                                <div class="cols">
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재예정</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
                                </div>
                            </div>
                            <div class="rows">
                                <div class="cols">
                                    <span>기안일</span>
                                </div>
                                <div class="cols">
                                    <span>완료일</span>
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
                                    <span>최종 결재자</span>
                                </div>
                                <div class="cols">
                                    <span>결재중</span>
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