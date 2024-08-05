let fileToSend = null // 전송할 파일을 저장하는 변수

// 주소록 토글 이벤트 설정
const toggleItems = document.querySelectorAll('.toggleItem')
toggleItems.forEach(function (toggleItem) {
    const toggleTit = toggleItem.querySelector('.toggleTit')
    const subList = toggleItem.querySelector('.subList')

    toggleTit.addEventListener('click', function () {
        subList.classList.toggle('active')
        toggleTit.classList.toggle('active') // 이미지 회전을 위해 클래스 추가
    })
})

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
