// 새 결재 진행 클릭 시 문서 양식 선택 모달창 활성화
$('#startApprBtn').on('click', () => {
	
	// 해당 버튼 비활성화
	$('#startApprBtn').addClass('disabled');
	
	// 해당 모달창 활성화
    $('.eApprModal.docuChoiModal').css({ display: 'flex' });
	
	// 문서 종류를 저장할 변수
    let docu;
	
	// 서버에서 문서 양식 리스트를 받아오기 위한 로직
	$.ajax({
        url: '/eApproval/getDocuList',
        type: 'post',
		dataType: "json"
    }).done((resp)=>{

    	const ul = $('#docuNameList');
    	ul.empty();
    	
    	for (let i of resp){
    		let li = $('<li>');
    		let input = $('<input>',{
    			type: 'checkbox',
                name: 'docuName',
                id: i.docu_code,
                value: i.docu_code
    		});
    		let label = $('<label>',{
    			for: i.docu_code
    		});
    		label.text(i.name);
    		li.append(input, label);
    		ul.append(li);
    	}
    	
    	// check 박스로 문서 선택 후 변수에 저장
    	$("input[name='docuName']").on('click', function () {
       		docu = noMultiClick(this, 'docuChoiModal')
    	});
    	
    }).fail((jqXHR, textStatus, errorThrown) => {
    	console.error('AJAX 요청 실패:', textStatus, errorThrown);
	});

    // 해당 모달창에서 다음 버튼 클릭 시
    $('.next').on('click', () => {
        // 문서 종류 선택 전 다음 버튼 클릭 시 안내문
        if (docu === undefined) {
            alert('문서 종류를 먼저 선택해주세요.');
            return;
        }

        // 문서 양식 선택 모달창 비활성화 & 결재선 선택 모달창 활성화
        $('.eApprModal.docuChoiModal').css({ display: 'none' });
        $('.eApprModal.apprChoiModal').css({ display: 'flex' });

        // 부서 종류를 저장할 변수
        let dept;

		// 서버에서 부서 리스트를 받아오기 위한 로직
		$.ajax({
        	url: '/dept/getList',
        	type: 'post',
			dataType: "json"
    	}).done((resp)=>{

    		const ul = $('#deptList');
    		ul.empty();
    	
    		for (let i of resp){
    			let li = $('<li>');
    			let input = $('<input>',{
    				type: 'checkbox',
                	name: 'deptName',
                	id: i.dept_code,
                	value: i.dept_code,
    			});
    			input.hide();
    			let label = $('<label>',{
    				for: i.dept_code
    			});
    			label.text(i.dept_title);
    			li.append(input, label);
    			ul.append(li);
    		}
    		
    		// check 박스로 문서 선택 후 변수에 저장
        	$("input[name='deptName']").on('click', function () {
            	dept = noMultiClick(this, 'apprChoiModal')
            	getEmployeeList(dept);
        	});
    	});

		// 결재선 추가 버튼 클릭
		$('#addAppr').on('click',()=>{
		
			const checkBoxes = $('input[name="employeeName"]:checked');
			const apprBoxes = $('input[name="apprList"]:checked');
			const refeBoxes = $('input[name="refeList"]:checked');
	
			apprBoxes.prop('checked', false);
			refeBoxes.prop('checked', false);
			
			// 이미 추가된 결재자 수를 확인
    		const addedCount = $('#firAppr input').length + $('#secAppr input').length + $('#thirAppr input').length;
    
    		if (addedCount + checkBoxes.length > 3) {
        		alert("최대 3명까지만 선택 가능합니다.");
        		checkBoxes.prop('checked', false);
        		return;
    		}

    		checkBoxes.each(function() {
        		
        		const li = $(this).closest('li');
        		
        		// 해당 input 요소와 label 요소를 임시로 저장
    			const input = $(this).detach();
    			const label = $(`label[for="${this.id}"]`).detach();
       			
       			
       			// input과 label을 감싸고 있는 li 태그 삭제
    			li.remove();
       			
       			if ($('#firAppr input').length === 0) {
            		$('#firAppr').append(input, label);
        		} else if ($('#secAppr input').length === 0) {
            		$('#secAppr').append(input, label);
        		} else if ($('#thirAppr input').length === 0) {
            		$('#thirAppr').append(input, label);
        		}

        		// name 속성 변경
        		$(this).attr('name', 'apprList');
    		});
    		checkBoxes.prop('checked', false);
		});
		
		// 결재선 삭제 버튼 클릭 
		$('#delAppr').on('click',()=>{
			const checkBoxes = $('input[name="apprList"]:checked');
			const empBoxes = $('input[name="employeeName"]:checked');
			const refeBoxes = $('input[name="refeList"]:checked');
	
			empBoxes.prop('checked', false);
			refeBoxes.prop('checked', false);
			
			checkBoxes.each(function(index) {
    
        		// 해당 요소 삭제 후 사원 목록 새로고침
        		$(this).remove();
        		$(`label[for="${this.id}"]`).remove();
        		const dept = $('input[name="deptName"]:checked').val();
    			getEmployeeList(dept);
    		});
    		checkBoxes.prop('checked', false);
		});
		
		// 참조선 추가 버튼 클릭
		$('#addRefe').on('click',()=>{
			const checkBoxes = $('input[name="employeeName"]:checked');
			const apprBoxes = $('input[name="apprList"]:checked');
			const refeBoxes = $('input[name="refeList"]:checked');
	
			apprBoxes.prop('checked', false);
			refeBoxes.prop('checked', false);

    		checkBoxes.each(function() {
        		
        		const label = $(`label[for="${this.id}"]`);
       			const li = $('<li>');
       			li.append(this, label);
       			$('#refeList').append(li);
       			
        		// name 속성 변경
        		$(this).attr('name', 'refeList');
    		});
    		checkBoxes.prop('checked', false);
		});
		
		// 참조선 삭제 버튼 클릭
		$('#delRefe').on('click',()=>{
			const checkBoxes = $('input[name="refeList"]:checked');
			const empBoxes = $('input[name="employeeName"]:checked');
			const apprBoxes = $('input[name="apprList"]:checked');
	
			empBoxes.prop('checked', false);
			apprBoxes.prop('checked', false);
			
			checkBoxes.each(function(index) {
    
        		// 해당 요소 삭제 후 사원 목록 새로고침
        		$(this).closest('li').remove();
        		const dept = $('input[name="deptName"]:checked').val();
    			getEmployeeList(dept);
    		});
    		checkBoxes.prop('checked', false);
		});


        // 결재선 선택 모달창에서 이전 버튼 클릭 시
        $('.prev').on('click', () => {
            // 문서 양식 선택 모달창 활성화 & 결재선 선택 모달창 비활성화
            $('.eApprModal.docuChoiModal').css('display', 'flex');
            $('.eApprModal.apprChoiModal').hide();
        });
        
		// 결재선 선택 모달창에서 완료 버튼 클릭 시        
        $('.done').on('click', (e) => {
    	
    		if($('#firAppr input').length == 0 || $('#secAppr input').length == 0 || $('#thirAppr input').length == 0){
    			alert('결재선 등록을 완료해주세요.');
    			return;
    		}
    	
    		// 폼을 동적으로 생성
        	const $form = $('<form>', {
            	method: 'POST',
            	action: '/eApproval/writeProc'
        	});
        	
        	let docuCode = $('<input>', {
        		type: 'hidden',
        		name: 'docuCode',
        		value: docu 
        	});
        	$form.append(docuCode);

        	// 결재선 정보를 form 태그 내부에 저장 
        	$('input[name="apprList"]').each(function() {
            	$(this).attr('type', 'hidden');
            	$form.append(this);
        	});
        	
        	// 참조선 정보를 form 태그 내부에 저장 
        	$('input[name="refeList"]').each(function() {
            	$(this).attr('type', 'hidden');
            	$form.append(this);
        	});
			
        	// 폼을 body에 추가하고 제출
        	$('body').append($form);
        	$form.submit();
    	});
    });
    // 취소 버튼 클릭 시 페이지 새로고침
    $('.cancel').on('click', () => location.reload())
})

