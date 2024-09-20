<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>즐겨찾기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myBoard.css">
    <script>
    </script>
    
</head>
<body>
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
   
    <div id="board">
        <h1>즐겨찾기</h1>
        
        <ul class="board-list">
            <li class="board-typeItem" onclick="showSection('myPosts',this)">
                <span class="board-type">작성글</span>
            </li>
            <!-- <li class="board-typeItem" onclick="showSection('myComments',this)">
                <span class="board-type">작성댓글</span>
            </li> -->
        </ul>
        
        <!-- 나의 게시글 목록 -->
        <ul id="myPosts" class="board-list">
            <li class="board-header">
                <span class="board-header-kategorie">국가명</span>
                <span class="board-header-title">통화</span>
                <span class="board-header-date">매매기준율</span>
            </li>
            <c:forEach var="post" items="${userPosts}">
                <li class="board-item" onclick="window.location.href='/ex/board/read?b_id=${post.b_id}'">
                    <span class="board-kategorie">${post.b_category}</span>
                    <span class="board-title">${post.b_title}</span>
                    <span class="board-date">
        				<fmt:formatDate value="${post.b_date}" pattern="yyyy-MM-dd"/>
    				</span>
                    
                </li>
            </c:forEach>
            <ul class="button-container">
                <li class="button-write" onclick="window.location.href='/ex/board/create'">
                    <span>글쓰기</span>
                </li>
        	</ul>
        </ul>
        
       
    </div>
</body>
</html>
