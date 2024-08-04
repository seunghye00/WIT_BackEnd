// 새 결재 진행 클릭 시 문서 양식 선택 모달창 띄우는 함수
$('#startApprBtn').on('click', () => {
	
	console.log("버튼");
	
	// 해당 모달창 활성화
    $('.eApprModal.docuChoiModal').css({ display: 'flex' })
	
	 $.ajax({
        url: '/eApproval/getDocuList',
        type: 'post',
		dataType: "json"
    }).done((resp)=>{
    	console.log(resp);
    }).fail((jqXHR, textStatus, errorThrown) => {
    	console.error('AJAX 요청 실패:', textStatus, errorThrown);
	});

    // 문서 종류를 저장할 변수
    let docu

    // check 박스로 문서 선택 후 변수에 저장
    $("input[name='docuName']").on('click', function () {
        docu = noMultiClick(this, 'docuChoiModal')
    })

    // 해당 모달창에서 다음 버튼 클릭 시
    $('.next').on('click', () => {
        // 문서 종류 선택 전 다음 버튼 클릭 시 안내문
        if (docu === undefined) {
            alert('문서 종류를 먼저 선택해주세요.')
            return
        }

        // 문서 양식 선택 모달창 비활성화 & 결재선 선택 모달창 활성화
        $('.eApprModal.docuChoiModal').css({ display: 'none' })
        $('.eApprModal.apprChoiModal').css({ display: 'flex' })

        // 부서 종류를 저장할 변수
        let dept

        // check 박스로 문서 선택 후 변수에 저장
        $("input[name='deptName']").on('click', function () {
            dept = noMultiClick(this, 'apprChoiModal')

            // 해당 부서의 사원 목록을 받아오는 ajax
            $.ajax({
                url: '/', // 요청할 URL
                method: 'GET', // HTTP 메서드
                dataType: 'json', // 예상되는 데이터 타입
                data: {
                    dept_code: dept,
                },
            }).done(resp => {
                console.log(resp)
            })
        })

        // 결재선 선택 모달창에서 이전 버튼 클릭 시
        $('.prev').on('click', () => {
            // 문서 양식 선택 모달창 활성화 & 결재선 선택 모달창 비활성화
            $('.eApprModal.docuChoiModal').css({ display: 'flex' })
            $('.eApprModal.apprChoiModal').css({ display: 'none' })
        })
    })

    // 취소 버튼 클릭 시 페이지 새로고침
    $('.cancel').on('click', () => location.reload())
})

// 문서 양식 선택 모달창에서 체크박스의 다중 선택을 방지하는 함수
function noMultiClick(e, modal) {
    if (modal === 'docuChoiModal') {
        const checkBoxes = $("input[name='docuName']")

        // 모든 체크박스를 초기화
        checkBoxes.prop('checked', false)

        // 선택한 체크박스만 활성화
        $(e).prop('checked', true)
        return $(e).val()
    } else if (modal === 'apprChoiModal') {
        const checkBoxes = $("input[name='deptName']")

        // 모든 체크박스를 초기화
        checkBoxes.prop('checked', false)

        // 선택한 체크박스만 활성화
        $(e).prop('checked', true)
        return $(e).val()
    }
}

// 모달창에서 X 버튼 클릭 시 페이지 새로고침
$('.closeModal').on('click', () => location.reload())

// 결재 or 전결 버튼 클릭 시 결재 코멘트 입력 모달창 활성화
$('.apprBtn').on('click', () => {
    $('.apprModal').css({ display: 'flex' })

    // 반려 버튼 클릭 시 반려 코멘트 모달창 활성화
    $('.noApprBtn').on('click', () => {
        $('.apprModal').css({ display: 'none' })
        $('.cancelModal').css({ display: 'flex' })
    })

    // 취소 버튼 클릭 시 해당 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.apprModal').css({ display: 'none' })
    })
})

// 반려 버튼 클릭 시 반려 코멘트 모달창 활성화
$('.noApprBtn').on('click', () => {
    $('.cancelModal').css({ display: 'flex' })

    // 취소 버튼 클릭 시 해당 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.cancelModal').css({ display: 'none' })
    })
})

// 참조 버튼 클릭 시 참조선 리스트 모달창 활성화
$('.refeBtn').on('click', () => {
    $('.refeModal').css({ display: 'flex' })

    // X 버튼 클릭 시 해당 모달창 비활성화
    $('.closeModal').on('click', () => {
        $('.refeModal').css({ display: 'none' })
    })
})