// 모달창에서 체크박스의 다중 선택을 방지하는 함수
function noMultiClick(e, modal) {
	
	let checkBoxes;

	// 모달창 종류에 따라 체크박스 선택
    if (modal === 'docuChoiModal') {
        checkBoxes = $("input[name='docuName']");
    } else if (modal === 'apprChoiModal') {
        checkBoxes = $("input[name='deptName']");
    }
    
    // 모든 체크박스를 초기화
    checkBoxes.prop('checked', false);

    // 선택한 체크박스만 활성화
    $(e).prop('checked', true);
    return $(e).val();
}

// 해당 부서의 사원 목록을 받아오는 메서드
function getEmployeeList(dept) {

    const ul = $('#employeeList');
    ul.empty();
    
	$.ajax({
    	url: '/employee/getListByDept',
    	method: 'GET', 
   		dataType: 'json', 
    	data: {
    		deptCode: dept,
    	}
    }).done(resp => {
	
    	for (let i of resp){
    				
    		// 해당 요소가 이미 존재하면 아래 코드를 실행하지 않고 다음 항목으로 건너뜀
    		if ($(`#${i.emp_no}`).length > 0) {
            	continue; 
        	}
    		let li = $('<li>');
    		let input = $('<input>',{
    			type: 'checkbox',
                name: 'employeeName',
                id: i.emp_no,
                value: i.emp_no + " " + i.name + " " + i.role_title,
    		});
    		input.hide();
    		let label = $('<label>',{
    			for: i.emp_no
    		});
    		label.text(i.name + " " + i.role_title);
    		li.append(input, label);
    		ul.append(li);
    	}
	});
}

