let webSocket; // WebSocket 객체
let currentChatRoomSeq; // 현재 활성화된 채팅방 시퀀스
let currentLoginID = null;
let chatHistoryLoaded = false;
let fileToSend = null;

// 채팅방 
// 채팅방 사이드 영역 보기 전환
function toggleView(view) {
    const chatList = document.getElementById('chatList');
    const addressList = document.getElementById('addressList');
    const sideTitle = document.getElementById('sideTitle');
    const createGroup = document.getElementById('createGroup');
    const chatButton = document.querySelector(
        '.toggleBtn[onclick="toggleView(\'chat\')"]'
    );
    const addressButton = document.querySelector(
        '.toggleBtn[onclick="toggleView(\'address\')"]'
    );

    if (view === 'chat') {
        chatList.style.display = 'block'; // 채팅방 리스트 보이기
        addressList.style.display = 'none'; // 주소록 리스트 숨기기
        sideTitle.innerText = '채팅방'; // 제목을 '채팅방'으로 변경
        chatButton.style.display = 'none'; // '채팅방' 버튼 숨기기
        addressButton.style.display = 'inline-block'; // '주소록' 버튼 보이기
        createGroup.style.display = 'none'; // 그룹 채팅 생성 버튼 숨기기
        clearCheckboxes();   // 체크박스 초기화
    } else {
        chatList.style.display = 'none'; // 채팅방 리스트 숨기기
        addressList.style.display = 'block'; // 주소록 리스트 보이기
        sideTitle.innerText = '주소록'; // 제목을 '주소록'으로 변경
        chatButton.style.display = 'inline-block'; // '채팅방' 버튼 보이기
        addressButton.style.display = 'none'; // '주소록' 버튼 숨기기
        createGroup.style.display = 'inline-block'; // 그룹 채팅 생성 버튼 보이기
        clearCheckboxes();   // 체크박스 초기화
    }
}
// 로그인 시 WebSocket 연결 설정
function initializeWebSocket() {
    webSocket = new WebSocket('ws://192.168.1.107/chat');

    webSocket.onopen = function (event) {
        console.log("WebSocket is open now.");
    };

	webSocket.onmessage = function(event) {
	    try {
	        let data = JSON.parse(event.data);
			console.log(data);
            if (data.type == "readCountUpdate") {
	            updateReadCountOnClient(data.chatRoomSeq, data.chatSeq, data.updatedReadCount);
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
	            if (data.chat_room_seq == currentChatRoomSeq) {
	                appendMessage(data, data.name === currentLoginID ? 'sent' : 'received');
	                 // 자신이 보낸 메시지는 읽음 처리하지 않도록 조건 추가
	             	if (data.name !== currentLoginID) {
					    console.log("markMessageAsRead called for chatSeq:", data.chat_seq);
					    markMessageAsRead(data.chat_room_seq, data.chat_seq);
					}
	            } else {
	                showNotificationModal(`${data.sender}님이 새 메시지를 보냈습니다`);
	                console.log("Ignoring message for chat room:", data.chat_room_seq);
	            }
	        }
	        if (data.type == "status") {
	            displayStatusMessage(data);
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
function showNotificationModal(message) {
    let modal = document.getElementById("notificationModal");

    // 알림 내용 업데이트
    let notificationList = document.getElementById("notificationList");
    notificationList.innerHTML = ""; // 기존 알림을 모두 제거
    let notificationItem = document.createElement("li");
    notificationItem.textContent = message; // 서버에서 받은 메시지를 그대로 표시
    notificationList.appendChild(notificationItem);

    // 모달 표시
    modal.style.display = "block";
    modal.classList.add("show");

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
}

// 채팅 시작 함수
function startChat(chat_room_seq) {
    var chatRoomName = document.querySelector('#chatRoomPopup .chatRoomTitle h2').innerText;

    // 모든 li 요소에서 active 클래스 제거
    document.querySelectorAll('.chatList li').forEach(function (li) {
        li.classList.remove('active');
    });

    // 해당 chatRoomSeq를 가진 li 요소에 active 클래스 추가
    var activeLi = document.querySelector('.chatList li a[data-chat-room-seq="' + chat_room_seq + '"]');
    if (activeLi) {
        activeLi.classList.add('active');
    }

    // 채팅방 제목 변경
    document.querySelector('.chatHeader .title').innerText = chatRoomName;
    closeChatRoomPopup(); // 팝업 닫기

    // 채팅방 메시지를 로드
    loadChatMessages(chat_room_seq);

    // 현재 활성화된 채팅방 시퀀스 저장
    currentChatRoomSeq = chat_room_seq;

    // WebSocket이 열려 있는 경우, 서버에 chatRoomSeq를 전달
    if (webSocket && webSocket.readyState === WebSocket.OPEN) {
        webSocket.send(JSON.stringify({ type: 'join', chatRoomSeq: chat_room_seq }));
    } else {
        console.error("WebSocket is not open or initialized.");
    }
}

// 예시: 채팅방 메시지를 로드하는 함수 (서버에서 메시지를 가져오는 로직 추가 필요)
function loadChatMessages(chat_room_seq) {
    $('#chatBody').empty();
    var activeLi = document.querySelector('.chatList li a[data-chat-room-seq="' + chat_room_seq + '"]');
    if (activeLi) {
        activeLi.parentElement.classList.add('active'); // parentElement를 사용하여 li 요소에 active 클래스 추가
    }
}

// 메시지를 화면에 추가하고, 읽음 처리하는 함수
function appendMessage(data, type) {
    let chatBody = $("#chatBody");
    let mbox = $("<div>").addClass("text_box");
    let id_Box = $("<div>").addClass("sender");
    let subBox = $("<div>").addClass("subBox");
    let time_Box = $("<div>").addClass("timeBox");
    let readBox = $("<div>").addClass("readBox");
    let message = $("<div>").addClass("message");

    // 메시지 데이터를 HTML로 삽입
    mbox.html(data.message);
    time_Box.text(data.send_time);
    
    if (type === "received") {
        message.addClass("received");
        id_Box.text(data.sender + ":");
        message.append(id_Box);
    } else {
        message.addClass("sent");
    }
    
    // `chatSeq`를 메시지에 데이터 속성으로 저장 (나중에 읽음 수 업데이트 시 사용)
    message.attr("data-chat-seq", data.chat_seq);
    // `read_count`를 반영하여 보여줌
    if (data.read_count > 0) {
        readBox.text(data.read_count);
        readBox.show();
    } else {
        readBox.hide(); // read_count가 0이면 숨김
    }

    subBox.append(readBox);
    subBox.append(time_Box);
    message.append(mbox);
    message.append(subBox);
    chatBody.append(message);

    // 스크롤을 최신 메시지로 이동
    chatBody.scrollTop(chatBody[0].scrollHeight);
    
    // append 후에 readCountUpdate가 있을 경우 바로 업데이트
    checkAndUpdateReadCount(data.chat_room_seq, data.chat_seq);
}

function displayStatusMessage(data) {
    let statusMessage = $("<div>").addClass("message status");
    let statusText = "";
    
    if (data.status === "joined") {
        statusText = data.user + "님이 입장하셨습니다";
    } else if (data.status === "left") {
        statusText = data.user + "님이 퇴장하셨습니다";
    }

    statusMessage.text(statusText);
    $("#chatBody").append(statusMessage);
    $("#chatBody").scrollTop($("#chatBody")[0].scrollHeight);
}

// 메시지를 전송하는 함수
function sendMessage() {
    const messageInput = document.getElementById('messageInput');
    const messageHTML = messageInput.innerHTML.trim();
    if (messageHTML !== '' && webSocket && currentChatRoomSeq) {
        const messageData = {
            chatRoomSeq: currentChatRoomSeq,  // 현재 채팅방의 chatRoomSeq를 포함
            message: messageHTML // messageHTML로 수정
        };
        webSocket.send(JSON.stringify({ type: 'chat', chatRoomSeq: currentChatRoomSeq, message: messageHTML }));
        messageInput.innerHTML = ''; // 입력 필드 초기화
        
    } else {
        console.error("Message is empty or WebSocket is not connected.");
    }
}

// 메시지를 읽었을 때 서버로 읽음 처리 요청을 보내는 함수
// 사용자가 메시지를 읽었을 때 호출되는 함수
function markMessageAsRead(chatRoomSeq, chatSeq) {
    console.log(`markMessageAsRead called for chatSeq: ${chatSeq}, chatRoomSeq: ${chatRoomSeq}`);
    const message = JSON.stringify({
        type: "read",
        chatRoomSeq: chatRoomSeq,
        chatSeq: chatSeq,
        userName: currentLoginID
    });
    webSocket.send(message);
}

// 여기서부터는 채팅 이외의 다른 UI 요소와 관련된 코드입니다.
// 주소록 툴바 활성화
const links = document.querySelectorAll('.toolBar a');
links.forEach(function (link) {
    link.addEventListener('click', function () {
        links.forEach(function (link) {
            link.classList.remove('active'); // 모든 링크에서 active 클래스 제거
        });
        this.classList.add('active'); // 클릭한 링크에 active 클래스 추가
    });
});

// 주소록 체크박스
const checkAll = document.getElementById('checkAll');
const individualChecks = document.querySelectorAll('.individual');

// 주소록 항목의 체크박스와 확인 버튼을 토글
function toggleCheckboxes() {
    const checkboxes = document.querySelectorAll('.addressCheckbox');
    const confirmBtn = document.querySelector('.createChatConfirmBtn');
    checkboxes.forEach(checkbox => {
        checkbox.style.display = checkbox.style.display === 'none' ? 'inline-block' : 'none'; // 체크박스 토글
    });
    confirmBtn.style.display = confirmBtn.style.display === 'none' ? 'inline-block' : 'none'; // 확인 버튼 토글
    clearCheckboxes();   // 체크박스 초기화
}

// 주소록 항목의 체크박스를 클릭하여 선택 상태를 토글
function toggleCheckbox(event, element, emp_no) {
    event.preventDefault();
    const checkbox = element.querySelector('.addressCheckbox');
    checkbox.checked = !checkbox.checked;
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
            $('#profilePopup .profileTit img').attr('src', employee.PHOTO); // 이미지 경로는 실제 데이터에 맞게 수정
            $('#profilePopup .profileTit span').text(employee.NAME);
            $('#profileDept').text(employee.DEPT_TITLE);
            $('#profileRole').text(employee.ROLE_TITLE);
            $('#profilePhone').text(employee.PHONE);
            $('#profileEmail').text(employee.EMAIL);
            
            // emp_no를 데이터 속성으로 저장
            $('#profilePopup').data('emp_no', employee.EMP_NO);

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
    document.getElementById('profilePopup').style.display = 'none'; // 팝업 숨기기
}

// 선택된 주소록 항목을 수집하여 그룹 채팅 생성
function createChat() {
    const selectedAddresses = [];
    const checkboxes = document.querySelectorAll('.addressCheckbox');
    checkboxes.forEach((checkbox, index) => {
        if (checkbox.checked) {
            selectedAddresses.push(`주소록 ${index + 1}`); // 체크된 항목의 이름을 배열에 추가
        }
    });
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
				addressList.append('<li><a href="javascript:;" data-emp-no="' + employee.EMP_NO + '" onclick="toggleCheckbox(event, this)"><input type="checkbox" class="addressCheckbox" value="' + employee.EMP_NO + '" style="display: none;">' + employee.DEPT_TITLE + ' ' + employee.ROLE_TITLE + ' ' + employee.NAME + '</a></li>');
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
            var chatList = $('#chatList');
            chatList.empty(); // 기존 목록 초기화

            response.forEach(function(chatRoom) {
            	console.log(chatRoom);
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
                $chatTitle.append($spanName);
                
                // 읽지 않은 메시지가 있는 경우 표시
                if (chatRoom.UNREAD_COUNT > 0) {
                    var $unreadCount = $('<span>', { 
                        class: 'notificationCount' 
                    }).text(chatRoom.UNREAD_COUNT);
                    $chatTitle.append($unreadCount);
                }

                $link.append($chatTitle);
                $listItem.append($link);
                chatList.append($listItem);
                
            });
        },
        error: function(error) {
            console.error("Error loading chat rooms:", error);
        }
    });
}

// 채팅방 팝업 함수
function showChatRoomPopup(chatRoomSeq) {
    $.ajax({
        url: '/chatroom/details',
        method: 'GET',
        data: { chat_room_seq: chatRoomSeq },
        success: function(response) {

            // 채팅방 이름 설정
           	response.chatName.forEach(function(chatName) {
                // 멤버 정보를 리스트에 추가
	            $('#chatRoomPopup .chatRoomTitle h2').text(chatName.CHAT_ROOM_NAME);
            });

            // 멤버 목록 설정
            var $chatRoomDetails = $('#chatRoomPopup .chatRoomDetails ul');
            $chatRoomDetails.empty();  // 기존 내용을 지웁니다.

            response.members.forEach(function(member) {
                // 멤버 정보를 리스트에 추가
                var $listName = $('<li>').text(member.MEMBER_NAME);
                $chatRoomDetails.append($listName);
            });

            // 데이터 속성에 chat_room_seq 설정
            $('#chatTitModi').data('chat_room_seq', chatRoomSeq);
            $('.chatRoomPopupBtn .chatBtn').data('chat_room_seq', chatRoomSeq);

            // 팝업 표시
            $('#chatRoomPopup').css('display', 'flex');
            
           	// 버튼의 onclick 속성에 chatRoomSeq를 포함하여 업데이트
            $('.chatRoomPopupBtn .chatBtn').attr('onclick', `startChat(${chatRoomSeq})`);
        },
        error: function(error) {
            console.error("Error loading chat room details:", error);
        }
    });
}

// 채팅방 제목 수정
function editTitle() {
    var new_title = prompt("새 채팅방 제목을 입력하세요:");
    if (new_title) {
        var chat_room_seq = $('#chatTitModi').data('chat_room_seq'); // 여기에서 chat_room_seq를 가져옵니다.
        $('#chatRoomPopup .chatRoomTitle h2').text(new_title);
        // 서버에 새로운 제목을 저장하는 AJAX 요청을 보냅니다.
        $.ajax({
            url: '/chatroom/updateTitle',
            method: 'POST',
            data: { chat_room_seq: chat_room_seq, new_title: new_title },
            success: function(response) {
                alert("채팅방 제목이 변경되었습니다.");
                toggleView('chat');
                loadChatList();
            },
            error: function(error) {
                console.error("Error updating chat room title:", error);
            }
        });
    }
}

// 채팅방 나가기
function exitChatRoom() {
    var chat_room_seq = $('#chatTitModi').data('chat_room_seq');
    $.ajax({
        url: '/chatroom/exit',
        method: 'POST',
        data: { chat_room_seq : chat_room_seq},
        success: function(response) {
            if (response == "success") {
                alert("채팅방에서 나갔습니다.");
                closeChatRoomPopup();
                toggleView('chat');
                loadChatList();
            } else {
                alert("채팅방 나가기에 실패했습니다.");
            }
        },
        error: function(error) {
            console.error("Error exiting chat room:", error);
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
                closeProfilePopup();
                toggleView('chat');
                loadChatList();
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
                    toggleView('chat');
                    loadChatList();
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
    toggleView('chat');  // 채팅방으로 전환
    toggleCheckboxes();  // 체크박스와 확인 버튼 숨기기
    clearCheckboxes();   // 체크박스 초기화
});

// 체크박스 초기화 함수
function clearCheckboxes() {
    const checkboxes = document.querySelectorAll('.addressCheckbox');
    checkboxes.forEach(checkbox => {
        checkbox.checked = false;  // 체크 해제
    });
}

// 파일 업로드 함수
function uploadImage(file) {
    let formData = new FormData();
    formData.append("image", file);

    return fetch('/uploadImage', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            return data.url; // 업로드된 파일 URL 반환
        } else {
            throw new Error(data.message);
        }
    });
}

// 파일 입력 필드를 트리거하는 함수
function triggerFileInput() {
    document.getElementById('fileInput').click();
}

// 파일 입력을 처리하는 함수
function handleFileInput(event) {
    const file = event.target.files[0];
    if (file) {
        fileToSend = file; // 전송할 파일을 설정
        document.getElementById('filePopup').style.display = 'block'; // 파일 전송 여부를 묻는 팝업 표시
    } else {
        console.log("No file selected or file is empty."); // 디버깅 로그 추가
    }
}

// 파일 전송을 확인하는 함수
function confirmFileSend() {
    if (!fileToSend) {
        alert('No file selected.');
        return;
    }
    const formData = new FormData();
    formData.append('file', fileToSend);

    fetch('/uploadImage', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            const messageInput = document.getElementById('messageInput');
            messageInput.innerHTML = '';

            if (fileToSend.type.startsWith('image/')) {
                const img = document.createElement('img');
                img.src = data.url;
                img.alt = "Uploaded Image";
                img.style.maxWidth = "100%";
                img.style.maxHeight = "200px";
                messageInput.appendChild(img);
            } else {
                const fileLink = document.createElement('a');
                fileLink.href = data.url;
                fileLink.download = fileToSend.name;
                fileLink.textContent = fileToSend.name;
                messageInput.appendChild(fileLink);
            }

            sendMessage();
            cancelFileSend();
        } else {
            alert('Error uploading file: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error uploading file:', error);
        alert('Error uploading file: ' + error.message);
    });
}

