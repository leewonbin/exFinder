    document.addEventListener("DOMContentLoaded", function () {
        const rowsPerPage = 7; // 페이지당 표시할 행 수
        const tableBody = document.querySelector("#cs tbody");
        const rows = tableBody.querySelectorAll("tr");
        const pageCount = Math.ceil(rows.length / rowsPerPage);
        const pagination = document.getElementById("pageNumbers");

        let currentPage = 1;

        function displayPage(page) {
            // 모든 행을 숨기고 현재 페이지에 해당하는 행만 표시
            rows.forEach((row, index) => {
                row.style.display = (index >= (page - 1) * rowsPerPage && index < page * rowsPerPage) ? "" : "none";
            });
        }

        function updatePagination() {
            pagination.innerHTML = "";

            for (let i = 1; i <= pageCount; i++) {
                const pageButton = document.createElement("button");
                pageButton.textContent = i;
                pageButton.onclick = function () {
                    currentPage = i;
                    displayPage(currentPage);
                    updatePagination();
                };
                if (i === currentPage) {
                    pageButton.style.fontWeight = "bold"; // 현재 페이지 굵게 표시
                }
                pagination.appendChild(pageButton);
            }

            // 이전 및 다음 버튼 상태 업데이트
            document.getElementById("prevPage").disabled = currentPage === 1;
            document.getElementById("nextPage").disabled = currentPage === pageCount;
        }

        // 이전 페이지로 이동
        document.getElementById("prevPage").addEventListener("click", function () {
            if (currentPage > 1) {
                currentPage--;
                displayPage(currentPage);
                updatePagination();
            }
        });

        // 다음 페이지로 이동
        document.getElementById("nextPage").addEventListener("click", function () {
            if (currentPage < pageCount) {
                currentPage++;
                displayPage(currentPage);
                updatePagination();
            }
        });

        // 처음 페이지로 이동
        document.getElementById("firstPage").addEventListener("click", function () {
            currentPage = 1;
            displayPage(currentPage);
            updatePagination();
        });

        // 마지막 페이지로 이동
        document.getElementById("lastPage").addEventListener("click", function () {
            currentPage = pageCount;
            displayPage(currentPage);
            updatePagination();
        });

        // 초기 페이지 표시 및 버튼 상태 업데이트
        displayPage(currentPage);
        updatePagination();
    });