// 모달창에서 X 버튼 클릭 시 페이지 새로고침
$('.closeModal').on('click', () => location.reload());

// 임시 저장 문서 페이지에서 목록 버튼 클릭 시 임시 저장 문서함으로 이동
$('.goSavaList').on('click', () => {
	if(confirm('저장하지 않은 수정 사항은 기록되지 않습니다.')){
		location.href = '/eApproval/privateList?type=save&cPage=1';
	}
});

// 문서 열람 페이지에서 목록 버튼 클릭 시 바로 전 페이지로 이동
$('.goBack').on('click', () => {
	window.history.back();
});

// 임시 저장 문서 페이지에서 삭제 버튼 클릭 시 임시 저장 문서함으로 이동
$('.delDocu').on('click', () => {
	if(confirm('정말로 삭제하시겠습니까 ?')){
		location.href = '/eApproval/delDocu?docuSeq=' + $('#docuSeq').val();
	}
});


// 결재 문서 작성 페이지에서 취소 버튼 클릭 시 이전 페이지로 이동
$('.cancelWrite').on('click', () => {
	if(confirm('정말로 작성을 취소하시겠습니까 ?')){
		window.history.back();
	}
});

// 업무 기안 문서 작성 페이지에서 결재 요청 버튼 클릭 시
$('.propWrite').on('click', () => {
	// 문서에 대한 필수 입력 값을 입력 완료했는 지 확인
	if($('#effDate').val() == ""){	
		alert('시행일자를 입력해주세요');
		$('#effDate').focus();
		return;
	}
	if($('#collaboDept').val() == ""){	
		alert('협조 부서를 입력해주세요');
		$('#collaboDept').focus();
		return;
	}
	if($('#writeDocuTitle').val() == ""){	
		alert('문서 제목을 입력해주세요');
		$('#writeDocuTitle').focus();
		return;
	}
	if($('#writeDocuConts').val() == ""){	
		alert('문서 내용을 입력해주세요');
		$('#writeDocuConts').focus();
		return;
	}
	sendFormData('write/Prop');
});

// 임시 저장된 업무 기안 문서 열람레이지에서 작성 페이지에서 결재 요청 버튼 클릭 시
$('.propUpdate').on('click', () => {
	// 문서에 대한 필수 입력 값을 입력 완료했는 지 확인
	if($('#effDate').val() == ""){	
		alert('시행일자를 입력해주세요');
		$('#effDate').focus();
		return;
	}
	if($('#collaboDept').val() == ""){	
		alert('협조 부서를 입력해주세요');
		$('#collaboDept').focus();
		return;
	}
	if($('#writeDocuTitle').val() == ""){	
		alert('문서 제목을 입력해주세요');
		$('#writeDocuTitle').focus();
		return;
	}
	if($('#writeDocuConts').val() == ""){	
		alert('문서 내용을 입력해주세요');
		$('#writeDocuConts').focus();
		return;
	}
	
	// 문서의 긴급 여부 체크	
	if($('#emerCheck').is(':checked')){
		$('#emerChecked').val('Y');
	}
	
	$('#docuContForm').submit();
});

