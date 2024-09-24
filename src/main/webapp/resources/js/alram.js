var sock;

function connectWs(userId) {
    if (sock) {
        sock.close();
        sock = null;
    }
    
    var host = window.location.host;
    var protocol = window.location.protocol;  // 여기서는 ws: 대신 http:나 https: 사용

    // 상대 경로로 URL 생성 (SockJS는 http 또는 https 사용)
    var wsUrl = protocol + "//" + host + "/ex/echo?userId=" + userId;

    // 사용자 ID를 URL 쿼리로 추가
    var ws = new SockJS(wsUrl);
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
