$(document).ready(function() {
	$(".update-btn").click(function() {
		$(".result_p").text("업데이트 중....");
		$.ajax({
			url : "/ex/exchange/update",
			type : "post",
			success : function(res) {
				if(res === "SUCCESS") {
					$(".result_p").text("업데이트 완료 !!!....");
				}
			}
		})
	})
})