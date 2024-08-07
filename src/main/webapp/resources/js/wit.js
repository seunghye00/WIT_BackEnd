// 공통 js

// sidebar 공통요소 script
let $btn = $('#btn');
let $sideBar = $('.sideBar');

$btn.on('click', function() {
    $sideBar.toggleClass('active');
});

// 토글 이벤트 설정
$('.toggleItem').each(function() {
    let $toggleTit = $(this).find('.toggleTit');
    let $subList = $(this).find('.subList');

    $toggleTit.on('click', function() {
       $subList.toggleClass('active');
       $toggleTit.toggleClass('active'); // 이미지 회전을 위해 클래스 추가
    });
});

// 툴바 활성화
let $links = $('.toolBar a');

$links.on('click', function() {
    $links.removeClass('active'); // 모든 링크에서 active 클래스 제거
    $(this).addClass('active'); // 클릭한 링크에 active 클래스 추가
});   
