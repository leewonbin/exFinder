<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExFinder</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csMain.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chatbot.css">

<script>
let lastId = null;

function toggleAnswer(id) {
    var currentA = document.getElementById('answer-' + id);
    
    if (lastId !== null && lastId !== id) {
        var lastA = document.getElementById('answer-' + lastId);
        lastA.style.display = 'none';
        var lastQ = document.getElementById('question-' + lastId);
        lastQ.classList.remove('question-active');
    }
    
    if (currentA.style.display === 'none' || currentA.style.display === '') {
        currentA.style.display = 'block';
        var currentQ = document.getElementById('question-' + id);
        currentQ.classList.add('question-active');
    } else {
        currentA.style.display = 'none';
        var currentQ = document.getElementById('question-' + id);
        currentQ.classList.remove('question-active');
    }
    
    lastId = (currentA.style.display === 'block') ? id : null;
}
	
function toggleChatbot() {
    var chatbot = document.getElementById('chatbot');
    chatbot.style.display = (chatbot.style.display === 'none' || chatbot.style.display === '') ? 'block' : 'none';
}
</script>
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
			<div id="question-${csDto.cs_id}" class="question-container" onclick="toggleAnswer(${csDto.cs_id})">
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
</body>
</html>
