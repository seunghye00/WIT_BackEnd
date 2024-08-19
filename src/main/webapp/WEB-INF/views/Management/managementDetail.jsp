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
        <%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>
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
					    <form class="manageDetailForm" id="employeeDetailForm" method="post" action="/employee/update">
	                       <div class="formCon">
                               <div class="formGroup">
                                   <label for="photo">사진</label>
                                   <div class="photoWrapper">
                                       <div class="imgBox">
	                                       <img src="/uploads/${employee.PHOTO}" alt="사진" id="photo">
                                       </div>
                                       <button type="button" onclick="removePhoto()">삭제</button>
                                       <input type="file" id="photoUpload" accept="image/*"
                                           onchange="previewPhoto(event)" disabled>
                                       <label for="photoUpload">등록</label>
                                   </div>
                               </div>
							<div class="formCont">
								<div class="leftForm">
									<div class="formGroup">
										<label for="name">이름</label> <input type="text" id="name"
											name="name" value="${employee.NAME}" readonly>
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
											readonly>
									</div>
									<div class="formGroup">
										<label for="joinDate">입사일</label> <input type="date"
											id="joinDate" name="joinDate" value="${employee.JOIN_DATE}"
											readonly>
									</div>
									<div class="formGroup">
										<label for="quitDate">퇴사일</label> <input type="date"
											id="quitDate" name="quitDate" value="${employee.QUIT_DATE}"
											readonly>
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
	                           <button type="button" onclick="window.location.href='/employee/management'">목록</button>
	                           <button type="button" id="quitOutBtn" style="display:none;" class="quitOutBtn">퇴사</button>
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
	    $('#quitOutBtn').show();
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
	
 	function removePhoto() {
        document.getElementById('photo').src = '/uploads/default.png';
        document.getElementById('photoUpload').value = "";
    }
	 
	function saveEmployee() {
	    var formData = new FormData(document.getElementById('employeeDetailForm'));
	    var fileInput = document.getElementById('photoUpload');
	    
	    // 파일 업로드
	    if (fileInput.files.length > 0) {
	        var file = fileInput.files[0];
	        formData.append("file", file);
	    }
	
	    $.ajax({
	        url: '/uploadImage',
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            if (response.success) {
	                // 서버에 저장된 이미지 URL을 폼에 추가하여 저장할 수 있도록 설정
	                formData.append("photoUrl", response.url);
	                // 실제 서버에 저장 요청
	                $.ajax({
	                    url: '/employee/updateManage',  // 서버의 실제 업데이트 처리 URL
	                    type: 'POST',
	                    data: formData,
	                    processData: false,
	                    contentType: false,
	                    success: function(response) {
	                        alert("저장이 완료되었습니다.");
	                    },
	                    error: function(xhr, status, error) {
	                        console.error('Error:', status, error);
	                    }
	                });
	            } else {
	                alert("이미지 업로드 실패: " + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', status, error);
	        }
	    });
	}
	
	$('#quitOutBtn').click(function() {
	    // 현재 날짜를 yyyy-mm-dd 형식으로 포맷
	    var today = new Date().toISOString().split('T')[0];
	    $('#quitDate').val(today);

	    // 퇴사일을 현재 날짜로 설정한 후 서버에 업데이트 요청
	    var formData = new FormData();
	    formData.append('empNo', '${employee.EMP_NO}');
	    formData.append('quitDate', today);

	    $.ajax({
	        url: '/employee/terminate',  // 퇴사 처리하는 서버의 URL
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            alert("퇴사 처리가 완료되었습니다.");
	            $('#saveBtn').show();  // 저장 버튼 표시
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', status, error);
	        }
	    });
	});
</script>
</html>
