/**
 * 
 */


	
function alramDelete(aId,element) {
	console.log(aId);

	if (confirm("이 알림을 정말 삭제하시겠습니까?")) {
		$(element).closest('.alarm_message').remove();

		// 알림 삭제를 위한 AJAX 요청
		$.ajax({
			url : '/ex/user/alramDelete',
			type : 'POST',
			data : {
				a_id : aId
			},
			success : function(response) {

			},
			error : function(xhr, status, error) {
				alert("알림 삭제 중 오류가 발생했습니다.");
				// 실패 시, 메시지를 다시 추가하는 로직을 여기에 구현할 수 있습니다
			}
		});
	}
};

function clearAllAlarms() {
    if (confirm("모든 알림을 삭제하시겠습니까?")) {
        $.ajax({
            url: '/ex/user/alramDeleteAll', // 모든 알림을 삭제하는 URL
            type: 'POST',
            success: function(response) {
                // 성공적으로 삭제된 경우 알림 메시지를 모두 제거
                $('.alarm_message').remove(); // 모든 알림 메시지 제거
            },
            error: function(xhr, status, error) {
                alert("모든 알림 삭제 중 오류가 발생했습니다.");
            }
        });
    }
}

let currentAlramVisible = false; // 초기 알림 가시성 상태
function alramRead() {
	$.ajax({
		url: '/ex/user/alramRead',
		type : 'POST',
		success : function(response) {
		}
	})
}
function toggleAlram() {
	// 알림 컨테이너 요소 가져오기
	const alramContainer = document.getElementById("alramContainer");

	// 현재 가시성 상태에 따라 알림 보이기 또는 숨기기
	if (currentAlramVisible) {
		// 알림이 보이는 경우 숨김
		alramRead();
		alramContainer.style.display = "none"; // 알림 숨김
		currentAlramVisible = false; // 상태 업데이트
	} else {
		// 알림이 보이지 않는 경우 로드 후 보이기
		loadAlram(); // 알림 로드
		$(".alram").css("animation", "none");
		alramContainer.style.display = "block"; // 알림 표시
		currentAlramVisible = true; // 상태 업데이트
	}
}

function loadAlram(alramType) {
	var xhr = new XMLHttpRequest();
	xhr.open("POST", '/ex/user/loadAlram', true); // 알림 로드 URL
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			document.getElementById("alramContainer").innerHTML = xhr.responseText; // 서버에서
																					// 받은
																					// 데이터
																					// 설정
			document.getElementById("alramContainer").style.display = "block"; // 알림
																				// 표시
		}
	};
	xhr.send("type=" + encodeURIComponent(alramType)); // 요청 데이터 전송
}
