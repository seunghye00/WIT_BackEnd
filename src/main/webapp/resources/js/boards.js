$(document).ready(function () {
    limitReplyLength()

    // 댓글 수정 버튼 클릭 시에도 글자 수 제한 적용
    $('.updateReply').on('click', function () {
        limitReplyLength()
    })

    if ($('#summernote').length)
        $('#summernote').summernote({
            height: 400, // 기본 높이 설정
            minHeight: null, // 최소 높이 설정
            maxHeight: null, // 최대 높이 설정
            focus: true, // 페이지 로드 시 포커스
            callbacks: {
                onInit: function () {
                    // summernote 초기화 후 note-statusbar 요소 제거
                    $('.note-statusbar').remove()
                    // $(this).on('keydown', function (e) {
                    //     if ((e.ctrlKey || e.metaKey) && e.key === 'c') {
                    //         const tempDiv = document.createElement('div')
                    //         var content = $('#summernote').summernote('code')
                    //         tempDiv.innerHTML = content
                    //         // 이미지 태그가 있는지 검사
                    //         const images = tempDiv.getElementsByTagName('img')
                    //         if (images.length > 0) {
                    //             e.preventDefault() // 이미지가 포함된 붙여넣기를 막음
                    //         } else {
                    //             // 이미지가 없다면 다른 콘텐츠는 허용
                    //             $('#summernote').summernote(
                    //                 'code',
                    //                 tempDiv.innerHTML
                    //             )
                    //         }
                    //     }
                    // })
                },
                onImageUpload: function (files) {
                    let file = files[0]
                    let formData = new FormData()
                    formData.append('file', file)
                    $.ajax({
                        url: `/board/uploadImg?boardSeq=-1`, // 이미지를 저장할 서버 URL
                        type: 'POST',
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function (resp) {
                            console.log(resp)
                            // 서버에서 받은 이미지 URL을 에디터에 삽입
                            $('#summernote').summernote(
                                'insertImage',
                                `/uploads/board/images/` + resp
                            )

                            // 추가적인 정보가 필요하다면, 이를 사용하여 다른 작업 수행
                            //    const width = resp.width
                            //  const height = resp.height
                            // 예: 이미지 크기 조절, 추가 데이터 처리 등
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.error(
                                '이미지 업로드 실패:',
                                textStatus,
                                errorThrown
                            )
                        },
                    })
                },
            },
        })

    // sidebar 공통요소 script
    let btn = document.querySelector('#btn')
    let sideBar = document.querySelector('.sideBar')

    btn.addEventListener('click', function () {
        sideBar.classList.toggle('active')
    })

    $('#submitForm').on('submit', function () {
        $('#contents').val($('#summernote').summernote('code'))
    })

    // 이미 추가된 파일 이름을 저장하는 배열
    let addedFiles = []
    $('#file').on('click', function (event) {
        if (filesLength > 3) {
            event.preventDefault()
            alert('파일은 최대 3개까지만 추가 가능합니다.')
        } else {
            filesLength = defaultFileLength
            addedFiles = []
        }
    })
    // 문서 작성 페이지에서 파일 추가 시 동적으로 요소 생성
    $('#file').on('change', function () {
        // 선택된 파일들에 대한 파일 객체를 가져와서 저장

        const files = $(this).prop('files')
        const fileList = $(this)
        console.log('file')
        if (files.length + addedFiles.length > 3) {
            alert('파일은 최대 3개까지만 추가 가능합니다.')
            $(this).val('')
            return false
        }

        $('.uploadFiles').text('')
        // filesLength = defaultFileLength
        $.each(files, function (index, file) {
            // 파일 이름이 이미 배열에 있는지 확인

            if (!addedFiles.includes(file.name) && filesLength < 3) {
                // 파일 사이즈 비교 기능 추가 filesLength
                // 파일 이름이 배열에 없으면 추가
                addedFiles.push(file.name)
                filesLength++
                const span = $('<span>')
                span.text(file.name)
                /*const delBtn = $('<span>', {
                    class: 'delFileBtn',
                })
                delBtn.text('X')*/
                // span.append(delBtn)
                $('.uploadFiles').append(span)

                // 삭제 버튼 클릭 이벤트
                /* delBtn.on('click', function () {
                    const fileName = $(this).parent().text().slice(0, -1) // 'X' 제거
                    // 배열에서 파일 이름 제거
                    filesLength--
                    addedFiles = addedFiles.filter(name => name !== fileName)
                    $(this).parent().remove()
                })*/
            } else {
                alert('최대 3개만 가능합니다')
                fileList.val('')
                $('.uploadFiles').text('')
            }
        })
    })

    // 신고하기 모달 열기 및 닫기
    $('#reportBtn').on('click', function () {
        console.log('아무거나')
        $('#modal').css('display', 'block')
    })

    $('.rClose').on('click', function () {
        $('#modal').css('display', 'none')
    })
})

// 댓글 글자 수 제한 함수
function limitReplyLength() {
    const maxLength = 900

    // 댓글 작성 시
    $('.writeRly').on('input', function () {
        if ($(this).val().length > maxLength) {
            $(this).val($(this).val().slice(0, maxLength))
            alert('900자를 초과할 수 없습니다.')
        }
    })

    // 댓글 수정 시
    $('.replyPrint').on('input', function () {
        if ($(this).text().length > maxLength) {
            $(this).text($(this).text().slice(0, maxLength))
            alert('900자를 초과할 수 없습니다.')
        }
    })
}