// 임시 저장된 휴가신청서 문서 열람 페이지에서 결재 요청 버튼 클릭 시
$('.leaveUpdate').on('click', () => {
	
	// 문서에 대한 필수 입력 값을 입력 완료했는 지 확인
	if($('#leaveType').val() == "") {
		alert('휴가 종류를 선택해주세요');
		$('#leaveType').focus();
		return;
	}
	if($('#startLeaveDay').val() == ""){	
		alert('시작 일자를 선택해주세요');
		$('#startLeaveDay').focus();
		return;
	}
	if($('#endLeaveDay').val() == ""){	
		alert('종료 일자를 선택해주세요');
		$('#endLeaveDay').focus();
		return;
	}
	if($('#writeDocuTitle').val() == ""){	
		alert('문서 제목을 입력해주세요');
		$('#writeDocuTitle').focus();
		return;
	}
	if($('#reason').val() == ""){	
		alert('휴가 사유를 입력해주세요');
		$('#reason').focus();
		return;
	}

	if(!$('#startDay').is(':checked')){
		$('#startDayChecked').val('N');
	}
	if(!$('#startDayAM').is(':checked')){
		$('#startDayAMChecked').val('N');
	}
	if(!$('#startDayPM').is(':checked')){
		$('#startDayPMChecked').val('N');
	}
	if(!$('#endDay').is(':checked')){
		$('#endDayChecked').val('N');
	}
	if(!$('#endDayAM').is(':checked')){
		$('#endDayAMChecked').val('N');
	}
	if(!$('#endDayPM').is(':checked')){
		$('#endDayPMChecked').val('N');
	}

    // 신청 연차 일수 문자열을 숫자로 변환 후 Form 전송
    $('#applyLeaves').val(parseFloat($('#applyLeaves').val()));
    
	// 문서의 긴급 여부 체크
	if($('#emerCheck').is(':checked')){
		$('#emerChecked').val('Y');
	}
	
	$('#docuContForm').submit();
});

// 임시 저장된 지각 사유서 문서 열람 페이지에서 결재 요청 버튼 클릭 시
$('.latenessUpdate').on('click', () => {
	
	// 필수 입력값 검사 후 데이터 전송 
	if($('#lateDay').val() == ""){	
		alert('지각 일자를 입력해주세요');
		$('#lateDay').focus();
		return false;
	}
	if($('#writeDocuTitle').val() == ""){	
		alert('문서 제목을 입력해주세요');
		$('#writeDocuTitle').focus();
		return false;
	}
	if($('#reason').val() == ""){	
		alert('지각 사유를 입력해주세요');
		$('#reason').focus();
		return false; 
	}
	
	// 문서의 긴급 여부 체크
	if($('#emerCheck').is(':checked')){
		$('#emerChecked').val('Y');
	}
	
	$('#docuContForm').submit();
});

// 임시 저장된 문서 열람 페이지에서 임시 저장 버튼 클릭 시
$('.reSaveDocu').on('click', () => {
	if(confirm('현재까지 작성된 내용을 저장하시겠습니까 ?\n파일 목록은 저장되지 않습니다.')){
		// 문서의 긴급 여부 체크
		if($('#emerCheck').is(':checked')){
			$('#emerChecked').val('Y');
		}
		$('#docuContForm').attr('action', '/eApproval/reSaveDocu');
		$('#docuContForm').submit();
	}
});

// 지각 사유서 문서 작성 페이지에서 결재 요청 버튼 클릭 시
$('.latenessWrite').on('click', () => {
	// 필수 입력값 검사 후 데이터 전송 
	if($('#lateDay').val() == ""){	
		alert('지각 일자를 입력해주세요');
		$('#lateDay').focus();
		return false;
	}
	if($('#writeDocuTitle').val() == ""){	
		alert('문서 제목을 입력해주세요');
		$('#writeDocuTitle').focus();
		return false;
	}
	if($('#reason').val() == ""){	
		alert('지각 사유를 입력해주세요');
		$('#reason').focus();
		return false; 
	}
	sendFormData('write/Lateness');
});

