document.addEventListener('DOMContentLoaded', function() {
    var miniMyPage = document.getElementById('miniMyPage');
    var toggleButton = document.getElementById('toggleButton');

    // 로그아웃 상태 확인
    var logoutStatus = document.querySelector('meta[name="logout-status"]').getAttribute('content');

    if (logoutStatus === 'logged-out') {
        miniMyPage.style.display = 'none'; // 기본적으로 숨김
        toggleButton.style.backgroundImage = "url('/ex/resources/img/down.png')"; // 닫힘 이미지 설정
    } else if (logoutStatus === 'logged-in') {
        miniMyPage.style.display = 'none'; // 기본적으로 숨김
        toggleButton.style.backgroundImage = "url('/ex/resources/img/down.png')"; // 닫힘 이미지 설정
    }

    
});

function toggleMiniMyPage() {
    var miniMyPage = document.getElementById('miniMyPage');
    var toggleButton = document.getElementById('toggleButton');

    if (miniMyPage.style.display === 'none' || miniMyPage.style.display === '') {
        miniMyPage.style.display = 'flex'; // 요소를 표시
        toggleButton.style.backgroundImage = "url('/ex/resources/img/up.png')"; // 열림 이미지로 변경
    } else {
        miniMyPage.style.display = 'none'; // 요소를 숨김
        toggleButton.style.backgroundImage = "url('/ex/resources/img/down.png')"; // 닫힘 이미지로 변경
    }
}
