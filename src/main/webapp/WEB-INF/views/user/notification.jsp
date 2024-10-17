<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>환율 차트</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/notification.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery.min.js"></script>
<!-- google charts -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- JavaScript -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/alram_charts.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/notification.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<script>
 var imgSrc = "${pageContext.request.contextPath}/resources/img/gonfalon/";
</script>
<body>
	<div id="alert-settings">
		<h1>환율 알림 설정</h1>
		<div class="form-group">
			<label for="currency">통화 선택 (원화 기준)</label> <select id="currency"
				name="currency" required>
			</select>
		</div>
		<div class="charts_view">
			<div class="charts_container"></div>
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
			<button type="button" onclick="submitNotification()" class="submit-btn">알림 설정</button>
		</div>

	</div>


</body>
</html>
