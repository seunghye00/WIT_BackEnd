<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script defer src="/resources/js/mky.js"></script>
</head>
<body>
<div class="container">
        <%@ include file="/WEB-INF/views/Includes/sideBarAdmin.jsp" %>
        <div class="main-content">
            <%@ include file="/WEB-INF/views/Includes/header.jsp" %>
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <h2 class="sideTit">사원관리</h2>
                    </div>
                    <div class="addressListPrivate">
                        <ul class="privateList">
                            <li class="toggleItem">
                            	<a href="javascript:;"> <h3 class="addressTit">사원 정보 관리</h3></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="sideContents addressCont">
						<div class="mainTitle addressTit">사원 정보 상세</div>
					    <form class="manageDetailForm" id="employeeDetailForm" method="post" action="/employee/updateManage">
	                       <input type="hidden" id="empNo" name="empNo" value="${employee.EMP_NO}">
	                       <div class="formCon">
                               <div class="formGroup">
                                   <label for="photo">사진</label>
                                   <div class="photoWrapper">
                                       <div class="imgBox">
	                                       <img src="${employee.PHOTO}" alt="사진" id="photo">
                                       </div>
                                       <button type="button" disabled class="red" id="removePhotoBtn">삭제</button>
                                       <input type="file" id="photoUpload" accept="image/*"
                                           onchange="previewPhoto(event)" disabled>
                                       <label for="photoUpload">등록</label>
                                       <input type="hidden" id="photoUrl" name="photoUrl">
                                   </div>
                               </div>
							<div class="formCont">
								<div class="leftForm">
									<div class="formGroup">
										<label for="name">이름</label> <input type="text" id="name"
											name="name" value="${employee.NAME}" readonly disabled="true">
									</div>
									<div class="formGroup">
										<label for="deptTitle">부서</label> <select id="deptTitle"
											name="deptTitle" disabled="true">
											<c:forEach var="dept" items="${departments}">
												<option value="${dept.dept_title}"
													${dept.dept_title == employee.DEPT_TITLE ? 'selected' : ''}>
													${dept.dept_title}</option>
											</c:forEach>
										</select>
									</div>
									<div class="formGroup">
										<label for="roleTitle">직위</label> <select id="roleTitle"
											name="roleTitle" disabled="true">
											<c:forEach var="role" items="${roles}">
												<option value="${role.role_title}"
													${role.role_title == employee.ROLE_TITLE ? 'selected' : ''}>
													${role.role_title}</option>
											</c:forEach>
										</select>
									</div>
									<div class="formGroup">
										<label for="phone">휴대폰</label> <input type="text" id="phone"
											name="phone" value="${employee.PHONE}" readonly>
									</div>
								</div>
								<div class="rightForm">
									<div class="formGroup">
										<label for="birthDate">생년월일</label> <input type="text"
											id="birthDate" name="birthDate" value="${employee.BIRTHDATE}"
											readonly disabled="true">
									</div>
									<div class="formGroup">
										<label for="joinDate">입사일</label> <input type="date"
											id="joinDate" name="joinDate" value="${employee.JOIN_DATE}"
											readonly disabled="true">
									</div>
									<div class="formGroup">
										<label for="quitDate">퇴사일</label> <input type="date"
											id="quitDate" name="quitDate" value="${employee.QUIT_DATE}"
											readonly disabled="true">
											<input type="hidden" id="hiddenQuitDate" name="quitDate" value="${employee.QUIT_DATE}">
									</div>
									<div class="formGroup">
										<label for="email">이메일</label> <input type="email" id="email"
											name="email" value="${employee.EMAIL}" readonly>
									</div>
								</div>
							</div>
						</div>
	                       <div class="actions">
	                           <button type="button" id="editBtn" class="edit">수정</button>
	                           <button type="submit" id="saveBtn" class="save" style="display:none;" onclick="saveEmployee()">저장</button>
	                           <button type="button" class="grey" onclick="window.location.href='/employee/management'">목록</button>
	                           <button type="button" class="red" id="quitOutBtn" style="display:none;" class="quitOutBtn">퇴사</button>
	                       </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
	//수정 버튼 클릭 시
	$('#editBtn').click(function() {
	    // 모든 입력 필드를 활성화
	    $('input').prop('readonly', false);
	    $('#photoUpload').prop('disabled', false);
	    $('select').prop('disabled', false); 
	    // 저장 버튼 표시, 수정 버튼 숨기기
	    $('#saveBtn').show();
	    $('#removePhotoBtn').prop('disabled', false); 
	    
	    // 퇴사일이 있는지 확인
	    if ($('#quitDate').val()) {
	        $('#quitOutBtn').prop('disabled', true); // 퇴사일이 있으면 퇴사 버튼 비활성화
	    } else {
	        $('#quitOutBtn').show(); // 퇴사일이 없으면 퇴사 버튼 활성화
	    }
	    
	    $(this).hide();
	});

	function previewPhoto(event) {
	    var reader = new FileReader();
	    reader.onload = function(){
	        var output = document.getElementById('photo');
	        output.src = reader.result;
	    };
	    reader.readAsDataURL(event.target.files[0]);
	}
	
	$('#removePhotoBtn').click(function() {
        $('#photo').attr('src', '/uploads/default.png');
        $('#photoUrl').val(''); // 이미지 삭제 시 photoUrl 필드를 비움
        $('#photoDeleted').val('true'); // 사진이 삭제되었음을 표시
    });
	 
 	function saveEmployee() {
 		var fileInput = document.getElementById('photoUpload');
        var photoChanged = fileInput.files.length > 0; // 사용자가 이미지를 변경했는지 여부를 확인
        var photoDeleted = $('#photoDeleted').val() === 'true';

 	    if (photoChanged) {
 	        // 사용자가 이미지를 변경한 경우
 	        var file = fileInput.files[0];
 	        formData.append("file", file);

 	        // 이미지 업로드를 먼저 처리
 	        $.ajax({
 	            url: '/uploadImage',
 	            type: 'POST',
 	            data: formData,
 	            processData: false,
 	            contentType: false,
 	            success: function(response) {
 	                if (response.success) {
 	                    // 서버에 저장된 이미지 URL을 폼에 추가하여 저장할 수 있도록 설정
 	                    $('#photoUrl').val(response.url);
 	                   	document.getElementById('employeeDetailForm').submit(); 
 	                } else {
 	                    alert("이미지 업로드 실패: " + response.message);
 	                }
 	            },
 	            error: function(xhr, status, error) {
 	                console.error('Error:', status, error);
 	            }
 	        });
 	    } else if (photoDeleted) {
            // 이미지가 삭제된 경우
            $('#photoUrl').val('/uploads/default.png'); // 기본 이미지로 설정
            document.getElementById('employeeDetailForm').submit();
        } else {
            // 사용자가 이미지를 변경하지 않은 경우
            var existingPhotoUrl = $('#photo').attr('src')
            $('#photoUrl').val(existingPhotoUrl);
            document.getElementById('employeeDetailForm').submit();
        }
 	}
	
	$('#quitOutBtn').click(function() {
	    // 현재 날짜를 yyyy-mm-dd 형식으로 포맷
	    if (confirm("정말 퇴사 처리하시겠습니까?")) {
	    	 var today = new Date().toISOString().split('T')[0];
	         
	         // 실제 보여지는 필드에 값 설정 (disabled 상태로 유지)
	         $('#quitDate').prop('disabled', false).val(today).prop('disabled', true);

	         // 숨겨진 필드에 값을 설정
	         $('#hiddenQuitDate').val(today);
	    }
	});
</script>
</html>
