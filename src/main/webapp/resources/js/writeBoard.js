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