// 파일 전송을 취소하는 함수
function cancelFileSend() {
    document.getElementById('filePopup').style.display = 'none';
    document.getElementById('fileInput').value = '';
    fileToSend = null;
}

// 클립보드에서 이미지를 붙여넣는 함수
function addPasteImageListener(elementId) {
    const messageInput = document.getElementById(elementId);
    if (messageInput) {
        messageInput.addEventListener('paste', function (event) {
            const items = (event.clipboardData || window.clipboardData).items;
            for (let item of items) {
                if (item.type.indexOf('image') !== -1) {
                    const file = item.getAsFile();
                    const formData = new FormData();
                    formData.append('file', file);

                    fetch('/uploadImage', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            const img = document.createElement('img');
                            img.src = data.url;
                            img.alt = "Pasted Image";
                            img.style.maxWidth = "100%";
                            img.style.maxHeight = "200px";
                            messageInput.innerHTML = '';
                            messageInput.appendChild(img);
                        } else {
                            alert('Error uploading image: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error uploading image:', error);
                        alert('Error uploading image: ' + error.message);
                    });
                }
            }
        });
    }
}

// 키 다운 이벤트 처리 (엔터 키로 메시지 전송)
function handleKeyDown(event) {
    if (event.key === 'Enter' && !event.shiftKey) {
        event.preventDefault();
        sendMessage();
    }
}

