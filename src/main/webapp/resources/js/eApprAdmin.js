// 모달창에서 X 버튼 클릭 시 페이지 새로고침
$('.closeModal').on('click', () => location.reload());

// 문서 열람 페이지에서 목록 버튼 클릭 시 바로 전 페이지로 이동
$('.goBack').on('click', () => {
	// 이전 페이지로 이동
	window.history.back();
});

// 코멘트 버튼 클릭 시 코멘트 리스트 모달창 활성화
$('.viewComm').on('click', () => {
   $('.commModal').toggleClass('flex');
});

// 참조 버튼 클릭 시 참조선 리스트 모달창 활성화
$('.refeBtn').on('click', () => {
    $('.refeModal').toggle();
});

// 결재 or 전결 버튼 클릭 시 결재 코멘트 입력 모달창 활성화
$('.apprBtn').on('click', () => {
    $('.apprModal').css('display', 'flex');

    // 반려 버튼 클릭 시 반려 코멘트 모달창 활성화
    $('.returnBtn').on('click', () => {
        $('.apprModal').hide();
        $('.returnModal').css('display', 'flex');
    });

    // 취소 버튼 클릭 시 현재 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.apprModal').hide();
    });
    
    // 새 결재 진행 버튼 클릭 시 현재 모달창 비활성화
    $('#startApprBtn').on('click', () => {
    	$('.apprModal').hide();
    });
});

// 반려 버튼 클릭 시 반려 코멘트 모달창 활성화
$('.returnBtn').on('click', () => {
    $('.returnModal').css('display', 'flex');

    // 취소 버튼 클릭 시 현재 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.returnModal').hide();
    });
    
    // 결재 버튼 클릭 시 결재 모달창 활성화
    $('.apprBtn').on('click', () => {
    	$('.returnModal').hide();
    	$('.apprModal').css('display', 'flex');
    });
    
    // 새 결재 진행 버튼 클릭 시 현재 모달창 비활성화
    $('#startApprBtn').on('click', () => {
    	$('.returnModal').hide();
    });
});

// 반려 코멘트 모달창에서 완료 버튼 클릭 시
$('.docuReturn').on('click', () => {
	if($('#returnComm').val().trim() == ""){
		alert('코멘트를 입력해주세요');
		$('#returnComm').focus();
		return;
	}
	$('#returnComm').val($('#returnComm').val().trim());
	location.href="/eApproval/admin/returnDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#returnComm').val();
}); 

// 결재 코멘트 모달창에서 결재 버튼 클릭 시
$('.docuAppr').on('click', () => {
	if($('#apprComm').val().trim() == ""){
		alert('코멘트를 입력해주세요');
		$('#apprComm').focus();
		return;
	}
	$('#apprComm').val($('#apprComm').val().trim());
	if($('.docuWrite').hasClass('docuLeave')){
		location.href="/eApproval/admin/apprDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#apprComm').val() + '&applyLeaves=' + $('#applyLeaves').val();
	}
	location.href="/eApproval/admin/apprDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#apprComm').val();
}); 

// 결재 코멘트 모달창에서 전결 버튼 클릭 시
$('.docuAllAppr').on('click', () => {
	if($('#apprComm').val().trim() == ""){
		alert('코멘트를 입력해주세요');
		$('#apprComm').focus();
		return;
	}
	$('#apprComm').val($('#apprComm').val().trim());
	if($('.docuWrite').hasClass('docuLeave')){
		location.href="/eApproval/admin/apprAllDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#apprComm').val() + '&applyLeaves=' + $('#applyLeaves').val();
	}
	location.href="/eApproval/admin/apprAllDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#apprComm').val();
}); 

