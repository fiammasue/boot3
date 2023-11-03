document.addEventListener("DOMContentLoaded", function () {
    // "boardid" 클래스를 가진 모든 체크박스 요소를 선택합니다.
    const boardCheckboxes = document.querySelectorAll(".memberid");

    // "chk" 체크박스 요소를 선택합니다.
    const chkCheckbox = document.querySelector("#chk");

    // 각 "boardid" 체크박스에 대한 클릭 이벤트를 추가합니다.
    boardCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("click", function () {
            // 모든 "boardid" 체크박스가 선택되었는지 확인합니다.
            const allSelected = Array.from(boardCheckboxes).every((cb) => cb.checked);

            // "chk" 체크박스의 체크 상태를 변경합니다.
            chkCheckbox.checked = allSelected;
        });
    });
    
});