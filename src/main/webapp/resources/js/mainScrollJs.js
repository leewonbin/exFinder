window.addEventListener('scroll', function() {
    const scrollY = window.scrollY || window.pageYOffset || document.documentElement.scrollTop;
    const header = document.querySelector('.include_header');
    const alramContainer = document.getElementById("alramContainer"); // 알림 컨테이너 선택

    if (scrollY >= 330) {
        header.classList.add('show');
        header.style.setProperty("display", "block");
        
        // 알림 위치를 원래대로 되돌리기
        alramContainer.style.position = 'absolute'; // 원래 위치로 설정
        alramContainer.style.top = 'auto'; // 기본값으로 설정
        alramContainer.style.transform = 'none'; // 변환 초기화
        alramContainer.style.zIndex = ''; // 가장 위로 배치되도록 설정
    } else {
        header.classList.remove('show');
        header.style.setProperty("display", "none");

        
        // 알림 위치 변경 (예: 위쪽으로 이동)
        alramContainer.style.position = 'fixed'; // 고정 위치로 설정
        alramContainer.style.top = '10px'; // 상단 10px 위치로 이동
        alramContainer.style.transform = 'translateX(-50%)'; // 중앙 정렬을 위한 변환
        alramContainer.style.zIndex = '9999'; // 가장 위로 배치되도록 설정
    }
}, { passive: true });

