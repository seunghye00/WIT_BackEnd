// 주소록 체크박스
// 전체 선택 체크박스
const checkAll = document.getElementById('checkAll')
// 개별 선택 체크박스들
const individualChecks = document.querySelectorAll('.individual')

// 주소록 항목의 체크박스와 확인 버튼을 토글
function toggleCheckboxes() {
    const checkboxes = document.querySelectorAll('.addressCheckbox');
    const confirmBtn = document.querySelector('.createChatConfirmBtn');
    checkboxes.forEach(checkbox => {
        checkbox.style.display = checkbox.style.display === 'none' ? 'inline-block' : 'none'; // 체크박스 토글
    });
    confirmBtn.style.display = confirmBtn.style.display === 'none' ? 'inline-block' : 'none'; // 확인 버튼 토글
    clearCheckboxes();   // 체크박스 초기화
}

// 주소록 항목의 체크박스를 클릭하여 선택 상태를 토글
function toggleCheckbox(event, element, emp_no) {
    event.preventDefault();
    const checkbox = element.querySelector('.addressCheckbox');
    checkbox.checked = !checkbox.checked;
}
