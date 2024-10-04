/**
 * 
 */
let currentAlramVisible = false; // 현재 가시성 상태 변수

function toggleAlram() {
    // 알림 컨테이너 요소 가져오기
    const alramContainer = document.getElementById("alramContainer");

    // 현재 가시성 상태에 따라 알림 보이기 또는 숨기기
    if (currentAlramVisible) {
        // 알림이 보이는 경우 숨김
        alramContainer.style.display = "none"; // 알림 숨김
        currentAlramVisible = false; // 상태 업데이트
    } else {
        // 알림이 보이지 않는 경우 로드 후 보이기
        loadAlram(); // 알림 로드
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
            document.getElementById("alramContainer").innerHTML = xhr.responseText; // 서버에서 받은 데이터 설정
            document.getElementById("alramContainer").style.display = "block"; // 알림 표시
        }
    };
    xhr.send("type=" + encodeURIComponent(alramType)); // 요청 데이터 전송
}