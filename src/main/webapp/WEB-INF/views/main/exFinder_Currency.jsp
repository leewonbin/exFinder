<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<title>환율 상세페이지</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery.min.js"></script>
	<!-- google charts -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/exFinder_Currency.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/exFinder_Currency.js"></script>
	<style></style>

	<script>
		var currencyCode = '${currencyDto.c_code}';

		//sessionScope에 있는 dto가 null이 아니면 로그인 상태로 설정
		var isLoggedIn = "${sessionScope.dto != null}";
		
		
	</script>
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

	<!-- 알림을 표시할 div -->
	<div id="alramContainer" style="display: none;"></div>

	<div style="width: 100%; height: 110px;"></div>
	<c:set var="interestIcon" value="star-before-selection.png" />
	<c:if test="${isInterestCheck eq true }">
		<c:set var="interestIcon" value="star-after-selection.png" />
	</c:if>


	<!-- 중앙에 위치시키기 위한 div -->
	<div class="Currency_view">
		<div class="Currency_high_header">
			<div class="Currency_header" id="toggle-list">
				<img
					src="${pageContext.request.contextPath}/resources/img/gonfalon/${currencyDto.c_code}.png">
				<a><b>${currencyDto.c_country}</b> ${currencyDto.c_code}</a> <i
					class="circle"> <i class="arrow-up"></i>
				</i>
			</div>



			<div class="img">
				<img class="favorit_img"
					src="${pageContext.request.contextPath}/resources/img/${interestIcon}"
					onclick="interestAction('${isInterestCheck}','${currencyDto.c_code }');" />

				<img class="notification_img"
					src="${pageContext.request.contextPath}/resources/img/alarm.png"
					onclick="checkLoginAndTogglePopup()" />
			</div>


			<!-- 숨겨진 iframe 팝업 -->
			<div id="popup"
				style="display: none; position: fixed; top: 50%; left: 50%; width: 600px; height: 600px; border: 2px solid #ccc; background-color: white; z-index: 1000; transform: translate(-50%, -50%); overflow: hidden;">
				<div
					style="display: flex; justify-content: center; align-items: center; width: 100%; height: 100%;">
					<iframe id="popupFrame" src='/ex/user/notification' width="100%"
						height="100%" style="overflow: hidden;"></iframe>

				</div>
				<button onclick="closePopup()"
					style="position: absolute; top: 5px; right: 5px;">닫기</button>
			</div>

		</div>
		<span id="currency-list" class="hidden"> <a
			href="exFinder_Currency?c_code=USD">미국 USD</a> <a
			href="exFinder_Currency?c_code=JPY">일본 JPY</a> <a
			href="exFinder_Currency?c_code=EUR">유럽연합 EUR</a> <a
			href="exFinder_Currency?c_code=CNY">중국 CNY</a> <a
			href="exFinder_Currency?c_code=GBP">영국 GBP</a> <a
			href="exFinder_Currency?c_code=CHF">스위스 CHF</a> <a
			href="exFinder_Currency?c_code=CAD">캐나다 CAD</a> <a
			href="exFinder_Currency?c_code=INR">인도 INR</a> <a
			href="exFinder_Currency?c_code=HKD">홍콩 HKD</a> <a
			href="exFinder_Currency?c_code=EGP">이집트 EGP</a> <a
			href="exFinder_Currency?c_code=SAR">사우디 SAR</a> <a
			href="exFinder_Currency?c_code=AUD">호주 AUD</a> <a
			href="exFinder_Currency?c_code=THB">태국 THB</a> <a
			href="exFinder_Currency?c_code=RUB">러시아 RUB</a> <a
			href="exFinder_Currency?c_code=VND">베트남 VND</a> <a
			href="exFinder_Currency?c_code=ZAR">남아공 ZAR</a> <a
			href="exFinder_Currency?c_code=MXN">멕시코 MXN</a> <a
			href="exFinder_Currency?c_code=BRL">브라질 BRL</a> <a
			href="exFinder_Currency?c_code=ILS">이스라엘 ILS</a> <a
			href="exFinder_Currency?c_code=NZD">뉴질랜드 NZD</a>
		</span>
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
						<td>${exchangeRateDto.tts}</td>
					</tr>
					<tr>
						<th>파실때</th>
						<td>${exchangeRateDto.cash_sell}</td>
						<th>받을때</th>
						<td>${exchangeRateDto.ttb}</td>
					</tr>
				</table>
				<div class="base-date">기준일 : ${exchangeRateDto.rate_date}</div>
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
				<c:forEach var="news" items="${newsList}" varStatus="status">
					<c:if test="${status.index < 4}">
						<div class="news-item">
							<div class="new-header">
								<img src="${news.newsIcon}">${news.newsName} -
								${news.newsTime}
							</div>
							<div class="new-main"
								onclick="window.open('${news.newsURL}', '_blank');">
								<div class="new-main-text">
									<label>${news.newsTitle} </label><br> <a>${news.newsText}</a>
								</div>
								<c:if test="${not empty news.newsImg}">
									<img src="${news.newsImg}" alt="뉴스 이미지">
								</c:if>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>

	<h1 class="rate-day">일자별</h1>

	<hr class="divider">

	<div class="box-contents">
		<table class="exchange">
			<thead>
				<tr class="chart">
					<th rowspan="2">날짜</th>
					<th rowspan="2">매매기준율</th>
					<th colspan="2">현찰</th>
					<th colspan="2">송금(전신환)</th>
					<th rowspan="2">기준환율</th>
				</tr>
				<tr class="chartB">
					<th class="leftL">사실때</th>
					<th>파실때</th>
					<th>보내실때</th>
					<th>받으실때</th>
				</tr>
			</thead>
			<tbody id="currencyBody">
				<c:forEach var="dailyCurrency" items="${dailyCurrency}">
					<tr>
						<td class="c">${dailyCurrency.rate_date}</td>
						<td class="r">${dailyCurrency.deal_bas_r}</td>
						<td class="r">${dailyCurrency.cash_buy}</td>
						<td class="r">${dailyCurrency.cash_sell}</td>
						<td class="r">${dailyCurrency.tts}</td>
						<td class="r">${dailyCurrency.ttb}</td>
						<td class="r">${dailyCurrency.base_r}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div id="pagination">
		<button id="first" disabled>&laquo;</button>
		<button id="prev" disabled>&lt;</button>
		<span id="page-info"></span>
		<div id="page-buttons"></div>
		<!-- 페이지 버튼들이 동적으로 추가될 div -->
		<button id="next">&gt;</button>
		<button id="last">&raquo;</button>
	</div>

	<h1 class="rate-hour">시간별</h1>

	<hr class="divider">

	<div class="box-contents2">
		<p class="date-display">기준일 : ${hourCurrency[0].rate_date}</p>
		<table class="exchange">
			<thead>
				<tr class="chart">
					<th rowspan="2">시간</th>
					<th rowspan="2">매매기준율</th>
					<th colspan="2">현찰</th>
					<th colspan="2">송금(전신환)</th>
					<th rowspan="2">기준환율</th>
				</tr>
				<tr class="chartB">
					<th class="leftL">사실때</th>
					<th>파실때</th>
					<th>보내실때</th>
					<th>받으실때</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty hourCurrency}">
					<tr>

						<td colspan="7" class="no-data"><br> <br> <br>
							<br> <br>"현재 시간이 반영된 데이터가 없습니다. 잠시 후 다시 확인해 주세요."</td>


					</tr>
				</c:if>
				<c:forEach var="hourCurrency" items="${hourCurrency}">
					<tr>
						<td class="c">${hourCurrency.annoTime}</td>
						<td class="r">${hourCurrency.deal_bas_r}</td>
						<td class="r">${hourCurrency.cash_buy}</td>
						<td class="r">${hourCurrency.cash_sell}</td>
						<td class="r">${hourCurrency.tts}</td>
						<td class="r">${hourCurrency.ttb}</td>
						<td class="r">${hourCurrency.base_r}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<%@include file="/WEB-INF/views/footer/exFinder_footer.jsp"%>

</body>
</html>