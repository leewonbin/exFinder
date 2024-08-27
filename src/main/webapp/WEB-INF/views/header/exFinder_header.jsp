<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
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
				<a href="/ex/">
					<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
				</a>
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
				<p><a href="/ex/user/myPage">
					<img src="${pageContext.request.contextPath}/resources/img/user.png" alt="" style="width: 50px; height: auto;">
				</a></p>
				<p><a href="/ex/user/myPage"> 님</a></p>
			</div>
			</c:if>
		</div>
	</header>
</body>
</html>