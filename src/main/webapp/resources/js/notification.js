
	$(function() {
		$.ajax({
			url : "/ex/getCurrency",
			type : "POST",
			success : function(response) { // success는 함수로 넘겨야 합니다
				// 배열을 역순으로 변경
	            response.reverse();
	            
				var selectInnerHtml = "<option value='default' selected>-- 통화를 선택하세요 --</option>";
				var chartInnerHtml = "";
				response.forEach(function(curr) {
					selectInnerHtml += "<option value='"+curr.c_code+"'>"+curr.c_country+" "+curr.c_name+" ("+curr.c_code+")</option>";
	                chartInnerHtml += 
	                    "<div class='chart_graph_box_container' id='"+curr.c_code+"-chart' style='display: none;'>" +
	                        "<div class='chart_graph_box'>" +
	                            "<div class='chart_graph_box_top'>" +
	                           	  "<img src='" + imgSrc + curr.c_code +".png'>" +
	                                curr.c_country + " " + curr.c_code +
	                                "<div id='value_" + curr.c_code + "'></div>" +
	                            "</div>" +
	                            "<div id='chart_" + curr.c_code + "' class='chart_graph'></div>" +
	                        "</div>" +
	                    "</div>";
					
				})
				$("#currency").html(selectInnerHtml);
				$(".charts_container").html(chartInnerHtml);
				
			},
			error : function(xhr, status, error) { // 오류 처리용 콜백
				console.log("Error: " + error);
			}
		});
	});
	
	function submitNotification() {
		var curr = $("#currency");
		var targetRate = $("#targetRate");
		$.ajax({
			url : "/ex/user/setExchangeAlert",
			type : "POST",
			dataType: "text",
			data : {
				currency : curr.val(),
				targetRate : targetRate.val()
			},
			success : function(response) {
				if(response == 'success') {
					// 알림 설정 완료 메시지 표시
	                alert('알림 설정이 완료되었습니다.');

					targetRate.val("");
					$('.checkbox-phone input[type="checkbox"]').prop('checked', false);
					
					// 부모 페이지에 팝업 닫기 요청 전송
	                window.parent.postMessage('closePopup', '*');
				}else {
					alert('알림 설정에 실패했습니다. 다시 시도해주세요.');
				}
			}
		})
	}

function calculateTolerance() {
	var targetRate = document.getElementById("targetRate").value;

	// 문자열을 숫자로 변환
	targetRate = parseFloat(targetRate);

	// 숫자인지 확인 후 계산
	if (!isNaN(targetRate)) {
		var toleranceRange = (targetRate * 0.002).toFixed(2);
		var minRate = (targetRate - toleranceRange).toFixed(2);
		var maxRate = (targetRate + parseFloat(toleranceRange)).toFixed(2);

		// 오차 범위 표시
		document.getElementById("toleranceInfo").innerText = "설정된 환율 범위: "
				+ minRate + "원 ~ " + maxRate + "원 (± 0.2%)";
	} else {
		// 유효하지 않은 값일 경우 빈 문자열로 초기화
		document.getElementById("toleranceInfo").innerText = "";
	}
}

//페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    const checkbox = document.getElementById('agreeCheckbox');
    const submitBtn = document.getElementById('submitBtn');

    // 체크박스 상태 변경 시 버튼 활성화/비활성화
    checkbox.addEventListener('change', function() {
        submitBtn.disabled = !this.checked; // 체크 여부에 따라 상태 변경
    });

    // 초기 상태에서 버튼 비활성화
    submitBtn.disabled = !checkbox.checked;
});

