<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headerAlram.css">
	<script src="https://code.jquery.com/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/headerAlram.js"></script>
</head>
<body>
	<div class="header_mini_alarmPage">
		<div class="header_mini_alarmPage_top">
			<p>알림</p>
			<c:if test="${not empty dto}">
				<a href="#" class="clear-all-link" onclick="clearAllAlarms()">모두 삭제</a>
			</c:if>
		</div>
		<c:choose>
			<c:when test="${not empty dto}">
				<div class="header_mini_alarmPage_bottom">
					<c:forEach var="alram" items="${alramList}">
						<div class="alarm_message">
							<div class="alarm_message_title">
							<c:if test="${alram.checked eq 'X' }">
								<span class="red-dot"></span> <!-- 빨간 점 추가 -->
							</c:if>
								<div class="alarm_message_title_nation">${alram.c_code} -</div>
								<div class="alarm_message_title_time">${alram.create_date}</div>
								<button type="button" class="alarm_message_button" onclick="alramDelete(${alram.a_id},this);">x</button>
							</div>
							<div class="alarm_message_contents">
								<img class="alarm_message_img"
									src="${pageContext.request.contextPath}/resources/img/gonfalon/${alram.c_code }.png">
								<div class="alarm_message_text">${alram.c_code}가 ${alram.deal_bas_r }원에 도달했습니다.</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<div class="header_mini_alarmPage_bottom2">
					<p>
						<a href="/ex/user/login">로그인이 되어 있지 않습니다.</a>
					</p>
					<p>
						<a href="/ex/user/login">로그인을 해주세요.</a>
					</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>