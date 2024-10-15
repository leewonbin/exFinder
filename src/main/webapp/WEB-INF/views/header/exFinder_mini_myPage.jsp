<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
	
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
</head>
<body>
	<c:set value="${sessionScope.dto }" var="dto" />
	
	<div class="header_mini_myPage miniMyPage">
		<div class="header_mini_myPage_top">
			<c:choose>
				<c:when test="${not empty dto.u_profile_img}">
					<img
						src="${pageContext.request.contextPath}/../exFinder_server/profile_img/${dto.u_profile_img}"
						onerror="this.src='${pageContext.request.contextPath}/resources/img/user.png';"
						onclick="location.href='/ex/user/myPage'">
				</c:when>
				<c:otherwise>
					<img
						src="${pageContext.request.contextPath}/resources/img/user.png"
						onclick="location.href='/ex/user/myPage'">
				</c:otherwise>
			</c:choose>
			<div>
				<p class="user-info">
					<a href="/ex/user/myPage"><c:out value="${dto.u_nickname }" />님</a>
				</p>
				<p class="email-info">
					<c:out value="${dto.u_email }" />
				</p>
			</div>
			<form action="${pageContext.request.contextPath}/user/logout"
				method="GET">
				<input type="submit" class="mini_myPage_button" value="로그아웃" />
			</form>
		</div>
		<div class="header_mini_myPage_bottom">
			<ul>
				<li><a href="/ex/user/myBoard">나의 게시판</a></li>
				<li><a href="/ex/user/notificationList">알림</a></li>
				<li><a href="/ex/user/bookMark">즐겨찾기</a></li>
			</ul>

			<button type="button" class="mini_myPage_button" onclick="location.href='/ex/user/myInfo'" >
				설정<img src="${pageContext.request.contextPath}/resources/img/Nsetup1.png">
			</button>
		</div>
	</div>
</body>
</html>