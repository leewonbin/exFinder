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
<!-- 챗봇 연습용으로 넣어둔거 -->



<script>
let lastId = null;

function toggleAnswer(id) {
    // 현재 클릭한 질문의 답변 요소 찾기
    var currentA = document.getElementById('answer-' + id);
    
    // 이전에 열려 있던 답변이 있다면, 그것을 닫기
    if (lastId !== null && lastId !== id) {
        var lastA = document.getElementById('answer-' + lastId);
        lastA.style.display = 'none';
        
        // 이전 질문의 스타일에서 'active' 클래스 제거
        var lastQ = document.getElementById('question-' + lastId);
        lastQ.classList.remove('active');
    }
    
    // 현재 클릭한 질문의 답변을 열기
    if (currentA.style.display === 'none' || currentA.style.display === '') {
        currentA.style.display = 'block';
        // 현재 질문의 스타일에 'active' 클래스 추가
        var currentQ = document.getElementById('question-' + id);
        currentQ.classList.add('active');
    } else {
        currentA.style.display = 'none';
        // 현재 질문의 스타일에서 'active' 클래스 제거
        var currentQ = document.getElementById('question-' + id);
        currentQ.classList.remove('active');
    }
    
    // 현재 질문의 ID를 lastId에 저장
    lastId = (currentA.style.display === 'block') ? id : null;
}
	
	
	//챗봇 연습용임-------------------------------------------------------
	function toggleChatbot() {
        var chatbot = document.getElementById('chatbot');
        if (chatbot.style.display === 'none' || chatbot.style.display === '') {
            chatbot.style.display = 'block';
        } else {
            chatbot.style.display = 'none';
        }
    }
</script>
</head>
<body>

	<div>
		<%@include file="../header/exFinder_header.jsp"%>
	</div>
	<br>
	<h1>FAQ</h1>
	<br>
	<br>
	<p>궁금한 사항은 자주하는 질문을 통해 먼저 알아보세요</p>
	<br>
	<br>
	<br>
	<div id="qna-list">
		<c:forEach var="csDto" items="${qnaList}">
			<div id="question-${csDto.cs_id}" class="question"
				onclick="toggleAnswer(${csDto.cs_id})">
				<span>Q:</span> ${csDto.cs_title}
			</div>
			
			<div id="answer-${csDto.cs_id}" class="answer">
				<span>A:</span> ${csDto.cs_content}
				
				<!-- 관리자만 편집 버튼을 볼 수 있음. 예시 코드임 -->
				<c:if test="${isAdmin}">
					<a href="/cs/update?cs_id=${csDto.cs_id}" class="edit-button">편집</a>
				</c:if>
			</div>
		</c:forEach>
	</div>

	<%-- <!-- 챗봇 연습용으로 넣어둠 / 챗봇 버튼 -->
	<div id="chatbot-button" onclick="toggleChatbot()">
		<img
			src="${pageContext.request.contextPath}/resources/images/chatbot-icon.png"
			alt="챗봇">
	</div>

	<!-- 챗봇 창 -->
	<div id="chatbot" style="display: none;">
		<!-- 챗봇 내용 여기에 추가 -->
		<iframe src="챗봇 URL"
			style="width: 300px; height: 400px; border: none;"></iframe>
	</div>
 --%>
	

</body>
</html>