let fileToSend = null; // 전송할 파일을 저장하는 변수

// 주소록 토글 이벤트 설정
const toggleItems = document.querySelectorAll('.toggleItem');
toggleItems.forEach(function (toggleItem) {
    const toggleTit = toggleItem.querySelector('.toggleTit');
    const subList = toggleItem.querySelector('.subList');

    if (toggleTit && subList) { // 요소가 존재하는지 확인
        toggleTit.addEventListener('click', function () {
            subList.classList.toggle('active');
            toggleTit.classList.toggle('active'); // 이미지 회전을 위해 클래스 추가
        });
    } else {
        console.error('토글 제목 또는 하위 목록을 찾을 수 없습니다.', toggleItem);
    }
});
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


