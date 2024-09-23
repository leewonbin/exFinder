<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>통화 상세 정보</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery.min.js"></script>
<!-- google charts -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/exFinder_Currency.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/exFinder_Currency.js"></script>
<style></style>
<script>
	var currencyCode = '${currencyDto.c_code}';
</script>
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

	<div style="width: 100%; height: 110px;"></div>

	<!-- 중앙에 위치시키기 위한 div -->
	<div class="Currency_view">
		<div class="Currency_header">
			<img
				src="${pageContext.request.contextPath}/resources/img/gonfalon/${currencyDto.c_code}.png">
			<a><b>${currencyDto.c_country}</b> ${currencyDto.c_code}</a> <i
				class="circle" id="toggle-list"> <i class="arrow-up"></i>
			</i>
		</div>
		<div class="Currency_chart">
			<div class="Currency_left_chart">
				<div class="Currency_left_chart_header">
					<a>매매 기준율</a>
					<div id="value_Currency"></div>
				</div>
				<table class="Currency_left_chart_table">
					<tr>
						<th colspan="2">현찰</th>
						<th colspan="2">송금 (전신환)</th>
					</tr>
					<tr>
						<th>사실때</th>
						<td>${exchangeRateDto.cash_buy}</td>
						<th>보낼때</th>
						<td>${exchangeRateDto.ttb}</td>
					</tr>
					<tr>
						<th>파실때</th>
						<td>${exchangeRateDto.cash_sell}</td>
						<th>받을때</th>
						<td>${exchangeRateDto.tts}</td>
					</tr>
				</table>
				<div>기준일 : ${exchangeRateDto.rate_date}</div>
			</div>
			<div class="Currency_right_chart">
				<div class="Currency_chart_time_select">
					<ul>
						<li><a href="#" id="seven-day">7일</a></li>
						<li><a href="#" id="one-month">1개월</a></li>
						<li><a href="#" id="three-month">3개월</a></li>
						<li><a href="#" id="one-year">1년</a></li>
					</ul>
				</div>
				<div id="chart_7day" class="chart_graph"></div>
				<div id="chart_1month" class="chart_graph"></div>
				<div id="chart_3month" class="chart_graph"></div>
				<div id="chart_1year" class="chart_graph"></div>
			</div>
		</div>
		<div class="Currency_news-list">
			<!-- 뉴스 리스트 출력 -->
			<div class="news-list">
				<!-- EL을 사용하여 newsTitles와 newsURLs 출력 -->
				<c:forEach var="i" items="${newsTitles}" varStatus="status">
					<c:if test="${status.index < 4}">
						<div class="news-item">
							<div class="new-header">
								<img src="${newsIcons.get(status.index)}">${newsNames.get(status.index)}
								- ${newsTimes.get(status.index)}
							</div>
							<div class="new-main"
								onclick="window.location.href='${newsURLs.get(status.index)}';">
								<div class="new-main-text">
									<label>${newsTitles.get(status.index)} </label><br> <a>${newsTexts.get(status.index)}</a>
								</div>
								<img src="${newsImgs.get(status.index)}" alt="뉴스 이미지">
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>


	<h1 class="rate-day">일자별</h1>

	<div class="box-contents">
		<h2>${currencyCode}일자별 환율</h2>
		<table class="exchange">
			<thead>
				<tr class="chart">
					<th>날짜</th>
					<th>종가</th>
					<th>매매기준율</th>
					<th>전일비</th>
					<th>사실때</th>
					<th>파실때</th>
					<th>보낼때</th>
					<th>받을때</th>
					<th>기준환율</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dailyCurrency" items="${dailyRates}">
					<tr>
						<td>${dailyCurrency.rate_date}</td>
						<td>${dailyCurrency.deal_bas_r}</td>
						<td>${dailyCurrency.cash_sell}</td>
						<td>${dailyCurrency.previous_day_diff}</td>
						<td>${dailyCurrency.cash_buy}</td>
						<td>${dailyCurrency.cash_sell}</td>
						<td>${dailyCurrency.ttb}</td>
						<td>${dailyCurrency.tts}</td>
						<td>${dailyCurrency.base_r}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>



</body>
<script>
	/*
	 <span id="currency-list" class="hidden">
	 <a>미국 USD</a>
	 <a>일본 JPY</a>
	 <a>유럽연합 EUR</a>
	 <a>중국 CNY</a>
	 <a>영국 GBP</a>
	
	 <a>스위스 CHF</a>
	 <a>캐나다 CAD</a>
	 <a>인도 INR</a>
	 <a>홍콩 HKD</a>
	 <a>이집트 EGP</a>
	
	 <a>사우디 SAR</a>
	 <a>호주 AUD</a>
	 <a>태국 THB</a>
	 <a>러시아 RUB</a>
	 <a>베트남 VND</a>
	
	 <a>남아공 ZAR</a>
	 <a>멕시코 MXN</a>
	 <a>브라질 BRL</a>
	 <a>이스라엘 ILS</a>
	 <a>뉴질랜드 NZD</a> 		
	 </span>*/
</script>
</html>