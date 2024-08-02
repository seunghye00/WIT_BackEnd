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
<link rel="stylesheet" href="/resources/css/mky.css">
<script defer src="/resources/js/mky.js"></script>
<style>
#results {
    display: flex;
    flex-direction: column;
    flex: 1;
}
.noData {
    text-align: center;
    font-size: 1.2em;
    color: gray;
    margin-top: 20px;
}
</style>
</head>
<body>
    <div class="container">
        <div class="sideBar">
            <div class="top">
                <i class="bx bx-menu" id="btn"></i>
            </div>
            <div class="user">
                <img src="../images/logo/WIT_logo1.png" alt="logo" class="userImg">
                <div class="nickName">
                    <p class="bold">Wit Works</p>
                    <p></p>
                </div>
            </div>
            <ul>
                <li><a href="#"> <i class='bx bxs-home-alt-2'></i> <span class="navItem">홈</span></a> <span class="toolTip">홈</span></li>
                <li><a href="#"> <i class='bx bx-paperclip'></i> <span class="navItem">주소록</span></a> <span class="toolTip">주소록</span></li>
                <li><a href="board2.html"> <i class="bx bxs-grid-alt"></i> <span class="navItem">게시판</span></a> <span class="toolTip">게시판</span></li>
                <li><a href="#"> <i class='bx bx-calendar-alt'></i> <span class="navItem">캘린더</span></a> <span class="toolTip">캘린더</span></li>
                <li><a href="#"> <i class='bx bxs-message-dots'></i> <span class="navItem">메신저</span></a> <span class="toolTip">메신저</span></li>
                <li><a href="#"> <i class='bx bx-clipboard'></i> <span class="navItem">전자결재</span></a> <span class="toolTip">전자결재</span></li>
                <li><a href="#"> <i class='bx bxs-briefcase-alt-2'></i> <span class="navItem">근태관리</span></a> <span class="toolTip">근태관리</span></li>
                <li><a href="#"> <i class='bx bxs-check-square'></i> <span class="navItem">예약</span></a> <span class="toolTip">예약</span></li>
                <li><a href="#"> <i class='bx bx-sitemap'></i> <span class="navItem">조직도</span></a> <span class="toolTip">조직도</span></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="header">
                <span class="alert"><a href=""><i class='bx bxs-bell'></i></a></span>
                <span class="myName"> <img src="../images/프로필.jpg"><a href="#">문경원 부장</a></span> <span class="logOut"><a href="#">LogOut</a></span>
            </div>
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
                                <h3 class="toggleTit active">그룹 주소록</h3>
                                <ul class="subList active">
                                    <li><a href="javascript:;" onclick="loadCategoryData('전체')">전체</a></li>
                                    <li><a href="javascript:;" onclick="loadCategoryData('인사부')">인사부</a></li>
                                    <li><a href="javascript:;" onclick="loadCategoryData('영업부')">영업부</a></li>
                                    <li><a href="javascript:;" onclick="loadCategoryData('IT부')">IT부</a></li>
                                    <li><a href="javascript:;" onclick="loadCategoryData('마케팅부')">마케팅부</a></li>
                                    <li><a href="javascript:;" onclick="loadCategoryData('기술지원부')">기술지원부</a></li>
                                </ul>
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
                            <button class="deleteBtn">
                                <i class='bx bx-trash'></i>
                            </button>
                        </div>
                        <div class="listBox">
                            <div class="rows listHeader">
                                <div class="cols">
                                    <input type="checkbox" id="checkAll">
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
                                    <div class="rows" onclick="handleRowClick(event, this)">
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
							                <span>${item.category_name}</span> <!-- 수정된 부분 -->
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
                                <button type="button" onclick="removePhoto()">삭제</button>
                                <input type="file" id="photoUpload" name="photo" accept="image/*" onchange="previewPhoto(event)"> 
                                <label for="photoUpload">등록</label>
                            </div>
                        </div>
                        <div class="formGroup">
                            <label for="name">이름</label> 
                            <input type="text" id="name" name="name">
                        </div>
                        <div class="formGroup">
                            <label for="company">회사</label> 
                            <input type="text" id="company" name="company">
                        </div>
                        <div class="formGroup">
                            <label for="group">그룹</label> 
                            <select id="group" name="categoryId">
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.id}">${category.name}</option>
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
                            <label for="email">이메일</label> 
                            <input type="text" id="email" name="email">
                        </div>
                        <div class="formGroup">
                            <label for="phone">휴대폰</label> 
                            <input type="text" id="phone" name="phone">
                        </div>
                        <div class="formGroup">
                            <label for="address">주소</label> 
                            <input type="text" id="address" name="address">
                        </div>
                    </div>
                </div>
                <div class="actions">
                    <button type="submit" class="save">저장</button>
                    <button type="button" onclick="closePopup()">목록</button>
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
        let btn = document.querySelector("#btn")
        let sideBar = document.querySelector(".sideBar")
        
        btn.onclick = function () {
            sideBar.classList.toggle("active");
        };

        $(document).ready(function() {
            loadCategories();
            $('.toolBar a').off('click').on('click', handleToolBarClick);
            $('#searchForm').off('submit').on('submit', handleSearchFormSubmit);
        });
        
        let currentChosung  = '전체';
        let currentCategory = '전체';
        
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
                        	console.log(contact);
                        	console.log(contact.name);
                            var $row = $('<div>', {
                                class: 'rows',
                                onclick: 'handleRowClick(event, this)'
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

                    let cpage = response.cpage;
                    let record_total_count = response.totPage;
                    let record_count_per_page = response.recordCountPerPage;
                    let navi_count_per_page = response.naviCountPerPage;
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
                        categoryList.append('<li><a href="javascript:;" onclick="loadCategoryData(\'' + category + '\')">' + category + '</a><button onclick="showEditCategoryPopup(\'' + category + '\')"><i class="bx bx-edit"></i></button></li>');
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
    </script>
</body>
</html>
