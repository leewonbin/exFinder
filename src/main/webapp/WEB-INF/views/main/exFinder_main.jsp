<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>웹페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/exFinder_main.css">
<script src="${pageContext.request.contextPath}/resources/js/mainScrollJs.js"></script>
</head>
<body>
	<!-- 헤더 Include -->
 	<div class="include_header">
		<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
	</div>

	<!-- 메인 콘텐츠 -->
	<div class="content">
		<!-- 환율 계산기 p 태그 -->
<!-- 		<p class="exchange-rate-calculator">환율 계산기</p> -->

<div class="top-content">
	<div class="top-content-wrap">
		<div class="top-content-start">
			<img src="${pageContext.request.contextPath }/resources/img/newLogo.png"/>
			<ul>
				<li>홈</li>
				<li>알림</li>
				<li>게시판</li>
			</ul>
		</div>
		<div class="top-content-end">
			<ul>
				<li>로그인</li>
				<li>회원가입</li>
			</ul>
		</div>
	</div>
</div>

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
					<option value="GBP" data-rate="1">영국 파운드 (GBP)</option>
					<option value="CHF" data-rate="0.93">스위스 프랑 (CHF)</option>
					<option value="CAD" data-rate="141.29">캐나다 달러 (CAD)</option>
					<option value="INR" data-rate="1318.42">인도 루피 (INR)</option>
					<option value="HKD" data-rate="1">홍콩 달러 (HKD)</option>
					<option value="EGP" data-rate="0.93">이집트 파운드 (EGP)</option>
					<option value="SAR" data-rate="141.29">사우디 리얄(SAR)</option>
					<option value="AUD" data-rate="1318.42">호주 달러(AUD)</option>
					<option value="THB" data-rate="1">태국 바트(THB)</option>
					<option value="RUB" data-rate="0.93">러시아 루블(RUB)</option>
					<option value="VND" data-rate="141.29">베트남 동(VND)</option>
					<option value="ZAR" data-rate="1318.42">남아공 랜드(ZAR)</option>
					<option value="MXN" data-rate="1">멕시코 페소(MXN)</option>
					<option value="BRL" data-rate="0.93">브라질 레알(BRL)</option>
					<option value="ILS" data-rate="141.29">이스라엘 쉐캐림(ILS)</option>
					<option value="NZD" data-rate="1318.42">뉴질랜드 달러(NZD)</option>
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
					<option value="GBP" data-rate="1">영국 파운드 (GBP)</option>
					<option value="CHF" data-rate="0.93">스위스 프랑 (CHF)</option>
					<option value="CAD" data-rate="141.29">캐나다 달러 (CAD)</option>
					<option value="INR" data-rate="1318.42">인도 루피 (INR)</option>
					<option value="HKD" data-rate="1">홍콩 달러 (HKD)</option>
					<option value="EGP" data-rate="0.93">이집트 파운드 (EGP)</option>
					<option value="SAR" data-rate="141.29">사우디 리얄(SAR)</option>
					<option value="AUD" data-rate="1318.42">호주 달러(AUD)</option>
					<option value="THB" data-rate="1">태국 바트(THB)</option>
					<option value="RUB" data-rate="0.93">러시아 루블(RUB)</option>
					<option value="VND" data-rate="141.29">베트남 동(VND)</option>
					<option value="ZAR" data-rate="1318.42">남아공 랜드(ZAR)</option>
					<option value="MXN" data-rate="1">멕시코 페소(MXN)</option>
					<option value="BRL" data-rate="0.93">브라질 레알(BRL)</option>
					<option value="ILS" data-rate="141.29">이스라엘 쉐캐림(ILS)</option>
					<option value="NZD" data-rate="1318.42">뉴질랜드 달러(NZD)</option>
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
