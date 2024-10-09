	document.addEventListener("DOMContentLoaded", function () {
	    const rowsPerPage = 8; // 한 페이지에 보여줄 행 수
	    let currentBoardPage = 1;
	    const boardRows = document.querySelectorAll("#boardBody tr"); // 모든 데이터 행

	    // 전체 페이지 수 계산
	    const totalBoardPages = Math.ceil(boardRows.length / rowsPerPage);

	    function displayBoardTable(page) {
	        const start = (page - 1) * rowsPerPage;
	        const end = start + rowsPerPage;

	        // 테이블 행을 모두 숨긴 후 해당 페이지의 행만 보이게 함
	        boardRows.forEach((row, index) => {
	            row.style.display = (index >= start && index < end) ? "" : "none";
	        });

	        // 페이지 버튼 동적 생성
	        createBoardPageButtons();

	        // 버튼 상태 업데이트
	        document.getElementById('boardPrev').disabled = (page === 1);
	        document.getElementById('boardFirst').disabled = (page === 1);
	        document.getElementById('boardNext').disabled = (page === totalBoardPages);
	        document.getElementById('boardLast').disabled = (page === totalBoardPages);

	        // 버튼 보이기/숨기기
/* 	        document.getElementById('boardFirst').style.display = (page === 1) ? 'none' : 'inline-block';
	        document.getElementById('boardPrev').style.display = (page === 1) ? 'none' : 'inline-block';
	        document.getElementById('boardNext').style.display = (page === totalBoardPages) ? 'none' : 'inline-block';
	        document.getElementById('boardLast').style.display = (page === totalBoardPages) ? 'none' : 'inline-block';
 */	    }

	    // 페이지 번호 버튼을 동적으로 생성하는 함수
	    function createBoardPageButtons() {
	        const boardPageButtonsDiv = document.getElementById("boardPageButtons");
	        boardPageButtonsDiv.innerHTML = ""; // 기존 버튼들을 모두 제거

	        const groupSize = 10; // 그룹당 버튼 수
	        const currentGroup = Math.ceil(currentBoardPage / groupSize);
	        const startPage = (currentGroup - 1) * groupSize + 1;
	        const endPage = Math.min(startPage + groupSize - 1, totalBoardPages);

	        // 버튼 생성
	        for (let i = startPage; i <= endPage; i++) {
	            const pageButton = document.createElement("button");
	            pageButton.textContent = i;
	            pageButton.classList.add("page-btn");

	            if (i === currentBoardPage) {
	                pageButton.classList.add("active");
	            }

	            // 페이지 버튼 클릭 이벤트
	            pageButton.addEventListener("click", function () {
	                currentBoardPage = i;
	                displayBoardTable(currentBoardPage);
	            });

	            boardPageButtonsDiv.appendChild(pageButton);
	        }
	    }

	    // 이전 버튼 클릭 이벤트
	    document.getElementById('boardPrev').addEventListener('click', function () {
	        if (currentBoardPage > 1) {
	            currentBoardPage--;
	            displayBoardTable(currentBoardPage);
	        }
	    });

	    // 다음 버튼 클릭 이벤트
	    document.getElementById('boardNext').addEventListener('click', function () {
	        if (currentBoardPage < totalBoardPages) {
	            currentBoardPage++;
	            displayBoardTable(currentBoardPage);
	        }
	    });

	    // 첫 페이지 버튼 클릭 이벤트
	    document.getElementById('boardFirst').addEventListener('click', function () {
	        currentBoardPage = 1;
	        displayBoardTable(currentBoardPage);
	    });

	    // 마지막 페이지 버튼 클릭 이벤트
	    document.getElementById('boardLast').addEventListener('click', function () {
	        currentBoardPage = totalBoardPages;
	        displayBoardTable(currentBoardPage);
	    });

	    // 초기 테이블 및 버튼 표시
	    displayBoardTable(currentBoardPage);
	});

