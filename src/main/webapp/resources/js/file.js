let addedFiles = [];

// 파일 선택 시 동적으로 요소 생성 및 파일 관리
$('#file').on('change', function() {
    const files = $(this).prop('files');

    if (files.length + addedFiles.length > 3) {
        alert('파일은 최대 3개까지만 추가 가능합니다.');
        return;
    }

    $.each(files, function(index, file) {
        if (!addedFiles.some(f => f.name === file.name)) {
            addedFiles.push(file);

            const span = $('<span>').text(file.name);
            const delBtn = $('<span>', { class: 'delFileBtn' }).text('X');
            span.append(delBtn);
            $('.uploadFiles').append(span);

            // 삭제 버튼 클릭 이벤트
            delBtn.on('click', function() {
                const fileName = $(this).parent().text().slice(0, -1); // 'X' 제거
                addedFiles = addedFiles.filter(f => f.name !== fileName);
                $(this).parent().remove();
            });
        }
    });
});

// 폼 제출 시 파일 전송
$('#fileInputForm').on('submit', function(event) {
    event.preventDefault(); // 기본 제출 동작 방지

    // FormData 객체 생성
    const formData = new FormData();

    // addedFiles 배열의 파일들을 FormData에 추가
    addedFiles.forEach(file => formData.append('file', file));

    // AJAX 요청으로 파일 전송
    $.ajax({
        url: $(this).attr('action'),
        method: 'POST',
        data: formData,  // FormData 객체
    	processData: false,  // 데이터를 자동으로 처리하지 않음
    	contentType: false,  // Content-Type을 자동으로 설정
        success: function(response) {
            console.log('파일 업로드 성공:', response);
        },
        error: function(xhr, status, error) {
            console.error('파일 업로드 실패:', status, error);
        }
    });
});
