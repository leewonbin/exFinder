function submitForm(userId, button) {
    var row = button.closest('tr');
    var inputs = row.querySelectorAll('input, select');

    // 숨겨진 필드에 값을 설정
    document.getElementById('u_id').value = userId;

    inputs.forEach(function(input) {
        var field = input.getAttribute('data-field');
        var hiddenInput = document.getElementById(field);
        
        // 숨겨진 필드가 존재하는 경우에만 값을 설정
        if (hiddenInput) {
            hiddenInput.value = input.value;
        }
    });

    // 폼을 제출
    document.getElementById('updateForm').submit();
}


document.addEventListener("DOMContentLoaded", function () {
    const rowsPerPage = 8; // 페이지당 표시할 행 수
    const tableBody = document.querySelector("#users-table tbody"); // 테이블의 tbody 선택
    const rows = Array.from(tableBody.querySelectorAll("tr")); // 모든 행 선택
    const pageCount = Math.ceil(rows.length / rowsPerPage); // 총 페이지 수 계산
    const pagination = document.getElementById("pageUsersNumbers"); // 페이지 번호가 표시될 요소 선택

    let currentPage = 1; // 현재 페이지

    function displayPage(page) {
        // 모든 행을 숨기고 현재 페이지에 해당하는 행만 표시
        rows.forEach((row, index) => {
            row.style.display = (index >= (page - 1) * rowsPerPage && index < page * rowsPerPage) ? "" : "none";
        });
    }

    function updatePagination() {
        pagination.innerHTML = ""; // 기존 페이지 버튼 초기화

        for (let i = 1; i <= pageCount; i++) {
            const pageButton = document.createElement("button");
            pageButton.textContent = i;
            pageButton.onclick = function () {
                currentPage = i; // 클릭한 페이지로 이동
                displayPage(currentPage);
                updatePagination(); // 페이지 버튼 업데이트
            };
            if (i === currentPage) {
                pageButton.style.fontWeight = "bold"; // 현재 페이지 굵게 표시
            }
            pagination.appendChild(pageButton); // 페이지 버튼 추가
        }

        // 이전 및 다음 버튼 상태 업데이트
        document.getElementById("prevUsers").disabled = currentPage === 1;
        document.getElementById("nextUsersPage").disabled = currentPage === pageCount;
    }

    // 이전 페이지로 이동
    document.getElementById("prevUsers").addEventListener("click", function () {
        if (currentPage > 1) {
            currentPage--;
            displayPage(currentPage);
            updatePagination();
        }
    });

    // 다음 페이지로 이동
    document.getElementById("nextUsersPage").addEventListener("click", function () {
        if (currentPage < pageCount) {
            currentPage++;
            displayPage(currentPage);
            updatePagination();
        }
    });

    // 처음 페이지로 이동
    document.getElementById("firstUsers").addEventListener("click", function () {
        currentPage = 1;
        displayPage(currentPage);
        updatePagination();
    });

    // 마지막 페이지로 이동
    document.getElementById("lastUsersPage").addEventListener("click", function () {
        currentPage = pageCount;
        displayPage(currentPage);
        updatePagination();
    });

    // 초기 페이지 표시 및 버튼 상태 업데이트
    displayPage(currentPage);
    updatePagination();
});
