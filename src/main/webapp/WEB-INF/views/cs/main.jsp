<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 메인 페이지임</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csMain.css">
	

<script>
	function toggleAnswer(id) {
    	var answer = document.getElementById('answer-' + id);
    	if (answer.style.display === 'none' || answer.style.display === '') {
        	answer.style.display = 'block';
    	} else {
        	answer.style.display = 'none';
    	}
	}
</script>
</head>
<body>

	<div>
		<%@include file="../header/exFinder_header.jsp"%>
	</div>

	<div class="faq">
    <h1>FAQ</h1><br><br>
	<p>궁금한 사항은 자주하는 질문을 통해 먼저 알아보세요</p>
	</div>

    <div id="qna-list">
        <c:forEach var="csDto" items="${qnaList}">
            <div class="question" onclick="toggleAnswer(${csDto.cs_id})">
                <strong>Q:</strong> ${csDto.cs_title}
            </div>
            <div id="answer-${csDto.cs_id}" class="answer">
                <strong>A:</strong> ${csDto.cs_content}
                <!-- 관리자만 편집 버튼을 볼 수 있음. 예시 코드임 -->
                <c:if test="${isAdmin}">
                    <a href="/cs/update?cs_id=${csDto.cs_id}" class="edit-button">편집</a>
                </c:if>
            </div>
        </c:forEach>
    </div>
</body>
</html>