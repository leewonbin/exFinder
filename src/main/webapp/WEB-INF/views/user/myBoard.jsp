<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 게시판</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myBoard.css">
</head>
<body>
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
   
    <div id="board">
     <h1>나의 게시판</h1>
        
        <ul class="board-list">
            <li class="board-item" onclick="window.location.href='/ex/board/view/1'">
                <span class="board-title">게시글 제목 1</span>
                <span class="board-date">2024-08-27</span>
            </li>
            <li class="board-item" onclick="window.location.href='/ex/board/view/2'">
                <span class="board-title">게시글 제목 2</span>
                <span class="board-date">2024-08-26</span>
            </li>
            <!-- 추가 게시글 목록 -->
        </ul>
    </div>
</body>
</html>
