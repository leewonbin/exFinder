<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csMain.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chatBot.css">

<script src="${pageContext.request.contextPath}/resources/js/faqJs.js"></script>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
      integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
</head>
<body class="body-container">

	<div class="header-container">
		<%@include file="../header/exFinder_header.jsp"%>
		<div id="alramContainer" style="display: none;"></div>
	</div>
	<br>
	<h1 class="faq-title">FAQ</h1>
	<br>
	<p class="faq-description">궁금한 사항은 자주하는 질문을 통해 먼저 알아보세요</p>
	<br>
	<div id="qna-list" class="qna-container">
		<c:forEach var="csDto" items="${qnaList}">
			<div id="question-${csDto.cs_id}" class="question-container"
				onclick="toggleAnswer(${csDto.cs_id})">
				<span class="question-label">Q:</span> ${csDto.cs_title}
			</div>
			<div id="answer-${csDto.cs_id}" class="answer-container">
				<span class="answer-label">A:</span> ${csDto.cs_content}
				<c:if test="${isAdmin}">
					<a href="/cs/update?cs_id=${csDto.cs_id}" class="edit-button">편집</a>
				</c:if>
			</div>
		</c:forEach>
	</div>
	<button id="csButton" onclick="moveKakao()"></button>
	<%@include file="/WEB-INF/views/footer/exFinder_footer.jsp"%>

</body>
</html>
