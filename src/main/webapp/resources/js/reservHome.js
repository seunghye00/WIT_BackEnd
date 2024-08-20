$(function() {
	// 현재 페이지의 URL 중 pathname 값만 변수에 저장
	const pathName = window.location.pathname;
	const search = window.location.search; 

	// 쿼리 문자열을 URLSearchParams 객체로 변환
	const params = new URLSearchParams(search);

	// keyword & type의 값을 가져오기
	const keyword = params.get("keyword");
	const type = params.get("type");

	const cPage = $('#cPage').val();
	const totalCount = $('#totalCount').val();
	const recordCountPerPage = $('#recordCountPerPage').val();
	const naviCountPerPage = $('#naviCountPerPage').val();
	
	// 페이지네이션 초기 설정
	let pageTotalCount = totalCount > 0 ? Math.ceil(totalCount / recordCountPerPage) : 1;
	let startNavi = Math.floor((cPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
	let endNavi = startNavi + naviCountPerPage - 1;
	
 	if (endNavi > pageTotalCount) {
   		endNavi = pageTotalCount;
	}
	let needNext = endNavi < pageTotalCount;
	let needPrev = startNavi > 1;

	// 페이지네이션 HTML 초기화
	const pagination = $('.pagination');
	pagination.empty();

	// 검색한 목록을 출력한 경우
	if(search.includes('keyword')) {
		// '이전' 버튼
		const prevNaviBtn = $('<a>');
		prevNaviBtn.addClass('prev');
		const prevNaviIcon = $('<i>');
		prevNaviIcon.addClass('bx bx-chevron-left');
		prevNaviBtn.append(prevNaviIcon);
		if (needPrev) {
	    	prevNaviBtn.attr('href', pathName + '?type=' + type + '&keyword=' + keyword + '&cPage=' + (startNavi - 1));
		} else {
	    	prevNaviBtn.addClass('disabled');
		}
		pagination.append(prevNaviBtn);
		
		// 페이지 번호
		for (let i = startNavi; i <= endNavi; i++) {
	    	const paginavi = $('<a>');
	    	paginavi.attr('href', pathName + '?type=' + type + '&keyword=' + keyword + '&cPage=' + i);
	    	paginavi.text(i);
	    	if (cPage == i) {
	        	paginavi.addClass('active');
	    	}
	    	pagination.append(paginavi);
		}
	
		// '다음' 버튼
		const nextNaviBtn = $('<a>');
		nextNaviBtn.addClass('prev');
		const nextNaviIcon = $('<i>');
		nextNaviIcon.addClass('bx bx-chevron-right');
		nextNaviBtn.append(nextNaviIcon);
		if (needNext) {
    		nextNaviBtn.attr('href', pathName + '?type=' + type + '&keyword=' + keyword + '&cPage=' + (endNavi + 1));
		} else {
    		nextNaviBtn.addClass('disabled');
		}
		pagination.append(nextNaviBtn);
	
	} else {
		// '이전' 버튼
		const prevNaviBtn = $('<a>');
		prevNaviBtn.addClass('prev');
		const prevNaviIcon = $('<i>');
		prevNaviIcon.addClass('bx bx-chevron-left');
		prevNaviBtn.append(prevNaviIcon);
		if (needPrev) {
    		prevNaviBtn.attr('href', pathName + '?type=' + type + '&cPage=' + (startNavi - 1));
		} else {
    		prevNaviBtn.addClass('disabled');
		}
		pagination.append(prevNaviBtn);
	
		// 페이지 번호
		for (let i = startNavi; i <= endNavi; i++) {
    		const paginavi = $('<a>');
    		paginavi.attr('href', pathName + '?type=' + type + '&cPage=' + i);
	    		paginavi.text(i);
	    	if (cPage == i) {
        		paginavi.addClass('active');
    		}
    		pagination.append(paginavi);
		}

		// '다음' 버튼
		const nextNaviBtn = $('<a>');
		nextNaviBtn.addClass('prev');
		const nextNaviIcon = $('<i>');
		nextNaviIcon.addClass('bx bx-chevron-right');
		nextNaviBtn.append(nextNaviIcon);
			if (needNext) {
    		nextNaviBtn.attr('href', pathName + '?type=' + type + '&cPage=' + (endNavi + 1));
		} else {
    		nextNaviBtn.addClass('disabled');
		}
		pagination.append(nextNaviBtn);	
	}
});

// 검색창 'Enter' 키 감지 시 검색을 수행할 함수 호출
$('#searchTxt').on('keydown', function(e) {
	if (e.keyCode === 13) {
		const keyword = $(this).val().trim();
		goToSearchList(keyword);
    }
});

// 검색창 버튼 클릭 시 검색을 수행할 함수 호출  
$('.searchBtn').on('click', function() {
	const keyword = $('#searchTxt').val().trim();
	goToSearchList(keyword);
});

function goToSearchList(keyword){

	// 현재 페이지의 URL 중 pathname 값과 search 값을 변수에 저장
	const pathName = window.location.pathname;
	const search = window.location.search; 

	// 쿼리 문자열을 URLSearchParams 객체로 변환
	const params = new URLSearchParams(search);

	// type의 값을 가져오기
	const type = params.get("type");
	
	if(keyword == ''){
		location.href = pathName + '?type=' + type + '&cPage=1';
		return;
	}
	
	if (type == 'meetingRoom'){
		location.href = '/reservation/home?type=meetingRoom&keyword=' + keyword + '&cPage=1';
		return;
	} else if (type == 'vehicle'){
		location.href = '/reservation/home?type=vehicle&keyword=' + keyword + '&cPage=1';
		return;
	}
}

// 안내 사항 수정 버튼 클릭 시 
$('#updateGuideLines').on('click', function(){

	// textarea의 값을 변수에 저장
	const guideLines = $('#guideLine').val(); 

    if (guideLines === undefined) {
        console.error('GuideLines is undefined');
        return;
    }

    const trimmedGuideLines = guideLines.trim(); // 앞뒤 공백을 제거합니다

    // 안내 사항이 기본값이거나 비어있으면 경고
    if (trimmedGuideLines === '등록된 안내 사항이 없습니다.' || trimmedGuideLines === '') {
        alert('안내 사항을 먼저 입력해주세요');
        guideLineElement.focus();
        return;
    }
	
	if(confirm('정말로 수정하시겠습니까 ?')){
		// 현재 페이지의 URL 중 search 값을 변수에 저장
		const search = window.location.search; 

		// 쿼리 문자열을 URLSearchParams 객체로 변환
		const params = new URLSearchParams(search);

		// type & seq의 값을 가져오기
		const type = params.get("type");
		const seq = params.get("seq");
		
		// guideLines를 URL 인코딩
        const encodedGuideLines = encodeURIComponent(trimmedGuideLines);
	
		location.href = '/reservation/admin/updateGuideLines?target=' + type + '&seq=' + seq + '&guideLines=' + encodedGuideLines;	
	}
});