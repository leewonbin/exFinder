<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage.css">
</head>
<body>
<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

	<!-- 알림을 표시할 div -->
	<div id="alramContainer" style="display: none;"></div>
	
	<div id="main">
		<button type="button" class="myPage-button" onclick="location.href='/ex/user/myInfo'">
			<img src="${pageContext.request.contextPath}/resources/img/Nuser.png" id="Img">계정관리
		</button>
		<button type="button" class="myPage-button" onclick="window.location.href='/ex/user/myBoard'">
			<img src="${pageContext.request.contextPath}/resources/img/Nboard.png" id="Img">나의 게시판
		</button>
		<button type="button" class="myPage-button" onclick="window.location.href='/ex/user/notificationList'">
			<img src="${pageContext.request.contextPath}/resources/img/Nalarm.png" id="Img">알림관리
		</button>
		<button type="button" class="myPage-button" onclick="window.location.href='/ex/user/bookMark'">
			<img src="${pageContext.request.contextPath}/resources/img/Nbookmark.png" id="Img">즐겨찾기
		</button>
	</div>
<body>
</html>