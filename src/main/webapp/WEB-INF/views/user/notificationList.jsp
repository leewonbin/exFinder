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
    
<!-- Font Awesome CSS 링크 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">    

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

<script>
    function enableEdit(notificationId) {
        // 수정 필드를 보이게 하고 버튼을 숨깁니다.
        $("#target_exchange_" + notificationId).show();
        $("#edit_button_" + notificationId).hide();
        $("#current_target_exchange_" + notificationId).hide(); // 기존 숫자 숨김
    }

    function disableEdit(notificationId) {
        // 수정 필드를 숨기고 버튼을 보이게 합니다.
        $("#target_exchange_" + notificationId).hide();
        $("#edit_button_" + notificationId).show();
        $("#current_target_exchange_" + notificationId).show(); // 기존 숫자 보임
    }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
<div id="alramContainer" style="display: none;"></div>

<div id="board">
    <h1>알림내역</h1>
    
    <!-- 나의 게시글 목록 -->
    <ul id="myPosts" class="board-list">
        <li class="board-header">
            <span class="board-header-flag">국기</span>
            <span class="board-header-c_country">국가</span>
            <span class="board-header-c_money">설정금액</span>
            <span class="board-header-c_action">삭제</span>
        </li>
        <c:forEach var="notification" items="${notificationLists}">
            <li class="board-item">
                <img src="${pageContext.request.contextPath}/resources/img/gonfalon/${notification.c_code}.png" class="flag-img" />
                <span class="board-c_country">${notification.c_code}</span>
                
               <!-- 설정 금액 기본 상태 표시 및 수정 버튼 묶기 -->
                <div class="target_exchange_container">
                    <span class="current_target_exchange" id="current_target_exchange_${notification.n_id}">${notification.target_exchange}</span>
                    
                    <!-- 수정 버튼 -->
					<button id="edit_button_${notification.n_id}" class="edit_button" onclick="enableEdit(${notification.n_id})">
					    <i class="fas fa-edit"></i>
					</button>

                </div>
                
                <!-- 수정 폼 -->
                <form action="${pageContext.request.contextPath}/user/updateNotification" method="post" style="display:none;" id="target_exchange_${notification.n_id}">
                    <input type="hidden" name="n_id" value="${notification.n_id}" />
                    <input type="number" name="target_exchange" class="text_box" value="${notification.target_exchange}" required />
                    <button type="submit">
                    	<i class="fas fa-check" style="color: green;"></i>
                    </button>
                    <button type="button" onclick="disableEdit(${notification.n_id})">
                    	 <i class="fas fa-times" style="color: red;"></i>
                    </button>
                </form>
                
                <!-- 삭제 버튼 폼 -->
                <form action="${pageContext.request.contextPath}/user/deleteNotification" method="post" style="display:inline;">
                    <input type="hidden" name="n_id" value="${notification.n_id}" />
                    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');" class="delete">
                    	<i class="fas fa-trash"></i>
                    </button>
                </form>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
