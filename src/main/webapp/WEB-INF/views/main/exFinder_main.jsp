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

/* p 태그 스타일 - 국가별 차트 */
.country-chart {
	font-size: 1.1em;
	font-weight: bold;
	margin-left: 325px; /* x 위치 조정 */
	margin-top: 100px; /* p 태그와 div 간의 간격 조정 */
}

/* 구분선 스타일 */
.divider {
	margin: 20px 0; /* 위 아래 여백 */
	border: none;
	height: 1px;
	background-color: #dcdcdc; /* 밝은 회색 구분선 */
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

/* input 화살표 없앰 */
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

/* 기준 통화 섹션 */
.baseSection {
	margin-left: 360px;
}

/* 결과 통화 섹션 */
.resultSection {
	margin-right: 360px;
}

/* = 문자 스타일 */
.equals-sign {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 50px; /* 너비 조정 */
	height: 50px; /* 높이 조정 */
	text-align: center;
	margin-top: 220px
}

/* selectbox와 input 스타일 */
.currency-section select, .currency-section input {
	/* padding: 10px; */
	box-sizing: border-box; /* padding과 border가 포함된 크기 계산 */
}

/* 기준 통화 selectbox 스타일 */
.base-currency-select {
	width: 350px;
	height: 100px;
	margin-bottom: 40px;
	opacity: 0.8;
	border: none;
}

/* 기준 통화 숫자 입력 input 스타일 */
.base-amount-input {
	width: 500px;
	height: 130px;
	margin-bottom: 0; /* margin-bottom을 0으로 설정하여 겹치지 않도록 조정 */
	position: relative; /* 상대 위치 설정 */
	border: none;
	text-align: right;
	font-size: 1.8em;
	padding-bottom: 30px;
	padding-right: 20px;
	box-shadow: 3px 3px 1px #C8E2E8;
}

/* 기준 통화 결과 표시 input 스타일 */
.base-result-input {
	width: 500px;
	height: 37px;
	background-color: white;
	position: absolute; /* 절대 위치 설정 */
	bottom: 50px;
	left: 0;
	margin: 0;
	border: none;
	text-align: right;
	padding-right: 20px;
}

/* 결과 통화 selectbox 스타일 */
.result-currency-select {
	width: 350px;
	height: 100px;
	margin-bottom: 40px;
	opacity: 0.8;
	border: none;
}

/* 결과 통화 숫자 입력 input 스타일 */
.result-amount-input {
	width: 500px;
	height: 130px;
	margin-bottom: 0; /* margin-bottom을 0으로 설정하여 겹치지 않도록 조정 */
	position: relative; /* 상대 위치 설정 */
	border: none;
	text-align: right;
	font-size: 1.8em;
	padding-bottom: 30px;
	padding-right: 20px;
	box-shadow: 3px 3px 1px #C8E2E8;
}

/* 결과 통화 결과 표시 input 스타일 */
.result-result-input {
	width: 500px;
	height: 37px;
	background-color: white;
	position: absolute; /* 절대 위치 설정 */
	bottom: 50px;
	left: 0;
	margin: 0;
	border: none;
	text-align: right;
	padding-right: 20px;
}
/* 슬라이드 쇼 */
/* li{list-style:none;}
.flex{
  display:flex;
}

.flex-jc-c{
  justify-content:center;
}
.con{
  max-width:1200px;
  margin:0 auto;
  border:solid red;
}

.article-board-box{
  position:relative;
  border:solid red;
}
.slide_wrapper{
  border:solid red;
  position:relative;
  width:960px;
  margin:0 auto;
  height:300px;
  overflow:hidden
}

.slides{
  position:absolute;
  left:0;
  top:0;
  transition:left 0.5s ease-out;
}

.slides li:not(:last-child){
  justify-content:flex-start;
  margin-right:30px;
}


.controls{
  text-align:center;
}

.controls span{
  z-index:2;
  position:absolute;
  top:50%;
  transform:translateY(-50%);
}

.controls>.prev{
  right:calc(100% - 40px);
}

.controls>.next{
  left:calc(100% - 40px);
}

.ha{
  width:50px;
} */
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
			<img alt=""
				src="${pageContext.request.contextPath}/resources/img/equals.png"
				class="equals-sign">

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

		<!-- 국가별 차트 p 태그 -->
		<p class="country-chart">국가별 차트</p>

		<!-- 구분선 -->
		<hr class="divider">
		<!-- 슬라이드쇼 미완성 -->
<!-- 		<div class="slide_wrapper ">
			<ul class="slides flex">
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
				<li><img src="http://placehold.it/300x300" alt=""></li>
			</ul>
			<p class="controls">
				<span class="prev"><i class="fas fa-chevron-left">◀</i></span> 
				<span class="next"><i class="fas fa-chevron-right">▶</i></span>
			</p>
		</div> -->

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
		
		/* var slides = document.querySelector('.slides'),
		  slide = document.querySelectorAll('.slides li'),
		  currentIdx = 0,
		  slideCount = slide.length,
		  slideWidth = 300,
		  slideMargin = 30,
		  prevBtn = document.querySelector('.prev'),
		  nextBtn = document.querySelector('.next');

		slides.style.width =
		  (slideWidth + slideMargin) * slideCount - slideMargin + 'px';

		function moveSlide(num) {
		  slides.style.left = -num * 330 + 'px';
		  currentIdx = num;
		}

		nextBtn.addEventListener('click', function () {
		  if( currentIdx < slideCount - 3){
		    moveSlide(currentIdx + 1);
		  }else{
		    moveSlide(0);
		  }   
		});

		prevBtn.addEventListener('click', function () {
		  if( currentIdx > 0){
		    moveSlide(currentIdx - 1);
		  }else{
		    moveSlide(slideCount - 3);
		  }   
		}); */
	</script>
</body>
</html>