// 휴가 신청서 문서 작성 페이지에서 결재 요청 버튼 클릭 시
$('.leaveWrite').on('click', () => {
	// 문서에 대한 필수 입력 값을 입력 완료했는 지 확인
	if($('#leaveType').val() == "") {
		alert('휴가 종류를 선택해주세요');
		$('#leaveType').focus();
		return;
	}
	if($('#startLeaveDay').val() == ""){	
		alert('시작 일자를 선택해주세요');
		$('#startLeaveDay').focus();
		return;
	}
	if($('#endLeaveDay').val() == ""){	
		alert('종료 일자를 선택해주세요');
		$('#endLeaveDay').focus();
		return;
	}
	if($('#writeDocuTitle').val() == ""){	
		alert('문서 제목을 입력해주세요');
		$('#writeDocuTitle').focus();
		return;
	}
	if($('#reason').val() == ""){	
		alert('휴가 사유를 입력해주세요');
		$('#reason').focus();
		return;
	}

	if(!$('#startDay').is(':checked')){
		$('#startDayChecked').val('N');
	}
	if(!$('#startDayAM').is(':checked')){
		$('#startDayAMChecked').val('N');
	}
	if(!$('#startDayPM').is(':checked')){
		$('#startDayPMChecked').val('N');
	}
	if(!$('#endDay').is(':checked')){
		$('#endDayChecked').val('N');
	}
	if(!$('#endDayAM').is(':checked')){
		$('#endDayAMChecked').val('N');
	}
	if(!$('#endDayPM').is(':checked')){
		$('#endDayPMChecked').val('N');
	}
	sendFormData('write/Leave');
});

// 문서 작성 페이지에서 임시 저장 버튼 클릭 시
$('.docuSaveBtn').on('click', function() {
	// 선택한 파일 내역은 저장되지 않도록 제어
	if(confirm('임시 저장 시 파일 내역은 저장되지 않습니다.')){	
		// 해당 버튼이 가진 클래스 이름을 검사해서 문서를 구분 후 해당 url을 담은 메서드 호출
		if($(this).hasClass('docuPropSave')){
			sendFormData('write/tempProp');
		} else if($(this).hasClass('docuLeaveSave')) {
			sendFormData('write/tempLeave');
		} else if($(this).hasClass('docuLatenessSave')) {
			sendFormData('write/tempLateness');
		}		
	}
});

// 참조 버튼 클릭 시 참조선 리스트 모달창 활성화
$('.refeBtn').on('click', () => {
    $('.refeModal').toggle();
});

// input 태그의 입력 문자열 길이를 제어하는 메서드
function handleOnInput(e, maxLength) {
	if ($(e).val().length > maxLength) {
    	alert($(e).data('label') + "의 글자 수는 " + maxLength + "자까지만 입력 가능 합니다.");
        $(e).val($(e).val().substr(0, maxLength - 1));
    }
}

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
	location.href="/eApproval/returnDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#returnComm').val();
}); 

// 결재 코멘트 모달창에서 결재 버튼 클릭 시
$('.docuAppr').on('click', () => {
	if($('#apprComm').val().trim() == ""){
		alert('코멘트를 입력해주세요');
		$('#apprComm').focus();
		return;
	}
	$('#apprComm').val($('#apprComm').val().trim());
	location.href="/eApproval/apprDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#returnComm').val();
}); 

// 결재 코멘트 모달창에서 전결 버튼 클릭 시
$('.docuAllAppr').on('click', () => {
	if($('#apprComm').val().trim() == ""){
		alert('코멘트를 입력해주세요');
		$('#apprComm').focus();
		return;
	}
	$('#apprComm').val($('#apprComm').val().trim());
	location.href="/eApproval/apprAllDocu?docuSeq=" + $('#docuSeq').val() + "&comments=" + $('#returnComm').val();
}); 

// AJAX로 서버에 해당 문서의 데이터를 보내고 문서 번호를 받아오는 메서드
function sendFormData(choiUrl) {
	
	// 결재 라인 & 참조 라인 정보를 form 태그 내부에 추가
	$(".apprTable input").appendTo("#docuContForm");
	$(".refeModal input").appendTo("#docuContForm");
	
	// 문서의 긴급 여부 체크
	if($('#emerCheck').is(':checked')){
		$('#emerChecked').val('Y');
	}
	
	// 휴가 신청서 문서일 경우 신청 연차 일수 문자열을 숫자로 변환
	if(choiUrl.includes('Leave')){
    	$('#applyLeaves').val(parseFloat($('#applyLeaves').val()));
	} 
	
 	// 폼 데이터를 직렬화 후 변수에 저장
	let formData = $("#docuContForm").serialize();

     // AJAX로 서버에 전송
     $.ajax({
     	type: 'POST',
        url: '/eApproval/' + choiUrl,
        data: formData
     }).done(resp => {
     	// 임시 저장 시 임시 저장함 페이지로 이동
     	if(choiUrl.includes('temp')){
     		location.href = '/eApproval/privateList?type=save&cPage=1'; 
     	}
     	// 결재 요청 시 등록된 파일이 존재할 때만 데이터 전송
     	if(addedFiles.length > 0){
     		const docuSeq = $('<input>', {
     	 		type: 'hidden',
     	 		value: resp,
     	 		name: 'docuSeq'
     	 	});
     	 	$('#fileInputForm').append(docuSeq);
     	 	$('#fileInputForm').submit();
     	} else {
     		location.href = "/eApproval/home";
     	}
     });	
}

