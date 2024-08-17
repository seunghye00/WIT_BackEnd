$(function() {
	// 현재 페이지의 URL 중 pathname 값만 변수에 저장
	const pathName = window.location.pathname;
	const search = window.location.search; 

	// 쿼리 문자열을 URLSearchParams 객체로 변환
	const params = new URLSearchParams(search);

	// keyword의 값을 가져오기
	const keyword = params.get("keyword");

	const cPage = $('#cPage').val();
	const totalCount = $('#totalCount').val();
	const recordCountPerPage = $('#recordCountPerPage').val();
	const naviCountPerPage = $('#naviCountPerPage').val();
	const type = $('#type').val();	
	
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

	// 현재 페이지의 URL 중 pathname 값만 변수에 저장
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