$(document).ready(function () {
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
})

// 이미 추가된 파일 이름을 저장하는 배열
let addedFiles = []

// 문서 작성 페이지에서 파일 추가 시 동적으로 요소 생성
$('#file').on('change', function () {

	
    // 선택된 파일들에 대한 파일 객체를 가져와서 저장
    const files = $(this).prop('files')

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
