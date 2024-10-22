
document.addEventListener('DOMContentLoaded', function () {
    try {
        var miniMyPageElements = document.getElementsByClassName('miniMyPage');
        var toggleButton = document.getElementById('toggleButton');
        var toggleButton2 = document.getElementById('toggleButton2');

        // 로그아웃 상태 확인
        var logoutStatus = document.querySelector('meta[name="logout-status"]').getAttribute('content');

        if (logoutStatus === 'logged-out' || logoutStatus === 'logged-in') {
            // 모든 miniMyPage 요소를 숨김
            for (let element of miniMyPageElements) {
                element.style.display = 'none';
            }
            toggleButton.style.backgroundImage = "url('/ex/resources/img/down.png')";
            toggleButton2.style.backgroundImage = "url('/ex/resources/img/down.png')";
        }
    } catch (e) {
        // 오류 발생 시 아무 동작도 하지 않음
    }
});

function toggleMiniMyPage() {
    var miniMyPageElements = document.getElementsByClassName('miniMyPage');
    var toggleButton = document.getElementById('toggleButton');
    var toggleButton2 = document.getElementById('toggleButton2');

    // 첫 번째 요소의 display 속성을 기준으로 동작
    let isHidden = miniMyPageElements[0].style.display === 'none' || miniMyPageElements[0].style.display === '';

    for (let element of miniMyPageElements) {
        element.style.display = isHidden ? 'flex' : 'none';
    }

    let backgroundImage = isHidden ? "url('/ex/resources/img/up.png')" : "url('/ex/resources/img/down.png')";
    toggleButton.style.backgroundImage = backgroundImage;
    toggleButton2.style.backgroundImage = backgroundImage;
    
    var mini_myPage_view = document.getElementById("mini_myPage_view");
    
	var headerMiniMyPage = mini_myPage_view.querySelector(".header_mini_myPage");
    headerMiniMyPage.style.top = '165px';
}