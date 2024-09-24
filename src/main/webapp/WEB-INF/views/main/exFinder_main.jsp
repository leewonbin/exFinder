<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ExFinder</title>
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
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<!-- 헤더 Include -->
	<div class="include_header">
		<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
	</div>
	<c:if test="${sessionScope.dto ne null}">
		<script src="${pageContext.request.contextPath}/resources/js/alram.js"></script>
		<script>
			var userId = "${sessionScope.dto.u_id}"; // 로그인한 사용자 ID
			$(function() {
				console.log('$(function)에 들어옴');
				connectWs(userId); // WebSocket 연결
			});
		</script>
	</c:if>



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
					<c:choose>
						<c:when test="${empty dto }">
							<ul>
								<!-- 로그인, 마이페이지 등등.. -->
								<li><a href="/ex/user/login">로그인</a></li>
								<li><a href="/ex/user/join">회원가입</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<div class="header_end_myPage">
								<!-- 로그인, 마이페이지 등등.. -->
								<c:choose>
									<c:when test="${not empty dto.u_profile_img}">
										<img
											src="${pageContext.request.contextPath}/resources/profile_img/${dto.u_profile_img}"
											onclick="location.href='/ex/user/myPage'">
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/resources/img/Wuser.png"
											onclick="location.href='/ex/user/myPage'">
									</c:otherwise>
								</c:choose>

								<p>
									<a href="/ex/user/myPage"><c:out value="${dto.u_nickname }" />님</a>
								</p>
								<button type="button" id="toggleButton"
									onclick="toggleMiniMyPage()"></button>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

		<!-- 환율 계산기 div 영역 -->
		<div class="calculator-container">
			<!-- 기준 통화 섹션 -->
			<div class="currency-section baseSection">
				<!-- 기준 통화 SelectBox -->
				<div class="selectBoxWrap">
					<img class="baseImg" src="resources/img/gonfalon/USD.png" /> <select
						id="base-currency-select" class="base-currency-select">
						<option value="KRW" data-rate="1" data-curr="원">대한민국
							(KRW)</option>
						<c:forEach var="exchange" items="${list}">
							<c:set var="base_r" value="${exchange.base_r }" />
							<c:if
								test="${exchange.c_code eq 'JPY' || exchange.c_code eq 'VND'}">
								<c:set var="base_r" value="${base_r / 100}" />
							</c:if>
							<option value="${exchange.c_code}" data-rate="${base_r }"
								data-curr="${exchange.c_name }"
								<c:if test="${exchange.c_code eq 'USD'}">selected</c:if>>
								${exchange.c_country} (${exchange.c_code})</option>
						</c:forEach>
					</select>
				</div>

				<!-- 기준 통화 금액 입력 InputBox -->
				<input type="text" id="base-amount-input" class="base-amount-input"
					placeholder="금액 입력" value="1" />

				<!-- 기준 통화 결과 입력 InputBox -->
				<input type="text" id="base-result-input" class="base-result-input"
					placeholder="변환 결과" readonly />
			</div>

			<!-- '=' 문자 -->
			<img alt="" src="resources/img/equals.png" class="equals-sign">

			<!-- 결과 통화 섹션 -->
			<div class="currency-section resultSection">
				<!-- 결과 통화 SelectBox -->
				<div class="selectBoxWrap">
					<img class="resultImg" src="resources/img/gonfalon/KRW.png" /> <select
						id="result-currency-select" class="result-currency-select">
						<option value="KRW" data-rate="1" data-curr="원" selected>대한민국
							(KRW)</option>
						<c:forEach var="exchange" items="${list }">
							<c:set var="base_r" value="${exchange.base_r }" />
							<c:if
								test="${exchange.c_code eq 'JPY' || exchange.c_code eq 'VND'}">
								<c:set var="base_r" value="${base_r / 100}" />
							</c:if>
							<option value="${exchange.c_code}" data-rate="${base_r }"
								data-curr="${exchange.c_name }">${exchange.c_country}
								(${exchange.c_code})</option>
						</c:forEach>
					</select>
				</div>

				<!-- 결과 통화 금액 입력 InputBox -->
				<input type="text" id="result-amount-input"
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
									<a href="exFinder_Currency?c_code=USD">미국 USD</a>
									<div id="value_USD"></div>
								</div>
								<div id="chart_USD" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY.png">
									<a href="exFinder_Currency?c_code=JPY">일본 JPY</a>
									<div id="value_JPY"></div>
								</div>
								<div id="chart_JPY" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
									<a href="exFinder_Currency?c_code=EUR">유럽연합 EUR</a>
									<div id="value_EUR"></div>
								</div>
								<div id="chart_EUR" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
									<a href="exFinder_Currency?c_code=CNY">중국 CNY</a>
									<div id="value_CNY"></div>
								</div>
								<div id="chart_CNY" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
									<a href="exFinder_Currency?c_code=GBP">영국 GBP</a>
									<div id="value_GBP"></div>
								</div>
								<div id="chart_GBP" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
									<a href="exFinder_Currency?c_code=CHF">스위스 CHF</a>
									<div id="value_CHF"></div>
								</div>
								<div id="chart_CHF" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
									<a href="exFinder_Currency?c_code=CAD">캐나다 CAD</a>
									<div id="value_CAD"></div>
								</div>
								<div id="chart_CAD" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
									<a href="exFinder_Currency?c_code=INR">인도 INR</a>
									<div id="value_INR"></div>
								</div>
								<div id="chart_INR" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
									<a href="exFinder_Currency?c_code=HKD">홍콩 HKD</a>
									<div id="value_HKD"></div>
								</div>
								<div id="chart_HKD" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
									<a href="exFinder_Currency?c_code=EGP">이집트 EGP</a>
									<div id="value_EGP"></div>
								</div>
								<div id="chart_EGP" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
									<a href="exFinder_Currency?c_code=SAR">사우디 SAR</a>
									<div id="value_SAR"></div>
								</div>
								<div id="chart_SAR" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
									<a href="exFinder_Currency?c_code=AUD">호주 AUD</a>
									<div id="value_AUD"></div>
								</div>
								<div id="chart_AUD" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
									<a href="exFinder_Currency?c_code=THB">태국 THB</a>
									<div id="value_THB"></div>
								</div>
								<div id="chart_THB" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
									<a href="exFinder_Currency?c_code=RUB">러시아 RUB</a>
									<div id="value_RUB"></div>
								</div>
								<div id="chart_RUB" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
									<a href="exFinder_Currency?c_code=VND">베트남 VND</a>
									<div id="value_VND"></div>
								</div>
								<div id="chart_VND" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
									<a href="exFinder_Currency?c_code=ZAR">남아공 ZAR</a>
									<div id="value_ZAR"></div>
								</div>
								<div id="chart_ZAR" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
									<a href="exFinder_Currency?c_code=MXN">멕시코 MXN</a>
									<div id="value_MXN"></div>
								</div>
								<div id="chart_MXN" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
									<a href="exFinder_Currency?c_code=BRL">브라질 BRL</a>
									<div id="value_BRL"></div>
								</div>
								<div id="chart_BRL" class="chart_graph"></div>
							</div>
						</div>
						<div class="chart_graph_box_container">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
									<a href="exFinder_Currency?c_code=ILS">이스라엘 ILS</a>
									<div id="value_ILS"></div>
								</div>
								<div id="chart_ILS" class="chart_graph"></div>
							</div>
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
									<a href="exFinder_Currency?c_code=NZD">뉴질랜드 NZD</a>
									<div id="value_NZD"></div>
								</div>
								<div id="chart_NZD" class="chart_graph"></div>
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
			<div class="world_map_header">
				<ul>
					<li><a href="#" id="world_all">전세계</a></li>
					<li><a href="#" id="world_asia">아시아</a></li>
					<li><a href="#" id="world_america">아메리카</a></li>
					<li><a href="#" id="world_europe">유럽</a></li>
					<li><a href="#" id="world_middle_east">중동</a></li>
					<li><a href="#" id="world_oceania">오세아니아</a></li>
				</ul>
			</div>
			<div class="world_map">
				<img
					src="${pageContext.request.contextPath}/resources/img/gonfalon/world_map3.png"
					class="map-image">
				<div class="flag map_america" style="top: 175px; left: 910px;">
					<a class="flag-content" href="exFinder_Currency?c_code=USD"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
						<label>미국</label> <span id="flag_USD"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 300px; left: 485px;">
					<a class="flag-content" href="exFinder_Currency?c_code=JPY"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY.png">
						<label>일본</label> <span id="flag_JPY"></span>
					</a> <i class="line" style="top: -55px; left: 20px;"></i> <i
						class="circle" style="top: -55px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_europe" style="top: 240px; left: 20px;">
					<a class="flag-content" href="exFinder_Currency?c_code=EUR"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
						<label>유럽연합</label> <span id="flag_EUR"></span>
					</a> <i class="line" style="top: -40px; left: 80px; height: 30px;"></i>
					<i class="circle"
						style="top: -42px; left: 71px; width: 20px; height: 20px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 200px; left: 420px;">
					<a class="flag-content" href="exFinder_Currency?c_code=CNY"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
						<label>중국</label> <span id="flag_CNY"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_europe" style="top: 80px; left: 75px;">
					<a class="flag-content" href="exFinder_Currency?c_code=GBP"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
						<label>영국</label> <span id="flag_GBP"></span>
					</a> <i class="line" style="top: 19px; left: 20px; height: 75px;"></i>
					<i class="circle" style="top: 95px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_europe" style="top: 133px; left: 100px;">
					<a class="flag-content" href="exFinder_Currency?c_code=CHF"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
						<label>스위스</label> <span id="flag_CHF"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_america" style="top: 110px; left: 810px;">
					<a class="flag-content" href="exFinder_Currency?c_code=CAD"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
						<label>캐나다</label> <span id="flag_CAD"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 250px; left: 270px;">
					<a class="flag-content" href="exFinder_Currency?c_code=INR"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
						<label>인도</label> <span id="flag_INR"></span>
					</a> <i class="line" style="top: 19px; left: 40px;"></i> <i
						class="circle" style="top: 65px; left: 33px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 340px; left: 420px;">
					<a class="flag-content" href="exFinder_Currency?c_code=HKD"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
						<label>홍콩</label> <span id="flag_HKD"></span>
					</a> <i class="line" style="top: -50px; left: 10px; height: 40px;"></i>
					<i class="circle" style="top: -50px; left: 3px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_middle_east" style="top: 340px; left: 150px;">
					<a class="flag-content" href="exFinder_Currency?c_code=EGP"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
						<label>이집트</label> <span id="flag_EGP"></span>
					</a> <i class="line" style="top: -55px; left: 20px;"></i> <i
						class="circle" style="top: -55px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_middle_east" style="top: 215px; left: 200px;">
					<a class="flag-content" href="exFinder_Currency?c_code=SAR"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
						<label>사우디</label> <span id="flag_SAR"></span>
					</a> <i class="line" style="top: 19px; left: 20px; height: 60px;"></i>
					<i class="circle" style="top: 80px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_oceania" style="top: 440px; left: 510px;">
					<a class="flag-content" href="exFinder_Currency?c_code=AUD"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
						<label>호주</label> <span id="flag_AUD"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 415px; left: 355px;">
					<a class="flag-content" href="exFinder_Currency?c_code=THB"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
						<label>태국</label> <span id="flag_THB"></span>
					</a> <i class="line" style="top: -95px; left: 30px; height: 85px;"></i>
					<i class="circle" style="top: -95px; left: 23px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 70px; left: 400px;">
					<a class="flag-content" href="exFinder_Currency?c_code=RUB"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
						<label>러시아</label> <span id="flag_RUB"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_asia" style="top: 380px; left: 390px;">
					<a class="flag-content" href="exFinder_Currency?c_code=VND"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
						<label>베트남</label> <span id="flag_VND"></span>
					</a> <i class="line" style="top: -40px; left: 20px; height: 30px;"></i>
					<i class="circle" style="top: -45px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag" style="top: 430px; left: 130px;">
					<a class="flag-content" href="exFinder_Currency?c_code=ZAR"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
						<label>남아공</label> <span id="flag_ZAR"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_america" style="top: 350px; left: 930px;">
					<a class="flag-content" href="exFinder_Currency?c_code=BRL"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
						<label>브라질</label> <span id="flag_BRL"></span>
					</a> <i class="line" style="top: 19px; left: 110px;"></i> <i
						class="circle" style="top: 65px; left: 103px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_america" style="top: 230px; left: 770px;">
					<a class="flag-content" href="exFinder_Currency?c_code=MXN"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
						<label>멕시코</label> <span id="flag_MXN"></span>
					</a> <i class="line" style="top: 19px; left: 100px;"></i> <i
						class="circle" style="top: 65px; left: 93px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_middle_east" style="top: 180px; left: 169px;">
					<a class="flag-content" href="exFinder_Currency?c_code=ILS"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
						<label>이스라엘</label> <span id="flag_ILS"></span>
					</a> <i class="line" style="top: 19px; left: 20px; height: 60px;"></i>
					<i class="circle" style="top: 80px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
				<div class="flag map_oceania" style="top: 485px; left: 580px;">
					<a class="flag-content" href="exFinder_Currency?c_code=NZD"> <img
						src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
						<label>뉴질랜드</label> <span id="flag_NZD"></span>
					</a> <i class="line" style="top: 19px; left: 20px;"></i> <i
						class="circle" style="top: 65px; left: 13px;"> <i
						class="mini-circle"></i>
					</i>
				</div>
			</div>
		</div>
	</div>

	<!-- 구분선 -->
	<hr class="divider">
	<h1 class="rate-lookup">환율조회</h1>

	<div class="box-contents">
		<div>
			<p class="date-display">기준일 : ${list[0].rate_date}
				&nbsp;${list[0].annotime}</p>
			<table class="exchange">
				<thead>
					<tr class="chart">
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
					<c:forEach var="currency" items="${list}">
						<tr>
							<td class="l"><img
								src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png"
								class="flag-img" /> <a
								href="exFinder_Currency?c_code=${currency.c_code }">${currency.c_country}</a></td>
							<td class="l">${currency.c_name}</td>
							<td class="r">${currency.deal_bas_r}</td>

							<!-- 전일비 색상 설정 + 전일비 계산 -->
							<c:set var="changeClass">
								<c:choose>
									<c:when test="${resultMap[currency.c_code] > 0}">
                                         increase
                                    </c:when>
									<c:when test="${resultMap[currency.c_code] < 0}">
                                            decrease
                                        </c:when>
									<c:otherwise>
                                            no-change
                                    </c:otherwise>
								</c:choose>
							</c:set>

							<td class="r ${changeClass}"><fmt:formatNumber type="number"
									maxFractionDigits="2" value="${resultMap[currency.c_code]}" />
							</td>
							<td class="r">${currency.cash_buy}</td>
							<td class="r">${currency.cash_sell}</td>
							<td class="r">${currency.tts}</td>
							<td class="r">${currency.ttb}</td>
							<td class="r">${currency.base_r}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>



	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/calculraterJs.js"></script>

</body>
</html>
