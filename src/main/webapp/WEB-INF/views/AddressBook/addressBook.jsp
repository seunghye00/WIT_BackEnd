<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="/resources/css/style.main.css">
<link rel="stylesheet" href="/resources/css/wit.css">
<script defer src="/resources/js/mky.js"></script>
<script defer src="/resources/js/header.js"></script>
</head>
<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/Includes/sideBar.jsp" %>	
        <div class="main-content">
            <%@ include file="/WEB-INF/views/Includes/header.jsp" %>	
            <div class="contents">
                <div class="sideAbout">
                    <div class="sideTxt">
                        <h2 class="sideTit">주소록</h2>
                    </div>
                    <div class="sideBtnBox">
                        <button class="plusBtn sideBtn" onclick="openAddContactPopup()">연락처 추가</button>
                    </div>
                    <div class="addressListPrivate">
                        <ul class="privateList">
                            <li class="toggleItem">
                                <h3 class="toggleTit active">개인 주소록</h3>
                                <ul class="subList active">
                                    <li class="newList"><a href="javascript:;" onclick="showAddCategoryPopup()"><i class="bx bx-plus-medical"></i><span>연락처 주소록 추가</span></a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="addressListGroup">
                        <ul class="GroupList">
                            <li class="toggleItem">
                            	<a href="/employee/addressList"> <h3 class="addressTit">그룹 주소록</h3></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="sideContents addressCont">
                    <div class="mainTitle addressTit">전체 주소록</div>
                    <form class="searchBox" id="searchForm" action="/addressbook/search">
                        <input type="text" id="searchInput" placeholder="검색" name="keyword">
                        <button class="searchBtn" type="submit" >
                            <i class='bx bx-search'></i>
                        </button>
                    </form>
                    <div class="tableCont">
                        <div class="toolBar">
                            <ul>
                                <li><a href="javascript:;" class="active" onclick="loadPage({chosung: '', category: currentCategory, cpage: 1})">전체</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄱ', category: currentCategory, cpage: 1})">ㄱ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄴ', category: currentCategory, cpage: 1})">ㄴ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄷ', category: currentCategory, cpage: 1})">ㄷ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㄹ', category: currentCategory, cpage: 1})">ㄹ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅁ', category: currentCategory, cpage: 1})">ㅁ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅂ', category: currentCategory, cpage: 1})">ㅂ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅅ', category: currentCategory, cpage: 1})">ㅅ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅇ', category: currentCategory, cpage: 1})">ㅇ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅈ', category: currentCategory, cpage: 1})">ㅈ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅊ', category: currentCategory, cpage: 1})">ㅊ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅋ', category: currentCategory, cpage: 1})">ㅋ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅌ', category: currentCategory, cpage: 1})">ㅌ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅍ', category: currentCategory, cpage: 1})">ㅍ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'ㅎ', category: currentCategory, cpage: 1})">ㅎ</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: 'a-z', category: currentCategory, cpage: 1})">a-z</a></li>
                                <li><a href="javascript:;" onclick="loadPage({chosung: '0-9', category: currentCategory, cpage: 1})">0-9</a></li>
                            </ul>
						 	<button class="deleteBtn" onclick="deleteSelectedContacts()">
							    <i class='bx bx-trash'></i>
							</button>
                        </div>
                        <div class="listBox">
                            <div class="rows listHeader">
                                <div class="cols">
							        <input type="checkbox" id="checkAll" onclick="toggleCheckAll(this)">
							    </div>
                                <div class="cols">
                                    <span>이름</span>
                                </div>
                                <div class="cols">
                                    <span>휴대폰</span>
                                </div>
                                <div class="cols">
                                    <span>이메일</span>
                                </div>
                                <div class="cols">
                                    <span>그룹</span>
                                </div>
                            </div>
                            <div id="results">
                                <c:forEach var="item" items="${addressBookList}">
								    <div class="rows" onclick="handleRowClick(event, this)" data-seq="${item.addr_book_seq}">
								        <div class="cols">
								            <span><input type="checkbox" class="individual"></span>
								        </div>
								        <div class="cols">
								            <span>${item.name}</span>
								        </div>
								        <div class="cols">
								            <span>${item.phone}</span>
								        </div>
								        <div class="cols">
								            <span>${item.email}</span>
								        </div>
								        <div class="cols">
								            <span>${item.category_name}</span>
								        </div>
								    </div>
								</c:forEach>
                                <c:if test="${empty addressBookList}">
                                    <div class="noData">데이터 없음</div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="pagination" id="pagination"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- 연락처 추가 폼 -->
	<div id="popupModal" class="modal">
	    <div class="modal-content">
	        <div class="popTit" id="popupTitle">연락처 추가</div>
	        <form class="addressForm" id="addressForm" method="post" action="/addressbook/addContact" enctype="multipart/form-data">
	            <div class="formBox">
	                <div class="leftForm">
	                    <div class="formGroup">
	                        <label for="photo">사진</label>
	                        <div class="photoWrapper">
	                            <img src="placeholder.jpg" alt="사진" id="photo">
	                            <button type="button" onclick="removePhoto('photo', 'photoUpload')">삭제</button>
	                            <input type="file" id="photoUpload" name="photo" accept="image/*" onchange="previewPhoto(event, 'photo')"> 
	                            <label for="photoUpload">등록</label>
	                        </div>
	                    </div>
	                    <div class="formGroup">
	                        <label for="name">이름 *</label> 
	                        <input type="text" id="name" name="name" required>
	                    </div>
	                    <div class="formGroup">
	                        <label for="company">회사</label> 
	                        <input type="text" id="company" name="company">
	                    </div>
	                    <div class="formGroup">
	                        <label for="group">그룹</label> 
	                        <select id="group" name="category_id" >
                                <c:forEach var="category" items="${categoryList}">
			                        <option value="${category.CATEGORY_ID}">${category.CATEGORY_NAME}</option>
			                    </c:forEach>
	                        </select>
	                    </div>
	                </div>
	                <div class="rightForm">
	                    <div class="formGroup">
	                        <label for="position">직위</label> 
	                        <input type="text" id="position" name="position">
	                    </div>
	                    <div class="formGroup">
	                        <label for="email">이메일 *</label> 
	                        <input type="text" id="email" name="email" required>
	                    </div>
	                    <div class="formGroup">
	                        <label for="phone">휴대폰 *</label> 
	                        <input type="text" id="phone" name="phone" required>
	                    </div>
	                    <div class="formGroup">
	                        <label for="address">주소 *</label> 
	                        <input type="text" id="address" name="address" required>
	                    </div>
	                </div>
	            </div>
	            <div class="actions">
	                <button type="submit" class="save">저장</button>
	                <button type="button" class="grey" onclick="closePopup('popupModal')">목록</button>
	            </div>
	        </form>
	    </div>
	</div>
	
	<!-- 연락처 수정 폼 -->
	<div id="editContactModal" class="modal">
	    <div class="modal-content">
	        <div class="popTit">연락처 수정</div>
	        <form class="addressForm" id="editContactForm" method="post" action="/addressbook/updateContact" enctype="multipart/form-data">
	            <input type="hidden" id="editAddrBookSeq" name="addr_book_seq">
	            <div class="formBox">
	                <div class="leftForm">
	                    <div class="formGroup">
	                        <label for="editPhoto">사진</label>
	                        <div class="photoWrapper">
	                            <img src="placeholder.jpg" alt="사진" id="editPhoto">
	                            <button type="button" onclick="removePhoto('editPhoto', 'editPhotoUpload')">삭제</button>
	                            <input type="file" id="editPhotoUpload" name="photo" accept="image/*" onchange="previewPhoto(event, 'editPhoto')"> 
	                            <label for="editPhotoUpload">등록</label>
	                        </div>
	                    </div>
	                    <div class="formGroup">
	                        <label for="editName">이름 *</label> 
	                        <input type="text" id="editName" name="name" required>
	                    </div>
	                    <div class="formGroup">
	                        <label for="editCompany">회사</label> 
	                        <input type="text" id="editCompany" name="company">
	                    </div>
	                    <div class="formGroup">
	                        <label for="editGroup">그룹</label> 
	                        <select id="editGroup" name="category_id" >
	                            <c:forEach var="category" items="${categoryList}">
			                        <option value="${category.CATEGORY_ID}">${category.CATEGORY_NAME}</option>
			                    </c:forEach>
	                        </select>
	                    </div>
	                </div>
	                <div class="rightForm">
	                    <div class="formGroup">
	                        <label for="editPosition">직위</label> 
	                        <input type="text" id="editPosition" name="position">
	                    </div>
	                    <div class="formGroup">
	                        <label for="editEmail">이메일 *</label> 
	                        <input type="text" id="editEmail" name="email" required>
	                    </div>
	                    <div class="formGroup">
	                        <label for="editPhone">휴대폰 *</label> 
	                        <input type="text" id="editPhone" name="phone" required>
	                    </div>
	                    <div class="formGroup">
	                        <label for="editAddress">주소 *</label> 
	                        <input type="text" id="editAddress" name="address" required>
	                    </div>
	                </div>
	            </div>
	            <div class="actions">
	                <button type="submit" class="save">저장</button>
	                <button type="button" class="delete" onclick="deleteContact()">삭제</button>
	                <button type="button" onclick="closePopup('editContactModal')">목록</button>
	            </div>
	        </form>
	    </div>
	</div>
    
    <div id="addCategoryModal" class="modal">
        <div class="modal-category">
            <span class="close" onclick="closeAddCategoryPopup()">&times;</span>
            <div class="popTit">카테고리 추가</div>
            <form id="addCategoryForm" onsubmit="handleAddCategory(event)">
                <div class="formGroup">
                    <label for="newCategoryInput">카테고리 이름</label>
                    <input type="text" id="newCategoryInput" name="category">
                </div>
                <div class="actions">
                    <button type="submit" class="save">추가</button>
                    <button type="button" onclick="closeAddCategoryPopup()">취소</button>
                </div>
            </form>
        </div>
    </div>
    <div id="editCategoryModal" class="modal">
        <div class="modal-category">
            <span class="close" onclick="closeEditCategoryPopup()">&times;</span>
            <div class="popTit">카테고리 수정</div>
            <form id="editCategoryForm" onsubmit="handleEditCategory(event)">
                <div class="formGroup">
                    <label for="editCategoryInput">카테고리 이름</label>
                    <input type="text" id="editCategoryInput" name="category">
                    <input type="hidden" id="originalCategory" name="originalCategory">
                </div>
                <div class="actions">
                    <button type="submit" class="save">수정</button>
                    <button type="button" class="delete" onclick="handleDeleteCategory(event)">삭제</button>
                    <button type="button" onclick="closeEditCategoryPopup()">취소</button>
                </div>
            </form>
        </div>
    </div>
    <script>
    let currentChosung  = '전체';
    let currentCategory = '전체';
 	// 토글 이벤트 설정
    const toggleItems = $('.toggleItem');
    toggleItems.each(function() {
    	const toggleItem = $(this);
        const toggleTit = toggleItem.find('.toggleTit');
        const subList = toggleItem.find('.subList');

        toggleTit.on('click', function() {
        	subList.toggleClass('active');
            toggleTit.toggleClass('active'); // 이미지 회전을 위해 클래스 추가
        });
    });
    $(document).ready(function() {
        loadCategories();
        $('.toolBar a').off('click').on('click', handleToolBarClick);
        $('#searchForm').off('submit').on('submit', handleSearchFormSubmit);
        // `allCheckboxes` 변수 정의
        let allCheckboxes = document.querySelectorAll('.individual');
        let checkAllBox = document.getElementById('checkAll');
        
        // `toggleIndividualCheck` 함수에서 `allCheckboxes` 사용
        function toggleIndividualCheck() {
            const allChecked = Array.from(allCheckboxes).every(checkbox => checkbox.checked);
            checkAllBox.checked = allChecked;
        }

        // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
        allCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', toggleIndividualCheck);
        });

        // `toggleCheckAll` 함수에서 `allCheckboxes` 사용
        function toggleCheckAll(checkAllBox) {
            allCheckboxes.forEach(checkbox => {
                checkbox.checked = checkAllBox.checked;
            });
        }

        checkAllBox.addEventListener('click', function() {
            toggleCheckAll(checkAllBox);
        });

    });

    function loadPage(params = { cpage: 1 }, url = '/addressbook/addressTool') {
        $.ajax({
            url: url,
            type: 'GET',
            data: params,
            dataType: 'json',
            success: function(response) {
                var data = response.addressBookList;
                $('#results').empty();
                if (Array.isArray(data) && data.length > 0) {
                    data.forEach(function(contact) {
                        var $row = $('<div>', {
                            class: 'rows',
                            onclick: 'handleRowClick(event, this)',
                            'data-seq': contact.ADDR_BOOK_SEQ
                        });
                        var $colCheckbox = $('<div>', { class: 'cols' }).append($('<span>').append($('<input>', { type: 'checkbox', class: 'individual' })));
                        var $colName = $('<div>', { class: 'cols' }).append($('<span>').text(contact.NAME || ''));
                        var $colPhone = $('<div>', { class: 'cols' }).append($('<span>').text(contact.PHONE || ''));
                        var $colEmail = $('<div>', { class: 'cols' }).append($('<span>').text(contact.EMAIL || ''));
                        var $colCategory = $('<div>', { class: 'cols' }).append($('<span>').text(contact.CATEGORY_NAME || ''));

                        $row.append($colCheckbox, $colName, $colPhone, $colEmail, $colCategory);
                        $('#results').append($row);
                    });
                } else {
                    $('#results').append('<div class="noData">데이터 없음</div>');
                }

                let pageNation = $("#pagination");
                pageNation.empty();
				console.log(response)
                let cpage = response.cpage;
                let record_total_count = response.totPage;
                let record_count_per_page = 10;
                let navi_count_per_page = 5;
                let pageTotalCount = Math.ceil(record_total_count / record_count_per_page);

                let startNavi = Math.floor((cpage - 1) / navi_count_per_page) * navi_count_per_page + 1;
                let endNavi = startNavi + navi_count_per_page - 1;

                if (endNavi > pageTotalCount) {
                    endNavi = pageTotalCount;
                }

                let needPrev = cpage > 1;
                let needNext = cpage < pageTotalCount;

                pageNation.append("<a href='#' class='prev " + (needPrev ? "active" : "disabled") + "' data-page='" + (cpage - 1) + "'><i class='bx bx-chevron-left'></i></a>");
                
                for (let i = startNavi; i <= endNavi; i++) {
                    if (cpage == i) {
                        pageNation.append("<a class='active' href='#' data-page='" + i + "'>" + i + "</a> ");
                    } else {
                        pageNation.append("<a href='#' data-page='" + i + "'>" + i + "</a> ");
                    }
                }

                pageNation.append("<a href='#' class='next " + (needNext ? "active" : "disabled") + "' data-page='" + (cpage + 1) + "'><i class='bx bx-chevron-right'></i></a>");

                $('#pagination a').click(function(event) {
                    event.preventDefault();
                    if ($(this).hasClass('disabled')) {
                        return;
                    }
                    var page = $(this).data('page');
                    var params = {
                        cpage: page,
                        keyword: $('#searchInput').val(),
                        chosung: currentChosung,
                        category: currentCategory
                    };
                    loadPage(params, url);
                });
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                console.error('Response Text:', xhr.responseText);
                alert('Failed to fetch data.');
            }
        });
    }

    function loadCategories() {
        $.ajax({
            url: '/addressbook/getCategories',
            type: 'GET',
            dataType: 'json',
            success: function(categories) {
                let categoryList = $('.privateList .subList');
                categoryList.empty();
                categoryList.append('<li><a href="javascript:;" onclick="loadCategoryData(\'전체\')" class="active">전체</a></li>');
                categories.forEach(function(category) {
                    categoryList.append('<li><a href="javascript:;" onclick="loadCategoryData(\'' + category.CATEGORY_NAME + '\')">' + category.CATEGORY_NAME + '</a><button onclick="showEditCategoryPopup(\'' + category.CATEGORY_NAME + '\')"><i class="bx bx-edit"></i></button></li>');
                });
                categoryList.append('<li class="newList"><a href="javascript:;" onclick="showAddCategoryPopup()"><i class="bx bx-plus-medical"></i><span>연락처 주소록 추가</span></a></li>');
                loadPage();
            },
            error: function(xhr, status, error) {
                console.error('Failed to load categories:', status, error);
            }
        });
    }

    function loadCategoryData(category) {
        currentCategory = category;
        $('.mainTitle').text(category + " 주소록");
        $('.subList a').removeClass('active');
        $('.subList a').each(function() {
            if ($(this).text() === category) {
                $(this).addClass('active');
            }
        });
        loadPage({ category: category, cpage: 1, chosung: currentChosung }, '/addressbook/addressTool');
    }

    function loadChosungData(chosung) {
        currentChosung = chosung;
        loadPage({ chosung: chosung, cpage: 1, category: currentCategory }, '/addressbook/addressTool');
    }

    function showAddCategoryPopup() {
        $('#addCategoryModal').show();
    }

    function closeAddCategoryPopup() {
        $('#addCategoryModal').hide();
    }

    function showEditCategoryPopup(category) {
        $('#editCategoryInput').val(category);
        $('#originalCategory').val(category);
        $('#editCategoryModal').show();
    }

    function closeEditCategoryPopup() {
        $('#editCategoryModal').hide();
    }

    function handleEditCategory(event) {
        event.preventDefault();
        let oldCategory = $('#originalCategory').val();
        let newCategory = $('#editCategoryInput').val();
        editCategory(oldCategory, newCategory);
        closeEditCategoryPopup();
    }

    function handleAddCategory(event) {
        event.preventDefault();
        let category = $('#newCategoryInput').val();
        addCategory(category);
        closeAddCategoryPopup();
    }

    function addCategory(category) {
        $.ajax({
            url: '/addressbook/addCategory',
            type: 'POST',
            data: { category: category },
            dataType: 'json',
            success: function(response) {
                loadCategories();
            },
            error: function(xhr, status, error) {
                console.error('Failed to add category:', status, error);
            }
        });
    }

    function editCategory(oldCategory, newCategory) {
        $.ajax({
            url: '/addressbook/editCategory',
            type: 'POST',
            data: { oldCategory: oldCategory, newCategory: newCategory },
            dataType: 'json',
            success: function(response) {
                loadCategories();
            },
            error: function(xhr, status, error) {
                console.error('Failed to edit category:', status, error);
            }
        });
    }

    function deleteCategory(category) {
        $.ajax({
            url: '/addressbook/deleteCategory',
            type: 'POST',
            data: { category: category },
            dataType: 'json',
            success: function(response) {
                loadCategories();
            },
            error: function(xhr, status, error) {
                console.error('Failed to delete category:', status, error);
            }
        });
    }

    function handleDeleteCategory(event) {
        event.preventDefault();
        let category = $('#originalCategory').val();
        deleteCategory(category);
        closeEditCategoryPopup();
    }

    // 연락처 삭제
    function deleteContact() {
        const addr_book_seq = document.getElementById('editAddrBookSeq').value;
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: '/addressbook/deleteContact',
                type: 'POST',
                data: { addr_book_seq: addr_book_seq },
                success: function(response) {
                    if (response.success) {
                        alert('연락처가 삭제되었습니다.');
                        location.reload(); // 페이지를 새로고침하여 목록 갱신
                    } else {
                        alert('삭제에 실패하였습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('삭제 오류:', status, error);
                    alert('삭제 도중 오류가 발생하였습니다.');
                }
            });
        }
    }
    
    // 주소록 데이터 가져오기
    let editingRow = null;
    
	// 연락처 수정 폼을 채우는 함수
	function fillEditForm(contact) {
	    document.getElementById('editAddrBookSeq').value = contact.addr_book_seq;
	    document.getElementById('editName').value = contact.name !== null && contact.name !== undefined ? contact.name : '-';
	    document.getElementById('editPhone').value = contact.phone !== null && contact.phone !== undefined ? contact.phone : '-';
	    document.getElementById('editEmail').value = contact.email !== null && contact.email !== undefined ? contact.email : '-';
	    document.getElementById('editCompany').value = contact.company !== null && contact.company !== undefined ? contact.company : '-';
	    document.getElementById('editPosition').value = contact.position !== null && contact.position !== undefined ? contact.position : '-';
	    document.getElementById('editAddress').value = contact.address !== null && contact.address !== undefined ? contact.address : '-';
	
	    if (contact.photo && contact.photo !== 'default.jpg') {
	        const encodedPhoto = encodeURIComponent(contact.photo);
	        document.getElementById('editPhoto').src = '/uploads/' + encodedPhoto;
	    } else {
	        document.getElementById('editPhoto').src = '';
	    }
	
	    let editGroupSelect = document.getElementById('editGroup');
	    for (let i = 0; i < editGroupSelect.options.length; i++) {
	        if (editGroupSelect.options[i].text === contact.category_name) {
	            editGroupSelect.selectedIndex = i;
	            break;
	        }
	    }
	    document.getElementById('editContactModal').style.display = 'block';
	}
	// 주소록 데이터 가져오기
	function fetchContactDetails(addr_book_seq) {
	    $.ajax({
	        url: '/addressbook/getContactDetails',
	        type: 'GET',
	        data: { addr_book_seq: addr_book_seq },
	        dataType: 'json',
	        success: function(contact) {
	            console.log('Fetched contact details:', contact); // 추가된 디버깅 코드
	            fillEditForm(contact);
	        },
	        error: function(xhr, status, error) {
	            console.error('Failed to fetch contact details:', status, error);
	            console.log('Sent addr_book_seq:', addr_book_seq); // 추가된 디버깅 코드
	            alert('Failed to fetch contact details.');
	        }
	    });
	}
	// 행 클릭 시 연락처 수정 폼을 여는 함수
	function handleRowClick(event, row) {
	    if (event.target.type === 'checkbox') {
	        event.stopPropagation();
	    } else {
	        let addr_book_seq = row.getAttribute('data-seq');
	        console.log('Selected addr_book_seq:', addr_book_seq);
	        fetchContactDetails(addr_book_seq);
	    }
	}
	// 주소록 추가 팝업
	// 연락처 추가 팝업 열기 함수
	function openAddContactPopup() {
	    editingRow = null;
	    document.getElementById('addressForm').reset();
	    document.getElementById('photo').src = '';
	    document.getElementById('popupTitle').innerHTML = '연락처 추가';
	    openPopup('popupModal');
	}

	// 공통 팝업 열기 함수
	function openPopup(modalId) {
	    var modal = document.getElementById(modalId);
	    modal.style.display = 'block';
	}
	// 팝업 닫기 함수
	function closePopup(modalId) {
	    var modal = document.getElementById(modalId);
	    modal.style.display = 'none';
	}

	// 주소록 ajax 검색과 툴바 
	 function handleToolBarClick(event) {
	    event.preventDefault();
	    var chosung = $(this).text();
	    if (chosung === '전체') {
	        chosung = '';
	    }
	    currentChosung = chosung;
	    $('.toolBar a').removeClass('active');
	    $(this).addClass('active');
	    loadPage({ chosung: chosung, cpage: 1, category: currentCategory }, '/addressbook/addressTool');
	}
	
	function handleSearchFormSubmit(event) {
	    event.preventDefault();
	    var keyword = $('#searchInput').val();
	    $('.toolBar a').removeClass('active');
	    $('.toolBar a:first').addClass('active');
	    currentChosung = '전체';
	    loadPage({ keyword: keyword, cpage: 1 }, '/addressbook/search');
	}
	
	// 주소록 등록 / 수정 유효성 검사
	// 필수 입력 필드를 확인하는 함수
	function validateForm(event, formId) {
	    // 해당 폼의 필수 입력 필드들을 가져옵니다
	    let requiredFields = document.querySelectorAll(`#${formId} [required]`);
	    let allFilled = true;
	
	    requiredFields.forEach(function(field) {
	        if (!field.value.trim()) {
	            allFilled = false;
	            field.classList.add('error'); // 시각적 표시를 위한 오류 클래스 추가
	        } else {
	            field.classList.remove('error');
	        }
	    });
	
	    if (!allFilled) {
	        event.preventDefault(); // 폼 제출 방지
	        alert('모든 필수 입력 필드를 채워주세요.'); // 경고 메시지 표시
	    }
	}
	
	// 각 폼에 validateForm 함수 추가
	document.getElementById('addressForm').addEventListener('submit', function(event) {
	    validateForm(event, 'addressForm');
	});
	document.getElementById('editContactForm').addEventListener('submit', function(event) {
	    validateForm(event, 'editContactForm');
	});
	
	// 팝업 닫기 함수
	function closePopup(modalId) {
	    var modal = document.getElementById(modalId);
	    modal.style.display = 'none';
	}
	
	// 사진 삭제 예제 함수
	function removePhoto(photoId, uploadId) {
	    document.getElementById(photoId).src = ''; // 삭제 시 기본 이미지로 설정
	    document.getElementById(uploadId).value = ''; // 파일 입력 필드를 초기화
	}
	
	// 사진 미리보기 예제 함수
	function previewPhoto(event, photoId) {
	    const file = event.target.files[0];
	    const reader = new FileReader();
	    reader.onload = function(e) {
	        document.getElementById(photoId).src = e.target.result;
	    }
	    reader.readAsDataURL(file);
	}
	
	// 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
	function toggleIndividualCheck() {
	    const allCheckboxes = document.querySelectorAll('.individual');
	    const checkAllBox = document.getElementById('checkAll');
	    const allChecked = Array.from(allCheckboxes).every(checkbox => checkbox.checked);
	    checkAllBox.checked = allChecked;
	}

	// 전체 선택 체크박스 클릭 시 모든 개별 체크박스 선택/해제
	function toggleCheckAll(checkAllBox) {
	    const allCheckboxes = document.querySelectorAll('.individual');
	    allCheckboxes.forEach(checkbox => {
	        checkbox.checked = checkAllBox.checked;
	    });
	}

	// 선택된 연락처 삭제 함수
	function deleteSelectedContacts() {
	    const selectedCheckboxes = document.querySelectorAll('.individual:checked');
	    if (selectedCheckboxes.length === 0) {
	        alert('삭제할 연락처를 선택해주세요.');
	        return;
	    }

	    if (confirm("선택한 연락처를 정말 삭제하시겠습니까?")) {
	        const selectedSeqs = Array.from(selectedCheckboxes).map(checkbox => {
	            return checkbox.closest('.rows').getAttribute('data-seq');
	        });

	        $.ajax({
	            url: '/addressbook/deleteContact',
	            type: 'POST',
	            traditional: true,
	            data: { addr_book_seq: selectedSeqs },
	            success: function(response) {
	                if (response.success) {
	                    alert('선택한 연락처가 삭제되었습니다.');
	                    location.reload(); // 페이지를 새로고침하여 목록 갱신
	                } else {
	                    alert('삭제에 실패하였습니다.');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error('삭제 오류:', status, error);
	                alert('삭제 도중 오류가 발생하였습니다.');
	            }
	        });
	    }
	}
    </script>
</body>
</html>
