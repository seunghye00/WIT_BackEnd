<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메신저</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<!-- <script defer src="/resources/js/mky.js"></script>
<script defer src="/resources/js/header.js"></script> -->
<script defer src="/resources/js/chat.js"></script>
</head>
<body>
<!-- 공통영역 -->
    <div class="container">
    	<%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>	
        <div class="main-content">
    		<%@ include file="/WEB-INF/views/Includes/header.jsp" %>	
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <h2 class="sideTit" id="sideTitle">주소록</h2>
                    </div>
                    <div class="chatChangeBox">
                        <button class="toggleBtn" onclick="toggleView('chat')"
                            style="display: inline-block;">채팅방</button>
                        <button class="toggleBtn" onclick="toggleView('address')" style="display: none;">주소록</button>
                         <button id="createGroup" class="toggleBtn createChatBtn" onclick="toggleCheckboxes()"><i
                                    class='bx bx-user-plus'></i></button>
                    </div>
                    <ul class="chatList" id="chatList" style="display: none;">
					    <!-- AJAX로 동적 채팅방 목록이 추가될 예정 -->
					</ul>
                    <ul class="addressList" id="addressList">
                        <li>
                           
                        </li>
                      	<!-- AJAX를 통해 데이터를 불러와 여기에 추가할 예정 -->
                    </ul>
                    <button class="createChatConfirmBtn" style="display: none;" onclick="createChat()">확인</button>
                </div>
                <div class="sideContents chatContainer">
                    <div class="chatHeader">
                        <div class="title">채팅방 제목</div>
                    </div>
                    <div class="chatBody" id="chatBody">
                        <!-- 웹소켓 실시간 통신 및 Ajax 데이터를 불러와 여기에 추가할 예정 -->
                    </div>
                    <div class="emojiContainer" id="emojiContainer">
                        <img src="../resources/img/emoticon/emt1.png" alt="emt1" onclick="addEmojiToMessageInput(this)">
                        <img src="../resources/img/emoticon/emt2.png" alt="emt2" onclick="addEmojiToMessageInput(this)">
                        <img src="../resources/img/emoticon/emt3.png" alt="emt3" onclick="addEmojiToMessageInput(this)">
                        <img src="../resources/img/emoticon/emt4.png" alt="emt4" onclick="addEmojiToMessageInput(this)">
                        <img src="../resources/img/emoticon/emt5.png" alt="emt5" onclick="addEmojiToMessageInput(this)">
                        <button class="closeBtn" onclick="toggleEmojiContainer()">x</button>
                    </div>
                    <div class="chatFooter">
                        <i class='bx bx-smile icon' onclick="toggleEmojiContainer()"></i>
                        <i class='bx bx-file icon' onclick="triggerFileInput()"></i>
                        <input type="file" class="fileInput" id="fileInput" onchange="handleFileInput(event)">
                        <div id="messageInput" contenteditable="true" class="messageInput"
                            onkeydown="handleKeyDown(event)">
                        </div>
                        <button onclick="sendMessage()">전송</button>
                    </div>
                </div>
            </div>
    </div>
    <!-- 파일 전송 팝업  -->
    <div class="filePopup" id="filePopup">
        <div class="popupContent">
            <p>파일을 전송할까요?</p>
            <div class="popupBox">
                <button onclick="confirmFileSend()">네</button>
                <button onclick="cancelFileSend()">아니오</button>
            </div>
        </div>
    </div>
     <!-- 프로필 상세 팝업  -->
    <div id="profilePopup" class="profilePopup">
        <div class="profileInfo">
            <div class="profileTit">
                <img src="/resources/img/푸바오.png" alt="프로필 이미지">
                <span>문경원</span>
            </div>
            <div class="profileDetails">
                <div class="profileRow">
                    <div class="label">부서명</div>
                    <div class="value" id="profileDept">개발팀</div>
                </div>
                <div class="profileRow">
                    <div class="label">직책</div>
                    <div class="value" id="profileRole">부장</div>
                </div>
                <div class="profileRow">
                    <div class="label">휴대전화</div>
                    <div class="value" id="profilePhone">010-5482-9107</div>
                </div>
                <div class="profileRow">
                    <div class="label">이메일</div>
                    <div class="value" id="profileEmail">shaaa6256@naver.com</div>
                </div>
            </div>
        </div>
        <div class="profilebtnBox">
            <a class="closeButton" onclick="closeProfilePopup()">닫기</a>
            <a href="javascript:;" class="chatButton">1:1 채팅</a>
        </div>
    </div>
    <!-- 채팅방 팝업 -->
	<div id="chatRoomPopup" class="chatRoomPopup" style="display: none;">
	    <div class="popupContent">
		    <div class="chatRoomTitle">
		          <h2></h2>
		          <button id="chatTitModi" type="button" onclick="editTitle()">✏️</button>
		    </div>
	        <div class="chatRoomDetails">
	        	<ul>
	        		<li><i class='bx bx-user'></i></li>
	        	</ul>
	        </div>
	        <div class="chatRoomPopupBtn">
		        <button class="chatBtn" onclick="startChat()"><i class='bx bx-message-rounded' ></i> 채팅</button>
		        <button class="exitBtn" onclick="exitChatRoom()"><i class="bx bx-exit"></i> 나가기</button>
		        <button class="closeBtn" onclick="closeChatRoomPopup()">x</button>
	        </div>
	    </div>
	</div>
	<!-- sidebar 공통요소 script -->
	<script>
	    $(document).ready(function() {
	        loadEmployeeList();
	        loadChatList();
	        addPasteImageListener('messageInput');
   		});
	

	</script>
</body>

</html>