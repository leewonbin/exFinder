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
    <script>
    function showSection(sectionId, clickedElement) {
        // 모든 섹션 숨기기
        document.getElementById('myPosts').style.display = 'none';
        document.getElementById('myComments').style.display = 'none';
        document.getElementById('myLiked').style.display = 'none';
        
        // 모든 탭 비활성화
        var tabs = document.querySelectorAll('.board-typeItem');
        tabs.forEach(function(tab) {
            tab.classList.remove('active');
        });

        // 선택된 섹션 보이기
        document.getElementById(sectionId).style.display = 'block';
        
        // 클릭된 탭 활성화
        clickedElement.classList.add('active');
    }
	    window.onload = function() {
	        // 기본적으로 '작성글' 섹션을 보이게 하고 해당 탭을 활성화
	        var defaultTab = document.querySelector('.board-typeItem');
	        showSection('myPosts', defaultTab);
	    }

    </script>
</head>
<body>
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
   
    <div id="board">
        <h1>나의 게시판</h1>
        
        <ul class="board-list">
            <li class="board-typeItem" onclick="showSection('myPosts',this)">
                <span class="board-type">작성글</span>
            </li>
            <li class="board-typeItem" onclick="showSection('myComments',this)">
                <span class="board-type">작성댓글</span>
            </li>
            <li class="board-typeItem" onclick="showSection('myLiked',this)">
                <span class="board-type">좋아요한 글</span>
            </li>
        </ul>
        
        <!-- 나의 게시글 목록 -->
        <ul id="myPosts" class="board-list">
            <li class="board-item" onclick="window.location.href='/ex/board/'">
                <span class="board-title">게시글 제목 1</span>
                <span class="board-date">2024-08-27</span>
            </li>
            <li class="board-item" onclick="window.location.href='/ex/board/'">
                <span class="board-title">게시글 제목 2</span>
                <span class="board-date">2024-08-26</span>
            </li>
            <li class="board-item" onclick="window.location.href='/ex/board/'">
                <span class="board-title">게시글 제목 2</span>
                <span class="board-date">2024-08-26</span>
            </li>
            <li class="board-item" onclick="window.location.href='/ex/board/'">
                <span class="board-title">게시글 제목 2</span>
                <span class="board-date">2024-08-26</span>
            </li>
            
	        <ul class="button-container">
			    <li class="board-write" onclick="window.location.href='/ex/board/'">
			        <span>글쓰기</span>
			   	</li>
			    <li class="board-delete" onclick="window.location.href='/ex/board/'">
			        <span>삭제</span>
			    </li>
			</ul>

            <!-- 추가 게시글 목록 -->
        </ul>
        
        <!-- 나의 댓글 목록 -->
        <ul id="myComments" class="board-list" style="display: none;">
            <li class="board-item" onclick="window.location.href='/ex/comment/'">
                <span class="board-title">댓글 내용 1</span>
                <span class="board-date">2024-08-27</span>
            </li>
            <li class="board-item" onclick="window.location.href='/ex/comment/'">
                <span class="board-title">댓글 내용 2</span>
                <span class="board-date">2024-08-26</span>
            </li>
            <ul class="button-container">
			    <li class="board-delete" onclick="window.location.href='/ex/board/'">
			        <span>삭제</span>
			   	</li>   
			</ul>

        </ul>
        
        <!-- 나의 좋아요한 글 목록 -->
        <ul id="myLiked" class="board-list" style="display: none;">
            <li class="board-item" onclick="window.location.href='/ex/comment/'">
                <span class="board-title">좋아요한 글1</span>
                <span class="board-date">2024-08-27</span>
            </li>
            <li class="board-item" onclick="window.location.href='/ex/comment/'">
                <span class="board-title">좋아요한 글2</span>
                <span class="board-date">2024-08-26</span>
            </li>
            <ul class="button-container">
			    <li class="board-delete" onclick="window.location.href='/ex/board/'">
			        <span>좋아요 취소</span>
			   	</li>   
			</ul>
        </ul>
    </div>
</body>
</html>
