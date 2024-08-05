// 새 결재 진행 클릭 시 문서 양식 선택 모달창 띄우는 함수
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
        	var $form = $('<form>', {
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
                value: i.name + " " + i.role_title,
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

// 결재 or 전결 버튼 클릭 시 결재 코멘트 입력 모달창 활성화
$('.apprBtn').on('click', () => {
    $('.apprModal').css('display', 'flex');

    // 반려 버튼 클릭 시 반려 코멘트 모달창 활성화
    $('.noApprBtn').on('click', () => {
        $('.apprModal').hide();
        $('.cancelModal').css('display', 'flex');
    });

    // 취소 버튼 클릭 시 해당 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.apprModal').hide();
    });
});

// 반려 버튼 클릭 시 반려 코멘트 모달창 활성화
$('.noApprBtn').on('click', () => {
    $('.cancelModal').css('display', 'flex');

    // 취소 버튼 클릭 시 해당 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.cancelModal').hide();
    });
});

// 결재 문서 작성 페이지에서 취소 버튼 클릭 시 이전 페이지로 이동
$('.cancelWrite').on('click', () => {
	if(confirm('정말로 작성을 취소하시겠습니까 ?')){
		window.history.back();
	}
});

// 결재 문서 작성 페이지에서 임시 저장 버튼 클릭 시 임시 저장 후 보관함으로 이동
$('.saveWrite').on('click', () => {
	
	$('#emerCheck:checked').val('Y');
	console.log($('#impleDate').val());
	if(confirm('임시 저장 시 파일 내역은 저장되지 않습니다.')){
			
	}
});

// 참조 버튼 클릭 시 참조선 리스트 모달창 활성화
$('.refeBtn').on('click', () => {
    $('.refeModal').toggle();
});
	
// 이미 추가된 파일 이름을 저장하는 배열
let addedFiles = [];

// 문서 작성 페이지에서 파일 추가 시 동적으로 요소 생성
$('#file').on('change', function() {

	// 선택된 파일들에 대한 파일 객체를 가져와서 저장
    const files = $(this).prop('files');
                
   	if(files.length + addedFiles.length > 3){
   		alert('파일은 최대 3개까지만 추가 가능합니다.');
		return;
   	}
                
    $.each(files, function(index, file) {
        
        // 파일 이름이 이미 배열에 있는지 확인
        if (!addedFiles.includes(file.name)) {
        	// 파일 이름이 배열에 없으면 추가
            addedFiles.push(file.name);

            const span = $('<span>');
            span.text(file.name);
            const delBtn = $('<span>', {
            	class: 'delFileBtn'
            });
            delBtn.text('X');
            span.append(delBtn);
            $('.uploadFiles').append(span);

            // 삭제 버튼 클릭 이벤트
            delBtn.on('click', function() {
            	const fileName = $(this).parent().text().slice(0, -1); // 'X' 제거
                // 배열에서 파일 이름 제거
                addedFiles = addedFiles.filter(name => name !== fileName);
                $(this).parent().remove();
            });
         }
    });
});