$(function() {
	// 현재 페이지의 URL 중 pathname 값만 변수에 저장
	let pathName = window.location.pathname;

	// 현재 페이지가 문서 보관함이 아니라면 페이지네이션 실행하지 않음.
	if(!pathName.includes('List')){
		return;
	}
	const cPage = $('#cPage').val();
	const totalCount = $('#totalCount').val();
	const recordCountPerPage = $('#recordCountPerPage').val();
	const naviCountPerPage = $('#naviCountPerPage').val();
	const docuCode = $('#docuCode').val();
	const type = $('#type').val();	
	const keyword = $('#keyword').val();
	
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
		
	// 검색 결과 페이지일 경우
	if(pathName.includes('search')) {
		
		// '이전' 버튼
		const prevNaviBtn = $('<a>');
		prevNaviBtn.addClass('prev');
		const prevNaviIcon = $('<i>');
		prevNaviIcon.addClass('bx bx-chevron-left');
		prevNaviBtn.append(prevNaviIcon);
		if (needPrev) {
			if(docuCode == ""){
    			prevNaviBtn.attr('href', pathName + '?type=' + type + '&keyword=' + keyword + '&cPage=' + (startNavi - 1));
    		} else {
    			prevNaviBtn.attr('href', pathName + '?type=' + type + '&docuCode=' + docuCode + '&keyword=' + keyword + '&cPage=' + (startNavi - 1));
    		}
		} else {
    		prevNaviBtn.addClass('disabled');
		}
		pagination.append(prevNaviBtn);
	
		// 페이지 번호
		for (let i = startNavi; i <= endNavi; i++) {
    		const paginavi = $('<a>');
    	
    		if(docuCode == ""){
    			paginavi.attr('href', pathName + '?type=' + type + '&keyword=' + keyword + '&cPage=' + i);
    		} else {
    			paginavi.attr('href', pathName + '?type=' + type + '&docuCode=' + docuCode + '&keyword=' + keyword + '&cPage=' + i);
    		}
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
			if(docuCode == ""){
    			nextNaviBtn.attr('href', pathName + '?type=' + type + '&keyword=' + keyword + '&cPage=' + (endNavi + 1));
    		} else {
    			nextNaviBtn.attr('href', pathName + '?type=' + type + '&docuCode=' + docuCode + '&keyword=' + keyword + '&cPage=' + (endNavi + 1));
    		}
		} else {
    		nextNaviBtn.addClass('disabled');
		}
		pagination.append(nextNaviBtn);
		
	// 검색을 하지 않은 상태의 보관함인 경우
	} else {

		// '이전' 버튼
		const prevNaviBtn = $('<a>');
		prevNaviBtn.addClass('prev');
		const prevNaviIcon = $('<i>');
		prevNaviIcon.addClass('bx bx-chevron-left');
		prevNaviBtn.append(prevNaviIcon);
		if (needPrev) {
    		if(docuCode == ""){
    			prevNaviBtn.attr('href', pathName + '?type=' + type + '&cPage=' + (startNavi - 1));
    		} else {
    			prevNaviBtn.attr('href', pathName + '?type=' + type + '&docuCode=' + docuCode + '&cPage=' + (startNavi - 1));
    		}} else {
    		prevNaviBtn.addClass('disabled');
		}
		pagination.append(prevNaviBtn);
	
		// 페이지 번호
		for (let i = startNavi; i <= endNavi; i++) {
    	
    		const paginavi = $('<a>');
    	
    		if(docuCode == ""){
    			paginavi.attr('href', pathName + '?type=' + type + '&cPage=' + i);
    		} else {
    			paginavi.attr('href', pathName + '?type=' + type + '&docuCode=' + docuCode + '&cPage=' + i);
    		}
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
			if(docuCode == ""){
    			nextNaviBtn.attr('href', pathName + '?type=' + type + '&cPage=' + (endNavi + 1));
    		} else {
    			nextNaviBtn.attr('href', pathName + '?type=' + type + '&docuCode=' + docuCode + '&cPage=' + (endNavi + 1));
    		}
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
	// 현재 페이지의 문서함 타입과 문서 코드를 변수에 저장
	const docuCode = $('#docuCode').val();
	const type = $('#listType').val();

	// 현재 페이지의 URL pathname 값 중 마지막 단어만 변수에 저장
	const pathName = window.location.pathname;
	const docuList = pathName.split('/').pop();
	
	// 변수에 저장된 값을 서버에 전송
	location.href = '/eApproval/admin/' + docuList + '?type=' + type + '&docuCode=' + docuCode + '&keyword=' + keyword + '&cPage=1';
}