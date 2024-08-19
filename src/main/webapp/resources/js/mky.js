
// 주소록 툴바 활성화
const links = document.querySelectorAll('.toolBar a')
links.forEach(function (link) {
    link.addEventListener('click', function () {
        links.forEach(function (link) {
            link.classList.remove('active') // 모든 링크에서 active 클래스 제거
        })
        this.classList.add('active') // 클릭한 링크에 active 클래스 추가
    })
})

// 주소록 체크박스
// 전체 선택 체크박스
const checkAll = document.getElementById('checkAll')
// 개별 선택 체크박스들
const individualChecks = document.querySelectorAll('.individual')


	let webSocket; // WebSocket 객체
    let currentChatRoomSeq; // 현재 활성화된 채팅방 시퀀스
    let currentLoginID = null;
    let fileToSend = null;

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
            $('#profilePopup .profileTit img').attr('src', '/uploads/1723616460518_13.jpg'); // 이미지 경로는 실제 데이터에 맞게 수정
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
        	// 기존 내용을 지운 후 새로운 내용을 추가
            var $chatRoomDetails = $('#chatRoomPopup .chatRoomDetails ul');
            $chatRoomDetails.empty();  // 기존 내용을 지웁니다.
        	 response.forEach(function(chatRoomDetails) {
	            // 채팅방 정보를 팝업에 표시
 	           	var $listName = $('<li>').text(chatRoomDetails.MEMBER_NAME);
            	$chatRoomDetails.append($listName);
        		$('#chatRoomPopup .chatRoomTitle h2').text(chatRoomDetails.CHAT_ROOM_NAME);
        	 })

        	$('#chatTitModi').data('chat_room_seq', chatRoomSeq);
        	$('.chatRoomPopupBtn .chatBtn').data('chat_room_seq', chatRoomSeq);
            $('#chatRoomPopup').css('display', 'flex');
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

// 채팅 
// 채팅 시작 함수
function startChat() {
	var chat_room_seq = $('.chatRoomPopupBtn .chatBtn').data('chat_room_seq'); // 여기에서 chat_room_seq를 가져옵니다.
    var chatRoomName = document.querySelector('#chatRoomPopup .chatRoomTitle h2').innerText;
    //activateChatRoom(chatRoomSeq, chatRoomName);
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

    // WebSocket 연결 설정
    if (webSocket) {
        webSocket.close();
    }
    
    webSocket = new WebSocket('ws://192.168.1.4/chat/' + chat_room_seq);
    webSocket.onopen = function (event) {
        console.log("WebSocket is open now.");
    };
    
    webSocket.onmessage = function (event) {
        let data = JSON.parse(event.data);
        if (data.loginID) {
            // 서버에서 보낸 로그인 ID 저장
            currentLoginID = data.loginID;

            // 이전 채팅 내역 처리
            data.chatHistory.forEach(function (chat) {
                appendMessage(chat, chat.sender === currentLoginID ? 'sent' : 'received');
            });
        } else if (data.type === "chat") {
            // 채팅 메시지 처리
            appendMessage(data, data.sender === currentLoginID ? 'sent' : 'received');
            
            // 읽음 처리 호출 (메시지 전송자가 현재 사용자가 아닌 경우에만 호출)
            if (data.sender !== currentLoginID && data.read_count !== 0) {
                markMessageAsRead(data.chat_room_seq, data.chat_seq);
                displayUnreadMessageNotification(data);
            }
        } else if (data.type === "status") {
            // 사용자 상태 메시지 처리 (입장 및 퇴장)
            displayStatusMessage(data);
        }
    };
    

    webSocket.onclose = function (event) {
        console.log("Disconnected from chat room:", chat_room_seq);
    };

    webSocket.onerror = function (event) {
        console.error("WebSocket error:", error);
    };

    // 현재 활성화된 채팅방 시퀀스 저장
    currentChatRoomSeq = chat_room_seq;
}


// 예시: 채팅방 메시지를 로드하는 함수 (서버에서 메시지를 가져오는 로직 추가 필요)
function loadChatMessages(chat_room_seq) {
    // 기존 채팅 메시지 초기화
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
    
    // 만약 메시지가 읽히지 않은 상태라면 `unread` 클래스를 추가합니다.
    if (data.read_count === 1) {
    	readBox.append(data.read_count);
    }

    subBox.append(readBox);
    subBox.append(time_Box);
    message.append(mbox);
    message.append(subBox);
    chatBody.append(message);
    // 스크롤을 최신 메시지로 이동
    chatBody.scrollTop(chatBody[0].scrollHeight);
    
    // 메시지가 화면에 표시되었을 때 읽음 처리 요청을 서버로 보냅니다.
  	if (type === "received" && data.read_count === 1) {
        markMessageAsRead(data.chat_room_seq, data.chat_seq); // chat_seq를 서버로 전송하여 읽음 처리
    }
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
            message: messageHTML
        };
        webSocket.send(JSON.stringify(messageData));
        messageInput.innerHTML = '';
    }
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
    document.getElementById('fileInput').click()
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
                    const formData = new FormData()
                    formData.append('file', file)

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
                    })
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

// 메시지를 읽었을 때 서버로 읽음 처리 요청을 보내는 함수
function markMessageAsRead(chatRoomSeq, messageSeq) {
    $.ajax({
        url: '/chatroom/markAsRead',
        method: 'POST',
        data: {
            chatRoomSeq: chatRoomSeq,
            messageSeq: messageSeq
        },
        success: function(response) {
            if (response === 'success') {

                // 메시지의 readBox를 숨기거나 0으로 설정하여 읽음 상태를 반영
                $('div.message').find('.readBox').filter(function() {
                    return $(this).text() === '1';
                }).text('0').hide(); // 또는 `remove()`로 완전히 제거할 수 있습니다.
            }
        },
        error: function(error) {
            console.error("Error marking message as read:", error);
        }
    });
}