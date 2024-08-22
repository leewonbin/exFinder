<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>웹페이지</title>
<style>
/* 페이지 전체 크기와 기본 설정 */
body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	font-family: Arial, sans-serif;
	box-sizing: border-box; /* padding과 border가 포함된 크기를 계산 */
}

/* 콘텐츠 영역 */
.content {
	height: calc(4000px - 120px); /* 헤더를 제외한 나머지 공간 */
	padding: 20px;
	position: relative;
}

/* p 태그 스타일 */
.exchange-rate-calculator {
	font-size: 1.1em;
	font-weight: bold;
	margin-left: 325px; /* x 위치 조정 */
	margin-top: 208px; /* y 위치 조정 */
}

/* div 영역 스타일 */
.calculator-container {
	width: 100vw; /* 화면의 전체 너비 */
	height: 400px;
	background-color: #D4F4FC;
	margin-top: 20px; /* p 태그와 div 간격 */
	margin-left: calc(-50vw + 50%); /* 화면 전체 너비를 차지하게 정렬 */
	display: flex;
	justify-content: space-between; /* 왼쪽과 오른쪽으로 배치 */
	padding: 20px;
	box-sizing: border-box; /* padding과 border가 포함된 크기 계산 */
}

/* 기준 통화와 결과 통화 섹션 스타일 */
.currency-section {
	display: flex;
	flex-direction: column;
	align-items: flex-start; /* 왼쪽 정렬 */
	justify-content: center;
	position: relative; /* 상대 위치 설정 */
}

/* 기준 통화 섹션 */
.baseSection {
	margin-left: 375px;
}

/* 결과 통화 섹션 */
.resultSection {
	margin-right: 375px;
}

/* = 문자 스타일 */
.equals-sign {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 4em; /* 크기 조정 */
	font-weight : bold;
	color : white;
	width: 50px; /* 너비 조정 */
	height: 50px; /* 높이 조정 */
	margin : auto 0;
	border-radius: 50%;
	background-color : #0091FF;
}

/* selectbox와 input 스타일 */
.currency-section select, .currency-section input {
	padding: 10px;
	font-size: 1em;
	box-sizing: border-box; /* padding과 border가 포함된 크기 계산 */
}

/* 기준 통화 selectbox 스타일 */
.base-currency-select {
	width: 350px;
	height: 80px;
	margin-bottom: 10px;
}

/* 기준 통화 숫자 입력 input 스타일 */
.base-amount-input {
	width: 530px;
	height: 110px;
	margin-bottom: 0; /* margin-bottom을 0으로 설정하여 겹치지 않도록 조정 */
	position: relative; /* 상대 위치 설정 */
}

/* 기준 통화 결과 표시 input 스타일 */
.base-result-input {
	width: 530px;
	height: 37px;
	background-color: #e0e0e0;
	cursor: not-allowed;
	position: absolute; /* 절대 위치 설정 */
	bottom: 80px;
	left: 0;
	margin: 0;
}

/* 결과 통화 selectbox 스타일 */
.result-currency-select {
	width: 350px;
	height: 80px;
	margin-bottom: 10px;
}

/* 결과 통화 숫자 입력 input 스타일 */
.result-amount-input {
	width: 530px;
	height: 110px;
	margin-bottom: 0; /* margin-bottom을 0으로 설정하여 겹치지 않도록 조정 */
	position: relative; /* 상대 위치 설정 */
}

/* 결과 통화 결과 표시 input 스타일 */
.result-result-input {
	width: 530px;
	height: 37px;
	background-color: #e0e0e0;
	cursor: not-allowed;
	position: absolute; /* 절대 위치 설정 */
	bottom: 80px;
	left: 0;
	margin: 0;
}