// 휴가 신청서에서 휴가 시작일 변화를 감지
$('#startLeaveDay').on('change', function () {
    if ($(this).val() == '') {
    // 시작일 삭제 시 종료일 및 신청 연차 일수 초기화 후 체크박스 설정 초기화
        $('#applyLeaves, #endLeaveDay').val('');
        $('#startDay, #startDayAM, #startDayPM').prop('checked', false);
        $('#endDay, #endDayAM, #endDayPM').prop('disabled', false);
        return;
    }
    // 종료일의 선택가능한 범위 중 최솟값을 시작일로 변경 후 신청 연차 및 체크박스 기본값 설정
    const startLeaveDay = $(this).val();
    $('#endLeaveDay').prop('min', startLeaveDay);
    $('#endLeaveDay').val(startLeaveDay);
    $('#startDay, #startDayAM, #startDayPM').prop('checked', true);
    $('#endDay, #endDayAM, #endDayPM').prop('checked', false);
    $('#endDay, #endDayAM, #endDayPM').prop('disabled', true);
    $('#applyLeaves').val(1).trigger('change');
});

// 휴가 신청서에서 휴가 종료일 변화를 감지
$('#endLeaveDay').on('change', function () {
    if ($('#startLeaveDay').val() === '') {
    // 시작일 선택 여부 검사 후 안내문 출력
        alert('시작일을 먼저 선택해주세요');
        $(this).val('');
        return;
    }

    // 시작일과 종료일을 Date객체로 변환
    const start = new Date($('#startLeaveDay').val());
    const end = new Date($('#endLeaveDay').val());

    // 날짜 차이를 밀리초 단위로 계산
    const time = end - start;

    // 밀리초를 일수로 변환
    const day = time / (1000 * 3600 * 24) + 1;

    // 잔여 연차보다 신청 연차의 일수가 많으면 선택 초기화
    if ($('#remainingLeaves').val() < day) {
        alert('잔여 연차를 확인해주세요.');
        $('#endLeaveDay').val($('#startLeaveDay').val());
        $('#applyLeaves').val(1).trigger('change');
        return;
    }
    if (day == 1) {
        // 신청 연차가 1일인 경우 체크박스 종료일 체크박스 비활성화
        $('#endDay, #endDayAM, #endDayPM').prop('checked', false);
        $('#endDay, #endDayAM, #endDayPM').prop('disabled', true);
    } else {
        // 신청 연차가 2일 이상일 경우 종료일 체크박스 활성화
        $('#endDay, #endDayAM, #endDayPM').prop('checked', true);
        $('#endDay, #endDayAM, #endDayPM').prop('disabled', false);
    }
    // 신청 연차 일수 업데이트
    $('#applyLeaves').val(day).trigger('change');
});

