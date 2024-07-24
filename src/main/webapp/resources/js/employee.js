$(document).ready(function () {
    // 사원번호를 생성하는 함수
    function generateEmployeeID(year) {
        var randomDigits = Math.floor(10000000 + Math.random() * 90000000); // 8자리 랜덤 숫자 생성
        return year + '-' + randomDigits; // 년도와 랜덤 숫자를 합쳐서 사원번호 생성
    }

    // '사원번호 생성' 버튼 클릭 시 사원번호를 생성하여 입력 필드에 설정
    $('#generate_id_button').on('click', function () {
        var currentYear = new Date().getFullYear().toString().slice(-2); // 현재 연도의 마지막 두 자리 추출
        var employeeID = generateEmployeeID(currentYear); // 사원번호 생성
        $('#employee_id').val(employeeID); // 생성된 사원번호를 입력 필드에 설정
    });

    // '비밀번호 찾기' 버튼 클릭 시 알림 표시
    $('.find_pw').on('click', function (event) {
        event.preventDefault(); // 기본 동작(폼 제출) 방지
        alert('관리자한테 문의하세요.'); // 알림 메시지 표시
    });

    // 회원탈퇴 버튼
    $("#del_btn").on("click", function(event) {
        event.preventDefault();
        if (confirm("정말 탈퇴 하시겠습니까?")) {
            window.location.href = '/employee/delete';
        }
    });

    // 첫 로그인 시 추가 정보 입력 팝업 표시
    if (isFirstLogin) {
        $("#popup").css("display", "block");
    }
});

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 기본 주소가 도로명 주소인지, 지번 주소인지에 따라 다르게 처리
            if(data.addressType === 'R'){
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            document.getElementById('zip_code').value = data.zonecode; // 우편번호
            document.getElementById('address').value = fullAddr; // 주소
        }
    }).open();
}