</style>
</head>
<body>
	<!-- 헤더 Include -->
	<div class="header">
		<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
	</div>

	<!-- 메인 콘텐츠 -->
	<div class="content">
		<!-- 환율 계산기 p 태그 -->
		<p class="exchange-rate-calculator">환율 계산기</p>

		<!-- 환율 계산기 div 영역 -->
		<!-- 환율 계산기 div 영역 -->
		<div class="calculator-container">
			<!-- 기준 통화 섹션 -->
			<div class="currency-section baseSection">
				<!-- 기준 통화 SelectBox -->
				<select id="base-currency-select" class="base-currency-select">
					<option value="USD" data-rate="1">미국 달러 (USD)</option>
					<option value="EUR" data-rate="0.93">유로 (EUR)</option>
					<option value="JPY" data-rate="141.29">일본 엔 (JPY)</option>
					<option value="KRW" data-rate="1318.42">한국 원화 (KRW)</option>
					<!-- 추가 가능한 다른 국가들 -->
				</select>

				<!-- 기준 통화 금액 입력 InputBox -->
				<input type="number" id="base-amount-input"
					class="base-amount-input" placeholder="금액 입력" />

				<!-- 기준 통화 결과 입력 InputBox -->
				<input type="text" id="base-result-input" class="base-result-input"
					placeholder="변환 결과" readonly />
			</div>

			<!-- '=' 문자 -->
			<div class="equals-sign">=</div>

			<!-- 결과 통화 섹션 -->
			<div class="currency-section resultSection">
				<!-- 결과 통화 SelectBox -->
				<select id="result-currency-select" class="result-currency-select">
					<option value="USD" data-rate="1">미국 달러 (USD)</option>
					<option value="EUR" data-rate="0.93">유로 (EUR)</option>
					<option value="JPY" data-rate="141.29">일본 엔 (JPY)</option>
					<option value="KRW" data-rate="1318.42">한국 원화 (KRW)</option>
					<!-- 추가 가능한 다른 국가들 -->
				</select>

				<!-- 결과 통화 금액 입력 InputBox -->
				<input type="number" id="result-amount-input"
					class="result-amount-input" placeholder="금액 입력" />

				<!-- 결과 통화 결과 입력 InputBox -->
				<input type="text" id="result-result-input"
					class="result-result-input" placeholder="변환 결과" readonly />
			</div>
		</div>

	</div>

	<script>
		// 환율 변환 로직
		function updateBaseResult() {
			const amount = parseFloat(document
					.getElementById('base-amount-input').value) || 0;
			const baseSelect = document.getElementById('base-currency-select');
			const baseRate = parseFloat(baseSelect.selectedOptions[0]
					.getAttribute('data-rate')) || 1;
			const baseResultInput = document
					.getElementById('base-result-input');

			// 기준 통화에서 변환 결과를 계산
			const result = amount / baseRate;

			// 결과를 천 단위로 포맷
			const formattedResult = result.toLocaleString() + " "
					+ baseSelect.selectedOptions[0].text.split(" ")[1];

			// 결과 입력박스에 값 표시
			baseResultInput.value = formattedResult;
		}

		function updateResult() {
			const amount = parseFloat(document
					.getElementById('result-amount-input').value) || 0;
			const baseSelect = document.getElementById('base-currency-select');
			const resultSelect = document
					.getElementById('result-currency-select');

			const baseRate = parseFloat(baseSelect.selectedOptions[0]
					.getAttribute('data-rate')) || 1;
			const resultRate = parseFloat(resultSelect.selectedOptions[0]
					.getAttribute('data-rate')) || 1;

			// 기준 통화에서 결과 통화로 변환
			const result = (amount / baseRate) * resultRate;

			// 결과를 천 단위로 포맷
			const formattedResult = result.toLocaleString() + " "
					+ resultSelect.selectedOptions[0].text.split(" ")[1];

			// 결과 입력박스에 값 표시
			document.getElementById('result-result-input').value = formattedResult;
		}

		// 이벤트 리스너 추가
		document.getElementById('base-amount-input').addEventListener('input',
				updateBaseResult);
		document.getElementById('base-currency-select').addEventListener(
				'change', updateBaseResult);
		document.getElementById('result-amount-input').addEventListener(
				'input', updateResult);
		document.getElementById('result-currency-select').addEventListener(
				'change', updateResult);
	</script>
</body>
</html>
