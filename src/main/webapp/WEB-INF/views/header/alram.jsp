<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headerAlram.css">
<script src="${pageContext.request.contextPath}/resources/js/headerAlram.js"></script>
</head>
<body>
	<div class="header_mini_alarmPage">
		<div class="header_mini_alarmPage_top">
			<p>알림</p>
		</div>
		<c:choose>
			<c:when test="${not empty dto}">
			<div class="header_mini_alarmPage_bottom">
				<div class="alarm_message">
					<div class="alarm_message_title">	
						<div class="alarm_message_title_nation">미국 -</div>
						<div class="alarm_message_title_time">3분전</div>
						<button type="button" class="alarm_message_button">x</button>
					</div>
					<div class="alarm_message_contents">
						<img class="alarm_message_img" src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
						<div class="alarm_message_text">
						통화 USD가 1350에 도달했습니다.
						</div>
					</div>
				</div>
				<div class="alarm_message">
					<div class="alarm_message_title">	
						<div class="alarm_message_title_nation">유럽연합 -</div>
						<div class="alarm_message_title_time">20분전</div>
						<button type="button" class="alarm_message_button">x</button>
					</div>
					<div class="alarm_message_contents">
						<img class="alarm_message_img" src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
						<div class="alarm_message_text">
						통화 EUR가 1470에 도달했습니다.
						</div>
					</div>
				</div>
				<div class="alarm_message">
					<div class="alarm_message_title">	
						<div class="alarm_message_title_nation">사우디아라비아 -</div>
						<div class="alarm_message_title_time">1시간 30분전</div>
						<button type="button" class="alarm_message_button">x</button>
					</div>
					<div class="alarm_message_contents">
						<img class="alarm_message_img" src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
						<div class="alarm_message_text">
						통화 SAR가 355에 도달했습니다.
						</div>
					</div>
				</div>
			</div>
			</c:when>
			<c:otherwise>
				<div class="header_mini_alarmPage_bottom2">
					<p><a href="/ex/user/login">로그인이 되어 있지 않습니다.</a></p>
					<p><a href="/ex/user/login">로그인을 해주세요.</a></p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>