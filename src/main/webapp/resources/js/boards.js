$(document).ready(function () {
    if ($('#summernote').length)
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
  

    // sidebar 공통요소 script
    let btn = document.querySelector('#btn')

    let sideBar = document.querySelector('.sideBar')

    btn.addEventListener('click', function () {
        console.log('버튼 클릭됨')
        sideBar.classList.toggle('active')
    })

    $('#submitForm').on('submit', function () {
        $('#contents').val($('#summernote').summernote('code'))
    })

    // 이미 추가된 파일 이름을 저장하는 배열
    let addedFiles = []

    // 문서 작성 페이지에서 파일 추가 시 동적으로 요소 생성
    $('#file').on('change', function () {
        // 선택된 파일들에 대한 파일 객체를 가져와서 저장
        const files = $(this).prop('files')
        console.log('file')
        if (files.length + addedFiles.length > 3) {
            alert('파일은 최대 3개까지만 추가 가능합니다.')
            return
        }

        $.each(files, function (index, file) {
            // 파일 이름이 이미 배열에 있는지 확인
            if (!addedFiles.includes(file.name)) {
                // 파일 이름이 배열에 없으면 추가
                addedFiles.push(file.name)

                const span = $('<span>')
                span.text(file.name)
                const delBtn = $('<span>', {
                    class: 'delFileBtn',
                })
                delBtn.text('X')
                span.append(delBtn)
                $('.uploadFiles').append(span)

                // 삭제 버튼 클릭 이벤트
                delBtn.on('click', function () {
                    const fileName = $(this).parent().text().slice(0, -1) // 'X' 제거
                    // 배열에서 파일 이름 제거
                    addedFiles = addedFiles.filter(name => name !== fileName)
                    $(this).parent().remove()
                })
            }
        })
    })
})

// modal script
const modal = document.querySelector('#modal')
const reportBtn = document.querySelector('#reportBtn')
const close = document.querySelector('.rClose')

// 모달창 열기
function openModal() {
    modal.style.display = 'block';
}

// 모달창 닫기
function closeModal() {
    modal.style.display = 'none';
}

// jQuery 사용해서 신고하기 모달창 열기 및 닫기
$(document).ready(function(){
	// 모달 열기
	$('#reportBtn').on('click',function(){
		$('#modal').css('display','block');
	});
	
	// 모달 닫기
	$('.rClose').on('click',function(){
		$('#modal').css('display','none');
	});
});

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
