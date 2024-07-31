<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/mky.css">
<link rel="stylesheet" href="/resources/css/employee.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/employee.js"></script>
</head>

<body class="membership_body">
    <c:choose>
        <c:when test="${loginID != null}">
            <div class="container">
                <!-- 공통영역 -->
                <div class="sideBar">
                    <div class="top">
                        <i class="bx bx-menu" id="btn"></i>
                    </div>
                    <div class="user">
                        <img src="images/logo/WIT_logo1.png" alt="me" class="userImg">
                        <div class="nickName">
                            <p class="bold">Wit Works</p>
                            <p></p>
                        </div>
                    </div>
                    <ul>
                        <li><a href="#"> <i class='bx bxs-home-alt-2'></i> <span class="navItem">홈</span></a> <span class="toolTip">홈</span></li>
                        <li><a href="#"> <i class='bx bx-paperclip'></i> <span class="navItem">주소록</span></a> <span class="toolTip">주소록</span></li>
                        <li><a href="board.html"> <i class="bx bxs-grid-alt"></i> <span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
                        <li><a href="#"> <i class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a> <span class="toolTip">캘린더</span></li>
                        <li><a href="#"> <i class='bx bxs-message-dots'></i> <span class="navItem">메신저</span></a> <span class="toolTip">메신저</span></li>
                        <li><a href="#"> <i class='bx bx-clipboard'></i> <span class="navItem">전자결재</span></a> <span class="toolTip">전자결재</span></li>
                        <li><a href="/attendance/attendance"> <i class='bx bxs-briefcase-alt-2'></i> <span class="navItem">근태관리</span></a> <span class="toolTip">근태관리</span></li>
                        <li><a href="#"> <i class='bx bxs-check-square'></i> <span class="navItem">예약</span></a> <span class="toolTip">예약</span></li>
                        <li><a href="#"> <i class='bx bx-sitemap'></i> <span class="navItem">조직도</span></a> <span class="toolTip">조직도</span></li>
                    </ul>
                </div>
                <!-- 공통영역 끝 -->
                <div class="main-content">
                    <div class="header">
                        <!--마이페이지로 이동-->
                        <span class="myName"> <img src="images/프로필.jpg"><a href="/employee/mypage">${loginName} ${loginRole}</a></span> <span class="alert"><a href=""><i class='bx bx-bell'></i></a></span> <span class="logOut"><a href="/employee/logout"><i class='bx bx-log-in'></i></a></span>
                    </div>
                    <div class="contents">
                        <div class="left">
                            <div class="leftTop">user</div>
                            <div class="leftBottom">
                                <div id="date"></div>
                                <h3 id="clock"></h3>
                                <div class="attendance-btn">
                                    <div>
                                        <button type="button" id="start_button">출근</button>
                                        <div class="check-time">00:00:00</div>
                                    </div>
                                    <div>
                                        <button type="button" id="end_button">퇴근</button>
                                        <div class="check-time">00:00:00</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="center">
                            <div class="mainTitle">인기글</div>
                            <div class="boardList">
                                <div class="notiList">
                                    <div class="rows notiHeader">
                                        <div class="cols fboardTitle">
                                            <span>글 제목</span>
                                        </div>
                                        <div class="cols">
                                            <span>작성자</span>
                                        </div>
                                        <div class="cols">
                                            <span>날짜</span>
                                        </div>
                                        <div class="cols">
                                            <i class="fa-regular fa-eye"></i>
                                        </div>
                                    </div>
                                    <div class="rows notiConts">
                                        <div class="cols fboardTitle">
                                            <span>글 제목 영역입니다.</span>
                                        </div>
                                        <div class="cols">
                                            <span>작성자</span>
                                        </div>
                                        <div class="cols">
                                            <span>2024-07-28</span>
                                        </div>
                                        <div class="cols">
                                            <span>300</span>
                                        </div>
                                    </div>
                                    <!-- 나머지 게시글 목록 -->
                                </div>
                            </div>
                        </div>
                        <div class="right">
                            <div class="rightTop">전자결재영역</div>
                            <div class="rightBottom">캘린더영역</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="overlay"></div>
            <div id="popup" class="popup">
                <h2>추가 정보 입력</h2>
                <form id="insertForm" action="/employee/update_info" method="post">
                    <input type="hidden" name="emp_no" value="${loginID}">
                    <div class="input-container">
                        <input type="password" name="pw" id="pw" placeholder="비밀번호" required> <span class="valid-check error" id="pwCheck">&#x2716;</span>
                    </div>
                    <label id="resultpw"></label>
                    <div class="input-container">
                        <input type="password" name="checkpw" id="checkpw" placeholder="비밀번호 확인" required> <span class="valid-check error" id="checkpwCheck">&#x2716;</span>
                    </div>
                    <label id="resultcheckpw"></label>
                    <div class="input-container">
                        <input type="text" name="nickname" id="nickname" placeholder="닉네임" required> <span class="valid-check error" id="nicknameCheck">&#x2716;</span>
                    </div>
                    <label id="resultNickname"></label>
                    <button type="button" class="nickname-button" id="checkNickname">중복체크</button>
                    <div class="input-container">
                        <input type="text" name="ssn" id="ssn" placeholder="주민등록번호" required> <span class="valid-check error" id="ssnCheck">&#x2716;</span>
                    </div>
                    <label id="resultSSN"></label>
                    <div class="input-container">
                        <input type="text" name="phone" id="phone" placeholder="휴대폰" required> <span class="valid-check error" id="phoneCheck">&#x2716;"></span>
                    </div>
                    <label id="resultPhone"></label>
                    <div class="input-container">
                        <input type="email" name="email" id="email" placeholder="이메일" required> <span class="valid-check error" id="emailCheck">&#x2716;"></span>
                    </div>
                    <label id="resultEmail"></label> <input type="text" name="zip_code" id="zip_code" placeholder="우편주소" required readonly>
                    <button type="button" class="address-button" id="postcode">주소 찾기</button>
                    <input type="text" name="address" id="address" placeholder="주소" required readonly> <input type="text" name="detail_address" placeholder="상세주소" required>
                    <button type="submit" class="submit-button">입력하기</button>
                </form>
            </div>

        </c:when>
        <c:otherwise>
            <div class="membership active">
                <img src="/resources/img/logo.png" alt="로고 이미지">
                <div class="find_container">
                    <a href="/employee/find_ID" class="find_id">ID 찾기</a>
                </div>
                <form id="loginForm">
                    <input type="text" name="emp_no" placeholder="User ID" required>
                    <input type="password" name="pw" placeholder="User PW" required>
                    <button type="button" id="login_button">Login</button>
                </form>
                <div class="employee_container">
                    <a href="/employee/register_form" class="insert_employee">신규 직원등록</a>
                    <!-- <a href="#" class="find_pw">PW 찾기</a> -->
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <script>
        $(document).ready(function() {
            // 사이드바 토글 버튼
            let btn = document.querySelector("#btn");
            let sideBar = document.querySelector(".sideBar");

            btn.onclick = function() {
                sideBar.classList.toggle("active");
            };

            // 첫 로그인시 추가 정보 입력 팝업
            var firstLogin = "${sessionScope.FirstLogin}" === "true";
            if (firstLogin) {
                $(".overlay").show();
                $("#popup").show();
            }

            $("#insertForm").on("submit", function() {
                // 팝업 제출 후 오버레이와 팝업 숨기기
                $(".overlay").hide();
                $("#popup").hide();
            });

            // 팝업 외부 클릭 방지
            $(".overlay").on("click", function(e) {
                e.stopPropagation();
                alert("추가 정보를 입력 후 제출하세요.");
            });

            $("#popup").on("click", function(e) {
                e.stopPropagation(); // 팝업 내부 클릭 시 이벤트 전파 방지
            });

            // 실시간 시간 업데이트
            function updateClock() {
                var now = new Date();
                var date = now.getFullYear() + '년 '
                    + (now.getMonth() + 1) + '월 ' + now.getDate()
                    + '일';
                var days = ['일', '월', '화', '수', '목', '금', '토'];
                var day = days[now.getDay()];
                var time = now.toLocaleTimeString();
                $('#date').text(date + ' (' + day + ')');
                $('#clock').text(time);
            }

            setInterval(updateClock, 1000);
            updateClock(); // 페이지 로드 시 초기 시간 설정
        });
    </script>
</body>
</html>
