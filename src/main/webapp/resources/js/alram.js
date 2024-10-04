var sock;

function connectWs(userId) {
    if (sock != null) {
        console.log("이미 연결되어 있습니다.");
        return; // 이미 연결된 경우 함수를 종료
    }else {
        sessionStorage.setItem("userId", userId);
        var host = window.location.host;
        var protocol = window.location.protocol;
        
        var wsUrl = protocol + "//" + host + "/ex/echo?userId=" + userId;
        
        sock = new SockJS(wsUrl);
        console.log(sock);
    }


    sock.onopen = function() {
        console.log("연결완료");
        onLogin(userId);
    };

    sock.onmessage = function(event) {
        console.log("서버로부터 메시지 수신: ", event.data);
        $(".alram").css("animation", "alram 3s infinite");
    };

    sock.onerror = function(error) {
        console.error("WebSocket 오류:", error);
    };

    sock.onclose = function() {
        console.log("WebSocket 연결 종료");
        sock = null; // 소켓 객체 초기화
    };

}



