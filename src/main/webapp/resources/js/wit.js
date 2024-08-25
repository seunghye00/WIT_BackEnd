let webSocket; // WebSocket 객체
let currentChatRoomSeq; // 현재 활성화된 채팅방 시퀀스
let currentLoginID = null;
let chatHistoryLoaded = false;
let fileToSend = null;


// sidebar 공통요소 script
let btn = $('#btn');
let sideBar = $('.sideBar');

btn.on('click', function() {
	sideBar.toggleClass('active');
});

// 토글 이벤트 설정
const toggleItems = $('.toggleItem');
toggleItems.each(function() {
	const toggleItem = $(this);
    const toggleTit = toggleItem.find('.toggleTit');
    const subList = toggleItem.find('.subList');

    toggleTit.on('click', function() {
    	subList.toggleClass('active');
        toggleTit.toggleClass('active'); // 이미지 회전을 위해 클래스 추가
    });
});
// 툴바 활성화
const links = $('.toolBar a');
links.on('click', function() {
	links.removeClass('active'); // 모든 링크에서 active 클래스 제거
    $(this).addClass('active'); // 클릭한 링크에 active 클래스 추가
});

// 채팅방 
// 로그인 시 WebSocket 연결 설정
function initializeWebSocket() {
    webSocket = new WebSocket('ws://192.168.1.107/chat');

    webSocket.onopen = function (event) {
        console.log("WebSocket is open now.");
    };

	webSocket.onmessage = function(event) {
	    try {
	        let data = JSON.parse(event.data);
           
            if (data.type == "readCountUpdate") {
	            updateReadCountOnClient(data.chatRoomSeq, data.chatSeq, data.updatedReadCount);
	        }
	        
            if (data.type === 'unreadCountUpdate') {
		        updateUnreadCountOnClient(data);
		    }
	        
	        if (data.type == "loginID") {
	            if (data.loginID) {
	                currentLoginID = data.loginID;
	                console.log("LoginID set:", currentLoginID);
	            } else {
	                console.log("Invalid loginID data");
	            }
	        }
	        if (data.type == "chatHistory") {
	            if (currentLoginID && Array.isArray(data.chatHistory)) {
	                data.chatHistory.forEach(function(chat) {
	                    appendMessage(chat, chat.name === currentLoginID ? 'sent' : 'received');
	                });
	            } else {
	                console.log("chatHistory received before loginID is set or invalid chatHistory data");
	            }
	        } 
	        if (data.type == "chat") {
	        	console.log(data);
	            if (data.chat_room_seq == currentChatRoomSeq) {
	                appendMessage(data, data.name === currentLoginID ? 'sent' : 'received');
	                 // 자신이 보낸 메시지는 읽음 처리하지 않도록 조건 추가
	             	if (data.name !== currentLoginID) {
					    console.log("markMessageAsRead called for chatSeq:", data.chat_seq);
					    markMessageAsRead(data.chat_room_seq, data.chat_seq);
					}
	            } else {
	            }
	        }
	        
	        if (data.type == "alarm") {
	        	showNotificationModal(data);
	        }

	    } catch (error) {
	        console.error("Error processing WebSocket message:", error);
	    }
	};

    webSocket.onerror = function(error) {
        console.log("WebSocket error observed:", error);
    };

    webSocket.onclose = function(event) {
        console.log("WebSocket connection closed:", event);
    };
}

// WebSocket 연결 초기화 (로그인 시 호출)
initializeWebSocket();

// 알림이 오면 모달을 자동으로 띄우는 함수
function showNotificationModal(data) {
	console.log(data);
 	var chatRoomSeq = data.chatRoomSeq;
	var empNo = data.empNo; 
	var sender = data.sender; 
	var $chatRoomElement = $(`a[data-chat-room-seq="${chatRoomSeq}"][data-emp-no="${empNo}"]`);
    let modal = document.getElementById("notificationModal");
    // 현재 활성화된 채팅방 시퀀스 저장
    currentChatRoomSeq = chatRoomSeq;
    if ($chatRoomElement.length) {
        if (currentLoginID !== empNo) {
            // 알림 내용 업데이트
		    let notificationList = document.getElementById("notificationList");
		    notificationList.innerHTML = ""; // 기존 알림을 모두 제거
		    let notificationItem = document.createElement("li");
		    notificationItem.textContent = sender + "님이 메시지를 보냈습니다."; // 서버에서 받은 메시지를 그대로 표시
		    notificationList.appendChild(notificationItem);
		
		    // 모달 표시
		    modal.style.display = "block";
		    modal.classList.add("show");
		
		    // 2초 후에 모달을 자동으로 닫음
		    setTimeout(function() {
		        modal.style.display = "none";
		        modal.classList.remove("show");
		    }, 2000); // 2000ms = 3초
		
		    // 모달 닫기 버튼 처리
		    let closeBtn = modal.querySelector(".close");
		    closeBtn.onclick = function() {
		        modal.style.display = "none";
		        modal.classList.remove("show");
		    };
		
		    // 모달 외부 클릭 시 모달 닫기
		    window.onclick = function(event) {
		        if (event.target == modal) {
		            modal.style.display = "none";
		            modal.classList.remove("show");
		        }
		    };
        } else {
             modal.style.display = "none";
        }
    } 
    
}

// 채팅방 목록에서 읽지 않은 메시지 수 업데이트
function updateUnreadCountOnClient(data) {
    var chatRoomSeq = data.chatRoomSeq;
    var unreadCount = data.unreadCount;
    var empNo = data.empNo; 
    // 현재 활성화된 채팅방 시퀀스 저장
    currentChatRoomSeq = chatRoomSeq;
    var $chatRoomElement = $(`a[data-chat-room-seq="${chatRoomSeq}"][data-emp-no="${empNo}"]`);

    if ($chatRoomElement.length) {
        var $unreadCountElement = $chatRoomElement.find('.notificationCount');
        console.log("Found notification element:", $unreadCountElement);

        if ($unreadCountElement.length === 0) {
            console.log("Creating new notification element");
            $unreadCountElement = $('<span>', { 
                class: 'notificationCount' 
            }).appendTo($chatRoomElement.find('.chatTitle'));
        }

        if (unreadCount > 0) {
            $unreadCountElement.text(unreadCount);
            requestAnimationFrame(() => $unreadCountElement.show());
            console.log("Updated unread count to:", unreadCount);
        } else {
            requestAnimationFrame(() => $unreadCountElement.hide());
            console.log("Hiding notification element");
        }
    } 
}
