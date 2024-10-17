<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ExFinder</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico"
	type="image/x-icon">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/exFinder_main.css">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico"
	type="image/x-icon">
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
						<li class="alram" onclick="toggleAlram()">알림</li>
						<li onclick="location.href='/ex/board/listAll'">게시판</li>
						<sec:authorize access="hasAnyRole('ADMIN')">
							<li onclick="location.href='/ex/admin/admin'">관리자</li>
						</sec:authorize>
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
											src="${pageContext.request.contextPath}/../exFinder_server/profile_img/${dto.u_profile_img}"
											onerror="this.src='${pageContext.request.contextPath}/resources/img/Wuser.png';"
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
								<button type="button" id="toggleButton2"
									onclick="toggleMiniMyPage()"></button>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>
		<div id="mini_myPage_view">
			<%@include file="/WEB-INF/views/header/exFinder_mini_myPage.jsp"%>
		</div>

		<!-- 환율 계산기 div 영역 -->
		<div class="calculator-container">
			<%@include file="/WEB-INF/views/main/calculrator.jsp"%>
		</div>

		<!-- 사용자 맞춤 정보 팝업 창 -->
		<c:if test="${not empty frequentCurrencies}">
			<div id="popup" class="popup" style="display: none;">
				<div class="popup-content">
					<span class="close" onclick="closePopup()">X 닫기</span><br>
					<div class="popup-body">
						<c:if test="${not empty userId}">
							<br>
							<h3 style="font-weight: bold;">자주 조회한 통화</h3>
							<br>
							<ul>
								<c:set var="count" value="0" />
								<c:forEach var="currency" items="${frequentCurrencies}"
									varStatus="status">
									<c:if test="${count < 5}">
										<li><img
											src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png"
											class="flag-img" /> ${currency.c_code} <i
											id="often_${currency.c_code}"></i></li>
										<c:set var="count" value="${count + 1}" />
									</c:if>
								</c:forEach>
							</ul>
							<br>
							<br>

							<h3 style="font-weight: bold;">판매하기 좋은 통화</h3>
							<br>
							<ul>
								<c:set var="buyCount" value="0" />
								<c:forEach var="currency" items="${frequentCurrencies}"
									varStatus="status">
									<c:if test="${resultMap[currency.c_code] > 0 && buyCount < 2}">
										<li><img
											src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png"
											class="flag-img" /> ${currency.c_code} <i
											id="sale_${currency.c_code}"></i></li>
										<c:set var="buyCount" value="${buyCount + 1}" />
									</c:if>
								</c:forEach>
							</ul>
							<br>
							<br>

							<h3 style="font-weight: bold;">구매하기 좋은 통화</h3>
							<br>
							<ul>
								<c:set var="sellCount" value="0" />
								<c:forEach var="currency" items="${frequentCurrencies}"
									varStatus="status">
									<c:if test="${resultMap[currency.c_code] < 0 && sellCount < 2}">
										<li><img
											src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png"
											class="flag-img" /> ${currency.c_code} <i
											id="purchase_${currency.c_code}"></i></li>
										<c:set var="sellCount" value="${sellCount + 1}" />
									</c:if>
								</c:forEach>
							</ul>
						</c:if>
					</div>
				</div>
			</div>
		</c:if>

		</div>
		
		<!-- 맵 팝업창 HTML -->
		<div id="mapPopup" class="mapPopup" style="display:none;">
		    <div class="mapPopup-content">
		        <span class="mapClose" onclick="closeMapPopup()">&times;</span>
		        <p>지도 위치를 이동합니다!</p>
		        <button onclick="moveMap()">이동하기</button> <!-- 지도 이동 버튼 -->
		    </div>
		</div>
		
		<script>
			function openMapPopup() {
			    document.getElementById("mapPopup").style.display = "flex"; // 팝업 열기
			}
			
			function closeMapPopup() {
			    document.getElementById("mapPopup").style.display = "none"; // 팝업 닫기
			}
			
			function moveMap() {
			    // 지도 이동 기능을 구현
			    alert('지도 위치를 이동합니다!');
			    closeMapPopup(); // 팝업 닫기
			}
		</script>

		<!-- 알림을 표시할 div -->
		<div id="alramContainer" style="display: none;"></div>


		<!-- 국가별 차트 p 태그 -->
		<p class="country-chart">국가별 차트</p>

		<!-- 구분선 -->
		<hr class="divider">

		<!-- 중앙에 위치시키기 위한 div -->
		<div class="charts_view">
			<%@include file="/WEB-INF/views/main/chartsSlideValue.jsp"%>
		</div>

		<!-- 국가별 차트 p 태그 -->
		<p class="country-chart">세계 환율 변동률</p>

		<!-- 구분선 -->
		<hr class="divider">

		<div class="world_map_view">
			<%@include file="/WEB-INF/views/main/worldMapValue.jsp"%>
		</div>


		<h1 class="rate-lookup">환율조회</h1>
		<!-- 구분선 -->
		<hr class="divider">

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
									class="flag-img"
									onclick="location.href='exFinder_Currency?c_code=${currency.c_code }'" /><a
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

								<td class="r ${changeClass}"><fmt:formatNumber
										type="number" maxFractionDigits="2"
										value="${resultMap[currency.c_code]}" /></td>
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
		<button id="topButton" onclick="scrollToTop()">▲</button>
		<button id="csButton" onclick="csMove()"></button>
		<button id="mapButton" onclick="mapMove()"></button>

	</div>

	<%@include file="/WEB-INF/views/footer/exFinder_footer.jsp"%>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/calculraterJs.js"></script>






	<!-- <div id="popup" class="popup" style="display: none;">
		<div class="popup-content">
			<span class="close" onclick="closePopup()">&times;</span>
		</div>
	</div>
 -->
	<script>
		window.onload = function() {
			const showPopup = '${param.popup}'; // 파라미터로 팝업 표시 여부 결정
			if (showPopup) {
				document.getElementById('popup').style.display = 'flex'; // 팝업을 표시
			}
		};

		function closePopup() {
			document.getElementById('popup').style.display = 'none'; // 팝업 닫기
		}
	</script>

</body>
</html>
