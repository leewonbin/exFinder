<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
			</div>
			<div class="header_end">
				<!-- 로그인, 마이페이지 등등.. -->
				<p>로그인</p>
				/
				<p>회원가입</p>
			</div>
		</div>
	</header>
</body>
</html>