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
	href="${pageContext.request.contextPath}/resources/css/notificationList.css">

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
	<div id="board">
        <h1>알림내역</h1>
        
        <!-- 나의 게시글 목록 -->
        <ul id="myPosts" class="board-list">
            <li class="board-header">
                <span class="board-header-n_id">번호</span>
                <span class="board-header-c_code">통화</span>
                <span class="board-header-c_target">목표금액</span>
            </li>
            <c:forEach var="notification" items="${notificationLists}">
       
                   <%--  <img src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png"
					class="flag-img" /> --%>
					<span class="n_id">${notification.n_id}</span>
					<span class="c_code">${notification.c_code}</span>
                    <span class="target_exchange">${notification.target_exchange} (${currency.c_code})</span>
				

            </c:forEach>
            
        </ul>
        
    </div>


</body>
</html>
