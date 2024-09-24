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

