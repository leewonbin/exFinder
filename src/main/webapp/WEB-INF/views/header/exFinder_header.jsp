<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="logout-status" content="${sessionScope.userId == null ? 'logged-out' : 'logged-in'}">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<style>

</style>
</head>
<body>
	<header class="header">
		<div class="header_wrapper">
			<div class="header_start">
				<ul>
					<li>홈</li>
					<li>알림</li>
					<li>게시판</li>
				</ul>
			</div>
			<div class="header_center">
				<!-- 로고 -->
					<img src="${pageContext.request.contextPath}/resources/img/logo.png"
					onclick="location.href='/ex/'">
			</div>
			
			<c:if test="${empty sessionScope.userId}">
			<div class="header_end">
				<!-- 로그인, 마이페이지 등등.. -->
				<p><a href="/ex/user/login">로그인</a></p>
				/
				<p><a href="/ex/user/join">회원가입</a></p>
			</div>
			</c:if>
			
			<c:if test="${!empty sessionScope.userId}">
			<div class="header_end_myPage">
				<!-- 로그인, 마이페이지 등등.. -->
				<img src="${pageContext.request.contextPath}/resources/img/user.png" onclick="location.href='/ex/user/myPage'">
				<p><a href="/ex/user/myPage">유저 님</a></p>
				<button type="button" id="toggleButton" onclick="toggleMiniMyPage()">▼</button>
			</div>
			</c:if>							
		</div>
	</header>
	<div class="header_mini_myPage" id="miniMyPage">
		<div class="header_mini_myPage_top">
			<img src="${pageContext.request.contextPath}/resources/img/user.png" alt="">
			<div>
				<p class="user-info"><a href="/ex/user/myPage">유저 님</a></p>
				<p class="email-info">이메일@naver.com</p>
			</div>
			<form action="${pageContext.request.contextPath}/user/logout" method="POST">
    			<input type="submit" class="mini_myPage_button" value="로그아웃" />
			</form>
		</div>
		<div class="header_mini_myPage_bottom">
			<ul>
				<li>나의 게시판</li>
				<li>알림</li>
				<li>즐겨찾기</li>
			</ul>
			<button type="button" class="mini_myPage_button" onclick="" >
				설정<img src="${pageContext.request.contextPath}/resources/img/Psetup.png">
			</button>
		</div>
	</div>
</body>
</html>