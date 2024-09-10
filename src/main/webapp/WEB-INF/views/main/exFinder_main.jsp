<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>웹페이지</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/exFinder_main.css">
<script
	src="${pageContext.request.contextPath}/resources/js/mainScrollJs.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/charts.css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery.min.js"></script>
<!-- google charts -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 슬라이드 효과를 위한 JavaScript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/charts.js"></script>
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
					<img
						src="${pageContext.request.contextPath }/resources/img/newLogo.png" />
					<ul>
						<li onclick="location.href='/ex/'">홈</li>
						<li>알림</li>
						<li onclick="location.href='/ex/board/listAll'">게시판</li>
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
		<!-- 중앙에 위치시키기 위한 div -->
		<div class="charts_view">
			<div class="Cover-box1"></div>
			<div class="charts_container">
				<div class="slide-controls">
					<div class="Cover-button-box">
						<button id="prev-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/arrow.png"
								class="slide-controls-img" style="transform: scaleX(-1);">
						</button>
					</div>
					<div class="chart_graph_box_slide" id="slide-container">
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
									<a>미국 USD</a>
									<div id="value"></div>
								</div>
								<div id="chart_div" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY2.png">
									<a>일본 JPY</a>
									<div id="value2"></div>
								</div>
								<div id="chart_div2" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
									<a>유럽연합 EUR</a>
									<div id="value3"></div>
								</div>
								<div id="chart_div3" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
									<a>중국 CNY</a>
									<div id="value4"></div>
								</div>
								<div id="chart_div4" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
									<a>영국 GBP</a>
									<div id="value5"></div>
								</div>
								<div id="chart_div5" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
									<a>스위스 CHF</a>
									<div id="value6"></div>
								</div>
								<div id="chart_div6" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
									<a>캐나다 CAD</a>
									<div id="value7"></div>
								</div>
								<div id="chart_div7" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
									<a>인도 INR</a>
									<div id="value8"></div>
								</div>
								<div id="chart_div8" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
									<a>홍콩 HKD</a>
									<div id="value9"></div>
								</div>
								<div id="chart_div9" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
									<a>이집트 EGP</a>
									<div id="value10"></div>
								</div>
								<div id="chart_div10" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
									<a>사우디 SAR</a>
									<div id="value11"></div>
								</div>
								<div id="chart_div11" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
									<a>호주 AUD</a>
									<div id="value12"></div>
								</div>
								<div id="chart_div12" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
									<a>태국 THB</a>
									<div id="value13"></div>
								</div>
								<div id="chart_div13" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
									<a>러시아 RUB</a>
									<div id="value14"></div>
								</div>
								<div id="chart_div14" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
									<a>베트남 VND</a>
									<div id="value15"></div>
								</div>
								<div id="chart_div15" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
									<a>남아공 ZAR</a>
									<div id="value16"></div>
								</div>
								<div id="chart_div16" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
									<a>멕시코 MXN</a>
									<div id="value17"></div>
								</div>
								<div id="chart_div17" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
									<a>브라질 BRL</a>
									<div id="value18"></div>
								</div>
								<div id="chart_div18" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
									<a>이스라엘 ILS</a>
									<div id="value19"></div>
								</div>
								<div id="chart_div19" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
									<a>뉴질랜드 NZD</a>
									<div id="value20"></div>
								</div>
								<div id="chart_div20" class="chart_graph"></div>
							</div>
						</div>
					</div>
					<div class="Cover-button-box">
						<button id="next-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/arrow.png"
								class="slide-controls-img">
						</button>
					</div>
				</div>
				<span id="slide-indicator">1 / 10</span>
			</div>
			<div class="Cover-box2"></div>
		</div>

		<!-- 국가별 차트 p 태그 -->
		<p class="country-chart">오늘의 세계 증시</p>

		<!-- 구분선 -->
		<hr class="divider">

		<div class="world_map_view">
			<div class="world_map">
				<img
					src="${pageContext.request.contextPath}/resources/img/gonfalon/world_map.png">
			</div>
		</div>
	</div>

	<h1>환율조회</h1>

	<div class="box-contents">
		<div>
			<table class="exchange">
				<thead>
					<tr class="chart">
						<th rowspan="2">일자</th>
						<th rowspan="2">국가명</th>
						<th rowspan="2">통화</th>
						<th rowspan="2">매매기준율</th>
						<th rowspan="2">전일비</th>
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
					<c:set var="beforeValue" />
					<c:forEach var="currency" items="${list}">
						<tr>
							<td>${currency.rate_date}</td>
							<td>${currency.c_country}</td>
							<td>${currency.c_name}</td>
							<td>${currency.deal_bas_r}</td>
							<td>${currency.base_r - beforeValue }</td>
							<td>${currency.cash_buy}</td>
							<td>${currency.cash_sell}</td>
							<td>${currency.ttb}</td>
							<td>${currency.tts}</td>
							<td>${currency.base_r}</td>
						</tr>
						<c:set var="beforeValue" value="${currency.base_r }" />
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/calculraterJs.js"></script>
</body>
</html>
