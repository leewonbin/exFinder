$(document).ready(function() {
	console.log('여기로 들어옴');
	$.ajax({
		url : "/ex/exchange/todayExchange",
		type : "POST",
		dataType: "json",
		success : function(res) {
			console.log("====================todayExchange=======================")
			console.log(res);
		},
		error: function(xhr, status, error) {
			console.error("AJAX Error:", status, error);  // 오류 내용 출력
			console.error(xhr.responseText);  // 서버에서 응답한 에러 메시지 출력
		}
	});
})