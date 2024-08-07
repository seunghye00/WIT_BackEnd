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
<script defer src="/resources/js/mky.js"></script>
</head>
<body>
<!-- 공통영역 -->
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
                <li>
                    <a href="#">
                        <i class='bx bxs-home-alt-2'></i>
                        <span class="navItem">홈</span>
                    </a>
                    <span class="toolTip">홈</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bx-paperclip'></i>
                        <span class="navItem">주소록</span>
                    </a>
                    <span class="toolTip">주소록</span>
                </li>
                <li>
                    <a href="board2.html">
                        <i class="bx bxs-grid-alt"></i>
                        <span class="navItem">게시판</span>
                    </a>
                    <span class="toolTip">게시판</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bx-calendar-alt'></i>
                        <span class="navItem">캘린더</span>
                    </a>
                    <span class="toolTip">캘린더</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bxs-message-dots'></i>
                        <span class="navItem">메신저</span>
                    </a>
                    <span class="toolTip">메신저</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bx-clipboard'></i>
                        <span class="navItem">전자결재</span>
                    </a>
                    <span class="toolTip">전자결재</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bxs-briefcase-alt-2'></i>
                        <span class="navItem">근태관리</span>
                    </a>
                    <span class="toolTip">근태관리</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bxs-check-square'></i>
                        <span class="navItem">예약</span>
                    </a>
                    <span class="toolTip">예약</span>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bx-sitemap'></i>
                        <span class="navItem">조직도</span>
                    </a>
                    <span class="toolTip">조직도</span>
                </li>

            </ul>
        </div>
        <!-- 공통역역 끝 -->

        <div class="main-content">
            <div class="header">
                <span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
                <!--마이페이지로 이동-->
                <span class="myName">
                    <img src="../images/프로필.jpg"><a href=" #">문경원 부장</a></span>
                <span class="logOut"><a href="#">LogOut</a></span>
            </div>
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <h2 class="sideTit" id="sideTitle">주소록</h2>
                    </div>
                    <div class="chatChangeBox">
                        <button class="toggleBtn" onclick="toggleView('chat')"
                            style="display: inline-block;">채팅방</button>
                        <button class="toggleBtn" onclick="toggleView('address')" style="display: none;">주소록</button>
                    </div>
                    <ul class="chatList" id="chatList" style="display: none;">
					    <!-- AJAX로 동적 채팅방 목록이 추가될 예정 -->
					</ul>
                    <ul class="addressList" id="addressList">
                        <li>
                            <button class="toggleBtn createChatBtn" onclick="toggleCheckboxes()"><i
                                    class='bx bx-user-plus'></i></button>
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
                        <div class="message sent">오늘도 고생했어</div>
                        <div class="message received">진짜 고생 많았다</div>
                        <div class="message sent">내일도 화이팅이야</div>
                        <div class="message received">내일은 좀 더 편안한 하루가 되길</div>
                    </div>
                    <div class="emojiContainer" id="emojiContainer">
                        <img src="../images/message/emt1.png" alt="emt1" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt2.png" alt="emt2" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt3.png" alt="emt3" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt4.png" alt="emt4" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt5.png" alt="emt5" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt1.png" alt="emt1" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt2.png" alt="emt2" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt3.png" alt="emt3" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt4.png" alt="emt4" onclick="addEmojiToMessageInput(this)">
                        <img src="../images/message/emt5.png" alt="emt5" onclick="addEmojiToMessageInput(this)">
                        <button class="closeBtn" onclick="toggleEmojiContainer()">x</button>
                    </div>
                    <div class="chatFooter">
                        <i class='bx bx-smile icon' onclick="toggleEmojiContainer()"></i>
                        <i class='bx bx-file icon' onclick="triggerFileInput()"></i>
                        <input type="file" class="fileInput" id="fileInput" onchange="handleFileInput(event)">
                        <div id="messageInput" contenteditable="true" class="messageInput"
                            onkeydown="handleKeyDown(event)" placeholder="메시지 입력">
                        </div>
                        <button onclick="sendMessage()">전송</button>
                    </div>
                    <div class="filePopup" id="filePopup">
                        <div class="popupContent">
                            <p>파일을 전송할까요?</p>
                            <div class="popupBox">
                                <button onclick="confirmFileSend()">네</button>
                                <button onclick="cancelFileSend()">아니오</button>
                            </div>
                        </div>
                    </div>
                    <div id="profilePopup" class="profilePopup">
                        <div class="profileInfo">
                            <div class="profileTit">
                                <img src="images/프로필.jpg" alt="프로필 이미지">
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
                </div>
            </div>
    </div>
    <!-- 채팅방 팝업 -->
	<div id="chatRoomPopup" class="chatRoomPopup" style="display: none;">
	    <div class="popupContent">
	        <h2 class="chatRoomTitle"></h2>
	        <div class="chatRoomDetails"></div>
	        <div class="chatRoomPopupBtn">
		        <button class="exitBtn"><i class='bx bx-exit'></i></button>
		        <button class="closeBtn" onclick="closeChatRoomPopup()">닫기</button>
	        </div>
	    </div>
	</div>
	<!-- sidebar 공통요소 script -->
	<script>
	    let btn = document.querySelector("#btn")
	    let sideBar = document.querySelector(".sideBar")
	
	    btn.onclick = function () {
	        sideBar.classList.toggle("active")
	    };
	    document.addEventListener('DOMContentLoaded', function () {
	        addPasteImageListener('messageInput');
	    });
	
	    $(document).ready(function() {
	        loadEmployeeList();
	        loadChatList();
   		});
	    
		// 주소록 항목의 체크박스와 확인 버튼을 토글
	    function toggleCheckboxes() {
	        const checkboxes = document.querySelectorAll('.addressCheckbox');
	        const confirmBtn = document.querySelector('.createChatConfirmBtn');
	        checkboxes.forEach(checkbox => {
	            checkbox.style.display = checkbox.style.display === 'none' ? 'inline-block' : 'none'; // 체크박스 토글
	        });
	        confirmBtn.style.display = confirmBtn.style.display === 'none' ? 'inline-block' : 'none'; // 확인 버튼 토글
	    }

	    // 주소록 항목의 체크박스를 클릭하여 선택 상태를 토글
	    function toggleCheckbox(event, element ,emp_no) {
	        event.preventDefault();
	        const checkbox = element.querySelector('.addressCheckbox')
	        checkbox.checked = !checkbox.checked;
	    }

	// 채팅방 
	// 채팅방 사이드 영역 보기 전환
	function toggleView(view) {
	    const chatList = document.getElementById('chatList')
	    const addressList = document.getElementById('addressList')
	    const sideTitle = document.getElementById('sideTitle')
	    const chatButton = document.querySelector(
	        '.toggleBtn[onclick="toggleView(\'chat\')"]'
	    )
	    const addressButton = document.querySelector(
	        '.toggleBtn[onclick="toggleView(\'address\')"]'
	    )
	
	    if (view === 'chat') {
	        chatList.style.display = 'block' // 채팅방 리스트 보이기
	        addressList.style.display = 'none' // 주소록 리스트 숨기기
	        sideTitle.innerText = '채팅방' // 제목을 '채팅방'으로 변경
	        chatButton.style.display = 'none' // '채팅방' 버튼 숨기기
	        addressButton.style.display = 'inline-block' // '주소록' 버튼 보이기
	    } else {
	        chatList.style.display = 'none' // 채팅방 리스트 숨기기
	        addressList.style.display = 'block' // 주소록 리스트 보이기
	        sideTitle.innerText = '주소록' // 제목을 '주소록'으로 변경
	        chatButton.style.display = 'inline-block' // '채팅방' 버튼 보이기
	        addressButton.style.display = 'none' // '주소록' 버튼 숨기기
	    }
	}
	
	// 주소록 클릭 시 프로필 팝업 표시
    function showProfile(event, emp_no) {
        event.preventDefault();
        $.ajax({
            url: '/employee/getEmployeeDetails',
            method: 'GET',
            data: { emp_no: emp_no },
            success: function(employee) {
                // 프로필 정보를 업데이트
                console.log(employee);
                $('#profilePopup .profileTit img').attr('src', 'images/프로필.jpg'); // 이미지 경로는 실제 데이터에 맞게 수정
                $('#profilePopup .profileTit span').text(employee.NAME);
                $('#profileDept').text(employee.DEPT_TITLE);
                $('#profileRole').text(employee.ROLE_TITLE);
                $('#profilePhone').text(employee.PHONE);
                $('#profileEmail').text(employee.EMAIL);
                
            	// emp_no를 데이터 속성으로 저장
                $('#profilePopup').data('emp_no', emp_no);

                // 팝업을 표시
                $('#profilePopup').css('display', 'flex');
            },
            error: function(error) {
                console.error("Error loading employee details:", error);
            }
        });
    }
	
	// 프로필 팝업 닫기 버튼
	function closeProfilePopup() {
	    document.getElementById('profilePopup').style.display = 'none' // 팝업 숨기기
	}
	
	// 선택된 주소록 항목을 수집하여 그룹 채팅 생성
	function createChat() {
	    const selectedAddresses = []
	    const checkboxes = document.querySelectorAll('.addressCheckbox')
	    checkboxes.forEach((checkbox, index) => {
	        if (checkbox.checked) {
	            selectedAddresses.push(`주소록 ${index + 1}`) // 체크된 항목의 이름을 배열에 추가
	        }
	    })
	    console.log('선택된 주소록:', selectedAddresses) // 선택된 주소록 출력
	}
	
	// 메시지를 전송하는 함수
	function sendMessage() {
	    const messageInput = document.getElementById('messageInput')
	    const messageHTML = messageInput.innerHTML.trim()
	
	    if (messageHTML !== '') {
	        const chatBody = document.getElementById('chatBody')
	
	        // 새로운 메시지 요소 생성
	        const messageElement = document.createElement('div')
	        messageElement.classList.add('message', 'sent')
	        messageElement.innerHTML = messageHTML
	
	        // 채팅 바디에 추가
	        chatBody.appendChild(messageElement)
	
	        // 입력 필드 초기화
	        messageInput.innerHTML = ''
	
	        // 채팅 바디 스크롤을 하단으로 이동
	        chatBody.scrollTop = chatBody.scrollHeight
	    }
	}
	
	// 파일 입력 필드를 트리거하는 함수
	function triggerFileInput() {
	    document.getElementById('fileInput').click()
	}
	
	// 파일 입력을 처리하는 함수
	function handleFileInput(event) {
	    const file = event.target.files[0]
	    if (file) {
	        fileToSend = file // 전송할 파일을 설정
	        document.getElementById('filePopup').style.display = 'block' // 파일 전송 여부를 묻는 팝업 표시
	    }
	}
	
	// 파일 전송을 확인하는 함수
	function confirmFileSend() {
	    const fileReader = new FileReader()
	    fileReader.onload = function (e) {
	        const fileDataUrl = e.target.result
	        const messageInput = document.getElementById('messageInput')
	
	        if (fileToSend.type.startsWith('image/')) {
	            messageInput.innerHTML = `<img src="${fileDataUrl}" alt="${fileToSend.name}" style="max-width: 100%; max-height: 200px;">`
	        } else {
	            const fileLink = document.createElement('a')
	            fileLink.href = fileDataUrl
	            fileLink.download = fileToSend.name
	            fileLink.textContent = fileToSend.name
	            messageInput.innerHTML = ''
	            messageInput.appendChild(fileLink)
	        }
	
	        sendMessage()
	        cancelFileSend()
	    }
	
	    fileReader.readAsDataURL(fileToSend)
	}
	
	// 파일 전송을 취소하는 함수
	function cancelFileSend() {
	    document.getElementById('filePopup').style.display = 'none'
	    document.getElementById('fileInput').value = ''
	    fileToSend = null
	}
	
	// 클립보드에서 이미지를 붙여넣는 함수
	function addPasteImageListener(elementId) {
	    const messageInput = document.getElementById(elementId)
	    if (messageInput) {
	        messageInput.addEventListener('paste', function (event) {
	            const items = (event.clipboardData || window.clipboardData).items
	            for (let item of items) {
	                if (item.type.indexOf('image') !== -1) {
	                    const file = item.getAsFile()
	                    const reader = new FileReader()
	                    reader.onload = function (event) {
	                        messageInput.innerHTML = `<img src="${event.target.result}" alt="Pasted Image" style="max-width: 100%; max-height: 200px;">`
	                    }
	                    reader.readAsDataURL(file)
	                }
	            }
	        })
	    }
	}
	
	// 키 다운 이벤트 처리 (엔터 키로 메시지 전송)
	function handleKeyDown(event) {
	    if (event.key === 'Enter' && !event.shiftKey) {
	        event.preventDefault()
	        sendMessage()
	    }
	}
	
	// 이모티콘 컨테이너를 토글하는 함수
	function toggleEmojiContainer() {
	    const emojiContainer = document.getElementById('emojiContainer')
	    const chatBody = document.getElementById('chatBody')
	
	    if (emojiContainer.style.display === 'flex') {
	        emojiContainer.style.display = 'none'
	        chatBody.style.paddingBottom = '20px'
	    } else {
	        emojiContainer.style.display = 'flex'
	        chatBody.style.paddingBottom = `${emojiContainer.clientHeight + 20}px`
	    }
	}
	
	// 이모티콘을 메시지 입력 필드에 추가하는 함수
	function addEmojiToMessageInput(imgElement) {
	    const messageInput = document.getElementById('messageInput')
	    const img = document.createElement('img')
	    img.src = imgElement.src
	    img.style.maxWidth = '100%'
	    img.style.maxHeight = '100px'
	    messageInput.appendChild(img)
	}
	
	// 채팅방 주소록 조회
	function loadEmployeeList() {
        $.ajax({
            url: '/employee/getEmployeeList',
            method: 'GET',
            success: function(response) {
                var addressList = $('#addressList');
                addressList.find('li:not(:first)').remove(); // 기존 항목 제거
                response.forEach(function(employee) {
                    addressList.append('<li><a href="javascript:;" data-emp-no="' + employee.EMP_NO + '" onclick="toggleCheckbox(event, this)"><input type="checkbox" class="addressCheckbox" value="' + employee.EMP_NO + '" style="display: none;">' + employee.NAME + '</a></li>');
                });
                // 주소록 클릭 시 프로필 팝업 표시
                const addressItems = document.querySelectorAll('.addressList li a');
                addressItems.forEach(item => {
                    item.addEventListener('click', function(event) {
                        // 체크박스 모드가 아닐 때만 프로필 팝업을 띄움
                        if (!item.querySelector('.addressCheckbox').style.display.includes('inline-block')) {
                            showProfile(event, item.getAttribute('data-emp-no'));
                        }
                    });
                });

                document.addEventListener('click', function(event) {
                    const profilePopup = document.getElementById('profilePopup');
                    if (!event.target.closest('.addressList li') && !event.target.closest('.profilePopup')) {
                        profilePopup.style.display = 'none';
                    }
                });
            },
            error: function(error) {
                console.error("Error loading employee list:", error);
            }
        });
    }
	
	// 채팅방 조회
	function loadChatList() {
        $.ajax({
            url: '/chatroom/myChatRooms',
            method: 'GET',
            success: function(response) {
                console.log(response);
                var chatList = $('#chatList');
                chatList.empty(); // 기존 목록 초기화

                response.forEach(function(chatRoom) {
                    var $listItem = $('<li>');
                    var $link = $('<a>', {
                        href: 'javascript:;',
                        'data-chat-room-seq': chatRoom.CHAT_ROOM_SEQ,
                        click: function() {
                            showChatRoomPopup(chatRoom.CHAT_ROOM_SEQ);
                        }
                    });

                    var $chatTitle = $('<div>', { class: 'chatTitle' });
                    var $spanName = $('<span>').text(chatRoom.CHAT_ROOM_NAME);
                    var $spanNotification = $('<span>', { class: 'notificationCount' }).text(chatRoom.IS_READ);

                    $chatTitle.append($spanName).append($spanNotification);
                    $link.append($chatTitle);
                    $listItem.append($link);
                    chatList.append($listItem);
                });
            },
            error: function(error) {
                console.error("Error loading employee list:", error);
            }
        });
    }
	// 채팅방 팝업 함수
	function showChatRoomPopup(chatRoomSeq) {
	    $.ajax({
	        url: '/chatroom/details',
	        method: 'GET',
	        data: { chat_room_seq: chatRoomSeq },
	        success: function(chatRoomDetails) {
	            // 채팅방 정보를 팝업에 표시
	            $('#chatRoomPopup .chatRoomTitle').text(chatRoomDetails.chat_room_name);
	            $('#chatRoomPopup .chatRoomDetails').html(chatRoomDetails.details_html);
	            $('#chatRoomPopup').css('display', 'flex');
	        },
	        error: function(error) {
	            console.error("Error loading chat room details:", error);
	        }
	    });
	}
	// 채팅방 팝업 닫는 함수
	function closeChatRoomPopup() {
	    $('#chatRoomPopup').css('display', 'none');
	}
	// 1:1 채팅 ajax
	function startPrivateChat(emp_no1, chat_room_name) {
	    $.ajax({
	        url: '/chatroom/create',
	        method: 'POST',
	        data: {
	            emp_no1: emp_no1,
	            chat_room_name: chat_room_name
	        },
	        success: function(response) {
	            if (response === 'success') {
	                alert('1:1 채팅방이 생성되었습니다.');
	                // 여기서 채팅방으로 리다이렉트하거나 UI 업데이트를 할 수 있습니다.
	            } else {
	                alert('채팅방 생성에 실패했습니다.');
	            }
	        },
	        error: function(error) {
	            console.error("Error creating private chat:", error);
	        }
	    });
	}

	// 1:1 채팅 버튼 클릭 이벤트
	$('.chatButton').on('click', function() {
	    var emp_no1 = $('#profilePopup').data('emp_no');
	    var chat_room_name = $('#profilePopup .profileTit span').text();
	    console.log(emp_no1, chat_room_name)
	    startPrivateChat(emp_no1, chat_room_name);
	});
	
	// 단체 채팅 ajax
	function createGroupChat() {
	    var chatRoomName = prompt("채팅방 이름을 입력하세요:");
	    if (chatRoomName) {
	        var selectedEmpNos = [];
	        $('.addressCheckbox:checked').each(function() {
	            selectedEmpNos.push($(this).val());
	        });

	        $.ajax({
	            url: '/chatroom/createGroup',
	            method: 'POST',
	            traditional: true,
	            data: {
	                chatRoomName: chatRoomName,
	                empNos: selectedEmpNos
	            },
	            success: function(response) {
	                if (response === 'success') {
	                    alert('단체 채팅방이 생성되었습니다.');
	                    // 여기서 채팅방으로 리다이렉트하거나 UI 업데이트를 할 수 있습니다.
	                } else {
	                    alert('채팅방 생성에 실패했습니다.');
	                }
	            },
	            error: function(error) {
	                console.error("Error creating group chat:", error);
	            }
	        });
	    }
	}

	// 단체톡방 생성 버튼 클릭 이벤트
	$('.createChatConfirmBtn').on('click', function() {
	    createGroupChat();
	});
	</script>
	</body>
</body>

</html>