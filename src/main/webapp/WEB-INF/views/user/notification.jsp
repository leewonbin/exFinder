<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>환율 차트</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/notification.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery.min.js"></script>
<!-- google charts -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- JavaScript -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/charts2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/notification.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<div id="alert-settings">
		<h1>환율 알림 설정</h1>
		<form action="/setExchangeAlert" method="post">
			<div class="form-group">
				<label for="currency">통화 선택 (원화 기준)</label> 
				<select id="currency" name="currency" required>
					<option value="">-- 통화를 선택하세요 --</option>
					<c:forEach var="curr" items="${list }">
						<option value="${curr.c_code }">${curr.c_country } ${curr.c_name } (${curr.c_code })</option>
					</c:forEach>
					<!-- 다른 통화 추가 -->
				</select>
			</div>
			<div class="charts_view">
				<div class="charts_container">
					<c:forEach var="curr" items="${list }">
						<!-- 각 통화의 그래프와 정보 표시 -->
						<div class="chart_graph_box_container" id="${curr.c_code }-chart"
							style="display: none;">
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/${curr.c_code }.png">
									${curr.c_country } ${curr.c_code }
									<div id="value_${curr.c_code} "></div>
								</div>
								<div id="chart_${curr.c_code}" class="chart_graph"></div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>

			<!-- 목표 환율 입력 -->
			<div class="form-group">
				<label for="targetRate">목표 환율 (원화 기준)</label> <input type="text"
					id="targetRate" name="targetRate" placeholder="예: 1100.00" required
					oninput="calculateTolerance()">
			</div>

			<!-- 오차 범위 (%) 정보 -->
			<div class="form-group">
				<p id="toleranceInfo" style="color: green;"></p>
			</div>

			<!-- 전화번호 수신동의 -->
			<div class="checkbox-phone">
				<input type="checkbox" value="">전화번호로 알림을 수신하는 데 동의합니다.
			</div>

			<!-- 제출 버튼 -->
			<div class="form-group">
				<button type="submit" class="submit-btn">알림 설정</button>
			</div>

		</form>
	</div>


</body>
</html>
