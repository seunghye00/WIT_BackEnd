$(document).ready(function () {
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
   // document.getElementById('modal').style.display = 'block'
   
}

// 모달창 닫기
function closeModal() {
    document.getElementById('modal').style.display = 'none'
}

// 신고하기 버튼 클릭 시 모달 열기
//document.getElementById('reportBtn').onclick = openModal;
$("#reportBtn").on("click",()=>{
	 $("#modal").css("display","block");
})

/*
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
}*/