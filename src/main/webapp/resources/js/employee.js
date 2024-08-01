document.addEventListener("DOMContentLoaded", function() {
    // 초기 상태로 x 표시를 숨깁니다.
    const pwCheck = document.getElementById("pwCheck");
    const checkpwCheck = document.getElementById("checkpwCheck");

    pwCheck.classList.remove("show", "success", "error");
    pwCheck.innerHTML = ''; // 내용을 초기화합니다.
    
    checkpwCheck.classList.remove("show", "success", "error");
    checkpwCheck.innerHTML = ''; // 내용을 초기화합니다.
});

$(document).ready(function () {
    // 로그인 버튼 클릭 이벤트
    $('#login_button').on('click', function () {
        var formData = $('#loginForm').serialize();
        $.ajax({
            type: 'POST',
            url: '/employee/login',
            data: formData,
            success: function (response) {
                if (response.success) {
                    window.location.href = '/';
                } else {
                    alert('ID 및 PW를 확인 해주세요.');
                }
            },
            error: function () {
                alert('로그인 중 오류가 발생했습니다.');
            }
        });
    });

    // 관리자 페이지 신규 사원 등록 (사원번호 생성)
    var departmentCodes = {
        'D1': '01',
        'D2': '02',
        'D3': '03',
        'D4': '04',
        'D5': '05'
    };

    function generateEmployeeID(year, deptCode, entryOrder) {
     // 년도, 부서 코드, 입사 순서 (두 자리) 합쳐서 사원번호 생성
        return year + '-' + deptCode + entryOrder.toString().padStart(2, '0');
    }

    $('#generate_id_button').on('click', function () {
     	// 현재 연도의 4자리 추출
        var currentYear = new Date().getFullYear().toString();
        // 선택된 부서 코드
        var deptSelectVal = $('#dept_select').val(); 
        // 부서 코드 매핑
        var deptCode = departmentCodes[deptSelectVal]; 

        if (deptCode && deptCode !== "") {
            $.ajax({
                url: '/employee/highestEmployeeID',
                method: 'post',
                data: { dept: deptSelectVal },
                success: function (highestID) {
                	// 기본 순서는 1
                    var entryOrder = 1; 

                    if (highestID) {
                        var parts = highestID.split('-');
                        if (parts.length === 2) {
                        // 부서 코드 이후의 입사 순서만 추출
                            var lastEntryOrder = parseInt(parts[1].substring(2)); 
                            entryOrder = lastEntryOrder + 1;
                        }
                    }
					
					// 사원번호 생성
                    var employeeID = generateEmployeeID(currentYear, deptCode, entryOrder);
                    // 생성된 사원번호를 입력 필드에 설정
                    $('#employee_id').val(employeeID); 
                },
                error: function (error) {
                    console.error("Error fetching highest employee ID:", error);
                    alert("사원번호를 생성하는 데 문제가 발생했습니다. 관리자에게 문의하세요.");
                }
            });
        } else {
        	// 부서가 선택되지 않은 경우 경고 메시지 표시
            alert("부서를 선택하세요."); 
        }
    });

    // 회원탈퇴 버튼
    $("#del_btn").on("click", function(event) {
        event.preventDefault();
        if (confirm("정말 탈퇴 하시겠습니까?")) {
            window.location.href = '/employee/delete';
        }
    });

    // 사용자 첫 로그인시 팝업 업데이트 정규표현식
	$("#pw").on("keyup", function () {
        let password = $(this).val().trim();
        let regex = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{10,}$/;
        let resultLabel = $("#resultpw");
        let pwCheck = $("#pwCheck");

        if (password === "") {
            resultLabel.text("");
            pwCheck.removeClass("show success error").html('');
        } else if (regex.test(password)) {
            resultLabel.text("사용 가능").css("color", "green");
            pwCheck.removeClass("error").addClass("show success").css("color", "green").html('&#x2714;');
        } else {
            resultLabel.text("사용 불가능").css("color", "red");
            pwCheck.removeClass("success").addClass("show error").css("color", "red").html('&#x2716;');
        }
	});

	// 비밀번호 재확인
	$("#checkpw").on("keyup", function () {
        let password = $("#pw").val();
        let confirmPassword = $(this).val();
        let resultLabel = $("#resultcheckpw");
        let checkpwCheck = $("#checkpwCheck");

        if (confirmPassword === "") {
            resultLabel.text("");
            checkpwCheck.removeClass("show success error").html('');
        } else if (password === confirmPassword) {
            resultLabel.text("비밀번호가 일치합니다").css("color", "green");
            checkpwCheck.removeClass("error").addClass("show success").css("color", "green").html('&#x2714;');
        } else {
            resultLabel.text("비밀번호가 일치하지 않습니다").css("color", "red");
            checkpwCheck.removeClass("success").addClass("show error").css("color", "red").html('&#x2716;');
        }
	});

    $("#ssn").on("keyup", function () {
        let ssn = $(this).val();
        let regex = /^(?:[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01]))-[1-4][0-9]{6}$/;
        let resultLabel = $("#resultSSN");
        let ssnCheck = $("#ssnCheck");

        if (ssn === "") {
            resultLabel.text("");
            ssnCheck.removeClass("show success error").html('');
        } else if (regex.test(ssn)) {
            resultLabel.text("사용 가능").css("color", "green");
            ssnCheck.removeClass("error").addClass("show success").html('&#x2714;');
        } else {
            resultLabel.text("사용 불가능").css("color", "red");
            ssnCheck.removeClass("success").addClass("show error").html('&#x2716;');
        }
    });

    $("#phone").on("keyup", function () {
        let phone = $(this).val();
        let regex = /^010-\d{3,4}-\d{4}$/;
        let resultLabel = $("#resultPhone");
        let phoneCheck = $("#phoneCheck");

        if (phone === "") {
            resultLabel.text("");
            phoneCheck.removeClass("show success error").html('');
        } else if (regex.test(phone)) {
            resultLabel.text("사용 가능").css("color", "green");
            phoneCheck.removeClass("error").addClass("show success").html('&#x2714;');
        } else {
            resultLabel.text("사용 불가능").css("color", "red");
            phoneCheck.removeClass("success").addClass("show error").html('&#x2716;');
        }
    });

    $("#email").on("keyup", function () {
        let email = $(this).val();
        let regex = /^[^\s@]+@[^\s@]+\.(com|net)$/;
        let resultLabel = $("#resultEmail");
        let emailCheck = $("#emailCheck");

        if (email === "") {
            resultLabel.text("");
            emailCheck.removeClass("show success error").html('');
        } else if (regex.test(email)) {
            resultLabel.text("사용 가능").css("color", "green");
            emailCheck.removeClass("error").addClass("show success").html('&#x2714;');
        } else {
            resultLabel.text("사용 불가능").css("color", "red");
            emailCheck.removeClass("success").addClass("show error").html('&#x2716;');
        }
    });

	// 우편번호
    $("#postcode").on("click", function () {
        new daum.Postcode({
            oncomplete: function (data) {
                $("#zip_code").val(data.zonecode);
                $("#address").val(data.jibunAddress);
            }
        }).open();
    });

    $("#insertForm").on("submit", function () {
        if ($("#nickname").val() == "" || !/^[a-zA-Z0-9ㄱ-ㅎ가-힣]{2,7}$/.test($("#nickname").val())) {
            alert("닉네임을 올바르게 입력하세요.");
            return false;
        }
        if ($("#pw").val() == "" || !/^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{10,}$/.test($("#pw").val())) {
            alert("비밀번호를 올바르게 입력하세요.");
            return false;
        }
        if ($("#pw").val() !== $("#checkpw").val()) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        if ($("#ssn").val() == "" || !/^(?:[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01]))-[1-4][0-9]{6}$/.test($("#ssn").val())) {
            alert("주민등록번호를 올바르게 입력하세요.");
            return false;
        }
        if ($("#phone").val() == "" || !/^010-\d{3,4}-\d{4}$/.test($("#phone").val())) {
            alert("전화번호 형식이 잘못되었습니다.");
            return false;
        }
        if ($("#email").val() == "" || !/^[^\s@]+@[^\s@]+\.(com|net)$/.test($("#email").val())) {
            alert("이메일 형식이 잘못되었습니다.");
            return false;
        }
    });

    // ID(사번)찾기
    $('#findId').on('submit', function(e) {
        e.preventDefault();
        var formData = $(this).serialize();

        $.ajax({
            url : '/employee/findID',
            type : 'POST',
            data : formData,
            dataType : 'json',
            success : function(response) {
                if (response.success) {
                    alert("회원님의 사번 은 " + response.empNo + " 입니다!");
                    window.location.href = "/";
                } else {
                    alert("이름과 주민등록번호에 해당하는 사번이 없습니다.");
                }
            },
            error : function(xhr, status, error) {
                console.error('Error:', error);
                alert("AJAX 에러!.");
            }
        });
    });

	// 출근버튼
	$("#start_button").click(function() {
        var now = new Date();
        var hours = now.getHours();
        if (hours >= 18) {
            alert("18시 이후에는 출근할 수 없습니다.");
            return;
        }
        if (confirm("출근 하시겠습니까?")) {
            $.ajax({
                url: "/attendance/start",
                type: "POST",
                success: function(response) {
                    alert(response);
                },
                error: function(xhr, status, error) {
                    alert("출근 처리에 실패했습니다.");
                }
            });
        }
    });

	// 퇴근버튼
    $("#end_button").click(function() {
        if (confirm("퇴근 하시겠습니까?")) {
            $.ajax({
                url: "/attendance/end",
                type: "POST",
                success: function(response) {
                    alert(response);
                },
                error: function(xhr, status, error) {
                    alert("퇴근 처리에 실패했습니다.");
                }
            });
        }
    });

    // 닉네임 필드 변경 시 닉네임 중복 체크 필요
    $('#nickname').on('input', function() {
        nicknameChecked = false; // 닉네임이 변경될 때마다 중복 체크 상태를 초기화
    });

    // 닉네임 중복 체크 버튼 클릭 이벤트
    $("#checkNickname").click(function() {
        var nickname = $("#nickname").val().trim();
        let regex = /^[a-zA-Z0-9ㄱ-ㅎ가-힣]{2,7}$/; // 정규표현식 추가

        if (nickname === "") {
            alert("닉네임을 입력해주세요.");
            return;
        }

        if (!regex.test(nickname)) {
            alert("닉네임은 2자 이상 7자 이하의 한글, 영어, 숫자만 가능합니다.");
            return;
        }

        $.ajax({
            url: "/employee/check_nickname",
            type: "POST",
            data: {nickname: nickname},
            success: function(response) {
                if (response.value) {
                    alert("사용 가능합니다.");
                    nicknameChecked = true; // 중복 체크 완료 상태로 설정
                } else {
                    alert("사용이 불가합니다.");
                    $("#nickname").val("");
                }
            },
            error: function(xhr, status, error) {
                alert("중복 체크에 실패했습니다.");
            }
        });
    });

    // 마이페이지 수정
    $("#updateForm").on("submit", function(e) {
        e.preventDefault();

        const nickname = $("#nickname").val().trim();
        const password = $("#pw").val().trim();
        const confirmPassword = $("#checkpw").val().trim();
        const passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{10,}$/;
        const nicknameRegex = /^[a-zA-Z0-9ㄱ-ㅎ가-힣]{2,7}$/;

        // 닉네임 유효성 검사
        if (nickname === "" || !nicknameRegex.test(nickname)) {
            alert("닉네임은 2자 이상 7자 이하의 한글, 영어, 숫자만 가능합니다.");
            return;
        }

        // 닉네임 중복 체크 여부 검사
        if (nickname !== originalNickname && !nicknameChecked) {
            alert("닉네임 중복 체크를 해주세요.");
            return;
        }

        // 비밀번호 유효성 검사
        if (password !== "" && !passwordRegex.test(password)) {
            alert("비밀번호는 영문 소문자, 숫자, 특수문자가 포함된 10자 이상이어야 합니다.");
            return;
        }

        // 비밀번호 확인 검사
        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }

        const formData = $(this).serialize();

        $.ajax({
            type: 'POST',
            url: '/employee/update_mypage',
            data: formData,
            success: function(response) {
                alert('정보가 성공적으로 업데이트되었습니다.');
                location.reload();
            },
            error: function() {
                alert('업데이트 중 오류가 발생했습니다.');
            }
        });
    });
});