// 이모티콘 컨테이너를 토글하는 함수
function toggleEmojiContainer() {
    const emojiContainer = document.getElementById('emojiContainer');
    const chatBody = document.getElementById('chatBody');

    if (emojiContainer.style.display === 'flex') {
        emojiContainer.style.display = 'none';
        chatBody.style.paddingBottom = '20px';
    } else {
        emojiContainer.style.display = 'flex';
        chatBody.style.paddingBottom = `${emojiContainer.clientHeight + 20}px`;
    }
}

// 이모티콘을 메시지 입력 필드에 추가하는 함수
function addEmojiToMessageInput(imgElement) {
    const messageInput = document.getElementById('messageInput');
    const img = document.createElement('img');
    img.src = imgElement.src;
    img.style.maxWidth = '100%';
    img.style.maxHeight = '100px';
    messageInput.appendChild(img);
}

function updateReadCountOnClient(chatRoomSeq, chatSeq, updatedReadCount) {
    let messageElement = document.querySelector(`.message[data-chat-seq="${chatSeq}"] .readBox`);
    
    if (messageElement) {
        if (updatedReadCount > 0) {
            messageElement.textContent = updatedReadCount;
            messageElement.style.display = 'block';
        } else {
            messageElement.style.display = 'none';
        }
    } else {
        setTimeout(() => updateReadCountOnClient(chatRoomSeq, chatSeq, updatedReadCount), 100);
    }
}



// 메시지의 읽음 상태를 서버에 확인하고, 필요시 업데이트하는 함수
function checkAndUpdateReadCount(chatRoomSeq, chatSeq) {
    $.ajax({
        url: '/chatroom/checkReadCount',
        method: 'POST',
        data: {
            chatRoomSeq: chatRoomSeq,
            chatSeq: chatSeq
        },
        success: function(response) {
            if (response.status === 'success') {
                const updatedReadCount = response.updated_read_count;
                let readBox = $(`.message[data-chat-seq="${chatSeq}"] .readBox`);

                if (updatedReadCount > 0) {
                    readBox.text(updatedReadCount);
                    readBox.show();
                } else {
                    readBox.hide();
                }
            }
        },
        error: function(error) {
            console.error("Error checking read count:", error);
        }
    });
}