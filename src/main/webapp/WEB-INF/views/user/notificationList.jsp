<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알림내역</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bookMark.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery.min.js"></script>
<!-- google charts -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- JavaScript -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/charts2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/notificationList.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<script>
 var imgSrc = "${pageContext.request.contextPath}/resources/img/gonfalon/";
</script>
<body>
<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
   	
	<div id="board">
        <h1>알림내역</h1>
        
        <!-- 나의 게시글 목록 -->
        <ul id="myPosts" class="board-list">
		    <li class="board-header">
		        <span class="board-header-flag">번호</span>
		        <span class="board-header-c_country">통화</span>
		        <span class="board-header-c_name">설정금액</span>
		        <span class="board-header-action">동작</span>
		    </li>
		    <c:forEach var="notification" items="${notificationLists}">
		        <li class="board-item">
		            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/${notification.c_code}.png" class="flag-img" />
		            <span class="n_id">${notification.n_id}</span>
		            <span class="board-c_country">${notification.c_code}</span>
		            <span class="board-c_name">${notification.target_exchange}</span>
		            <form action="${pageContext.request.contextPath}/user/deleteNotification" method="post" style="display:inline;">
		                <input type="hidden" name="n_id" value="${notification.n_id}" />
		                <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
		            </form>
		        </li>
		    </c:forEach>
		</ul>
        
    </div>


</body>
</html>
