<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>즐겨찾기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bookMark.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bookMark.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
    
    
</head>
<body>
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
   	
   	<!-- 알림을 표시할 div -->
	<div id="alramContainer" style="display: none;"></div>
	
    <div id="board">
        <h1>즐겨찾기</h1>
        
        <!-- 나의 게시글 목록 -->
        <ul id="myPosts" class="board-list">
            <li class="board-header">
                <span class="board-header-flag">국기</span>
                <span class="board-header-c_country">국가명</span>
                <span class="board-header-c_name">통화</span>
                <span class="board-header-c_name">매매 기준율</span>
            </li>
            <c:forEach var="currency" items="${userCurrencies}">
                <li class="board-item" onclick="window.location.href='/ex/exFinder_Currency?c_code=${currency.c_code}'">
                    <img src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png"
					class="flag-img" />
					
					<span class="board-c_country">${currency.c_country}</span>
                    <span class="board-c_name">${currency.c_name} (${currency.c_code})</span>
                    <span id="value_${currency.c_code}"></span>
				</li>

            </c:forEach>
            
        </ul>
        
    </div>
</body>
</html>
