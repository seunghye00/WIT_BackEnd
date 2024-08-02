$(document).ready(function () {
    /*
    $('#summernote').summernote({
        height: 400, // 기본 높이 설정
        minHeight: null, // 최소 높이 설정
        maxHeight: null, // 최대 높이 설정
        focus: true, // 페이지 로드 시 포커스
        callbacks: {
            onInit: function () {
                // summernote 초기화 후 note-statusbar 요소 제거
                $('.note-statusbar').remove()
            },
        },
    })
    */
    
    // sidebar 공통요소 script
	let btn = document.querySelector('#btn')

	let sideBar = document.querySelector('.sideBar')

	btn.addEventListener('click', function () {
		console.log("버튼 클릭됨");
	    sideBar.classList.toggle('active')
	})
	
	
})

// modal script
const modal = document.querySelector('#modal')
const reportBtn = document.querySelector('#reportBtn')
const close = document.querySelector('.rClose')

// 모달창 열기
function openModal() {
    document.getElementById('modal').style.display = 'block'
}

// 모달창 닫기
function closeModal() {
    document.getElementById('modal').style.display = 'none'
}

// 신고하기 버튼 클릭 시 모달 열기
document.getElementById('reportBtn').onclick = function () {
    openModal()
}

// 닫기 버튼 클릭 시 모달 달기
document.getElementById('reportBtn').onclick = function () {
    closeModal()
}

// 댓글 글자 수 제한 script
function reply() {
    const textarea = document.querySelector('.writeRly')
    const maxLength = 300

    textarea.addEventListener('input', function () {
        if (textarea.value.length > maxLength) {
            textarea.value = textarea.value.slice(0, maxLength)
            alert('300자 초과함')
        }
    })
}