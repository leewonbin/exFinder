var sock;

function connectWs(userId) {
    if (sock) {
        sock.close();
        sock = null;
    }

    // 사용자 ID를 URL 쿼리로 추가
    var ws = new SockJS("http://localhost:8081/ex/echo?userId=" + userId);
    sock = ws;

    ws.onopen = function() {
        console.log("연결완료");
    };

    ws.onmessage = function(event) {
        console.log("서버로부터 메시지 수신: ", event.data);
    };

    ws.onclose = function() {
        console.log("연결이 종료되었습니다.");
        sock = null;
    };
}
