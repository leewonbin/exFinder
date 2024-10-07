function toggleButtons(commId) {
	var reCommDiv = document.getElementById("reCommDiv-" + commId);
	var modifyDiv = document.getElementById("buttons-" + commId);
	if (modifyDiv.style.display === "none" || modifyDiv.style.display === "") {
		modifyDiv.style.display = "block";
		reCommDiv.style.display = "none";
	} else {
		modifyDiv.style.display = "none";
	}
}
function toggleRecomm(commId) {
	var reCommDiv = document.getElementById("reCommDiv-" + commId);
	var modifyDiv = document.getElementById("buttons-" + commId);
	if (reCommDiv.style.display === "none" || reCommDiv.style.display === "") {
		reCommDiv.style.display = "block";
		modifyDiv.style.display = "none";
	} else {
		reCommDiv.style.display = "none";
	}
}

function confirmBoardDelete(bId) {
	if (confirm("삭제하시겠습니까?")) {
		location.href = '/ex/board/delete?b_id=' + bId;
	}
}

function confirmDelete() {
	return confirm("삭제하시겠습니까?");
}