// 신청 연차 일수의 변화를 감지
$('#applyLeaves').on('change', function () {
    // 신청 연차 일수 문자열을 숫자로 변환
    const applyLeaves = parseFloat($(this).val());

    // 체크박스 이벤트 핸들러 초기화
    $('#startDay, #startDayAM, #startDayPM').off('click').off('change');
    $('#endDay, #endDayAM, #endDayPM').off('click').off('change');

    if (applyLeaves == 0.5) {
    // 신청 연차가 0.5일인 경우
        if ($('#startDayAM').is(':checked')) {
        // 시작일 오전이 체크되어 있을 때 체크 해제 불가능	
            $('#startDayAM').on('click', function (e) {
                e.preventDefault();
                return;
            });
            // 시작일 혹은 시작일 오후 체크 시 체크박스 설정 및 신청 연차 일수 변경
            $('#startDay, #startDayPM').on('change', function () {
                $('#startDay, #startDayPM').prop('checked', true);
                $('#applyLeaves').val(1).trigger('change');
            });
        } else if ($('#startDayPM').is(':checked')) {
        // 시작일 오후가 체크되어 있을 때 체크 해제 불가능
            $('#startDayPM').on('click', function (e) {
                e.preventDefault();
                return;
            });
            // 시작일 혹은 시작일 오전 체크 시 체크박스 설정 및 신청 연차 일수 변경
            $('#startDay, #startDayAM').on('change', function () {
                $('#startDay, #startDayAM').prop('checked', true);
                $('#applyLeaves').val(1).trigger('change');
            });
        }
    } else if (applyLeaves == 1) {
    // 신청 연차가 1일인 경우 시작일 체크 해제 불가능
        $('#startDay').on('click', function (e) {
            e.preventDefault();
            return;
        });
        // 시작일 오전 혹은 오후 체크 해제 시 시작일 체크 해제 및 신청 연자 일수 변경
        $('#startDayAM, #startDayPM').on('change', function () {
            $('#startDay').prop('checked', false);
            $('#applyLeaves').val(0.5).trigger('change');
        });
    } else {
    // 신청 연차가 1일 이상인 경우 시작일 오후 및 종료일 오전 체크 해제 불가능
        $('#startDayPM, #endDayAM').on('click', function (e) {
            e.preventDefault();
            alert('신청 휴가가 2일 이상일 경우\n시작일 오후와 종료일 오전은 선택해제가 불가능합니다');
            return;
        });
        // 시작일 체크 해제 불가능 및 체크 시 신청 연차 일수 변경
        $('#startDay').on('click', function (e) {
            if ($('#startDay').is(':checked')) {
                $('#startDayAM').prop('checked', true);
                $('#applyLeaves').val(applyLeaves + 0.5).trigger('change');
            } else {
                e.preventDefault();
                alert('신청 휴가가 2일 이상일 경우\n시작일 오후는 선택해제가 불가능합니다');
                return;
            }
        });
        // 시작일 오전 체크 혹은 체크 해제 시 신청 연차 일수 변경
        $('#startDayAM').on('click', function () {
            if ($('#startDayAM').is(':checked')) {
                $('#startDay').prop('checked', true)
                $('#applyLeaves').val(applyLeaves + 0.5).trigger('change');
            } else {
                $('#startDay').prop('checked', false)
                $('#applyLeaves').val(applyLeaves - 0.5).trigger('change');
            }
        });
        // 종료일 체크 해제 불가능 및 체크 시 신청 연차 일수 변경
        $('#endDay').on('click', function (e) {
            if ($('#endDay').is(':checked')) {
                $('#endDayPM').prop('checked', true);
                $('#applyLeaves').val(applyLeaves + 0.5).trigger('change');
            } else {
                e.preventDefault();
                alert('신청 휴가가 2일 이상일 경우\n종료일 오전은 선택해제가 불가능합니다');
                return;
            }
        });
		// 종료일 오후 체크 혹은 체크 해제 시 신청 연차 일수 변경
        $('#endDayPM').on('click', function () {
            if ($('#endDayPM').is(':checked')) {
                $('#endDay').prop('checked', true);
                $('#applyLeaves').val(applyLeaves + 0.5).trigger('change');
            } else {
                $('#endDay').prop('checked', false);
                $('#applyLeaves').val(applyLeaves - 0.5).trigger('change');
            }
        });
    }
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

	// 현재 페이지의 URL 중 pathname 값 중 마지막 단어만 변수에 저장
	const pathName = window.location.pathname;
	const docuList = pathName.split('/').pop();
	
	if(keyword == ''){
		if (docuCode == ''){
			location.href = '/eApproval/' + docuList + '?type=' + type + '&cPage=1';
			return;
		}
		location.href = '/eApproval/' + docuList + '?type=' + type + '&docuCode=' + docuCode + '&cPage=1';
		return;
	} 
	
	// 변수에 저장된 값을 서버에 전송
	if (docuCode == ''){
		location.href = '/eApproval/search/' + docuList + '?type=' + type + '&keyword=' + keyword + '&cPage=1';
		return;
	}
	location.href = '/eApproval/search/' + docuList + '?type=' + type + '&docuCode=' + docuCode + '&keyword=' + keyword + '&cPage=1';
}