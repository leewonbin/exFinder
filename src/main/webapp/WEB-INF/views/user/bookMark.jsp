<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>즐겨찾기</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
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
                <span>
                	<input type="checkbox"   id="selectAll" onclick="selectAllCheckboxes(this.checked)"> <!-- 전체 선택 체크박스 -->
                </span>
                <span style="width:40px" class="board-header-flag">국기</span>
                <span style="width:100px" class="board-header-c_country">국가명</span>
                <span style="width:100px" class="board-header-c_name">통화</span>
                <span style="width:180px" class="board-header-c_name">매매 기준율</span>
            </li>
            <c:forEach var="currency" items="${userCurrencies}">
                <li class="board-item" data-c_code="${currency.c_code}">
                    <input style="width:20px" type="checkbox" class="select-currency" value="${currency.c_code}" name="check"/>
                    <span style="width:50px" class="board-c_flag">
                    	<img src="${pageContext.request.contextPath}/resources/img/gonfalon/${currency.c_code}.png" class="flag-img" />
                    </span>
                    <span style="width:80px"class="board-c_country" 
                    onclick="window.location.href='/ex/exFinder_Currency?c_code=${currency.c_code}'">
                    	${currency.c_country}
                    </span>
                    <span style="width:95px"class="board-c_name">${currency.c_name} (${currency.c_code})</span>
                    <span style="width:180px"id="value_${currency.c_code}"></span>
                </li>
            </c:forEach>
            
        </ul>
         <!-- 선택 삭제 버튼 -->
        <button id="deleteSelected" onclick="deleteSelectedBookmarks()">삭제</button>
    </div>

        <script>
        function selectAllCheckboxes(checked) {
            // 체크박스 선택 상태에 따라 모든 체크박스 상태 변경
            const checkboxes = document.querySelectorAll('input[name="check"]');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = checked;
            });
        }
    </script>

</body>
</html>
