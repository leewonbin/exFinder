<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function alramTest() {
		$.ajax({
		    url: '/ex/test/ajaxRequest',
		    method: 'GET',
		    success: function(response) {
		        console.log(response); // 서버에서 반환한 메시지를 출력
		    },
		    error: function(xhr, status, error) {
		        console.error('AJAX 요청 실패:', error);
		    }
		});
	}
</script>
<body>
<button onclick="alramTest()">알림주기</button>
</body>
</html>