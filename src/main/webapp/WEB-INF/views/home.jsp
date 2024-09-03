<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	
	<h1>Hello world!</h1>
	<P>The time on the server is ${serverTime}.test</P>
	<img src="${pageContext.request.contextPath}/resources/profile_img/${login.u_profile_img}" style="max-width: 50%; height: auto;">
	<br />
	<div class="card">
		<form action="/ex/user/myInfo/updateImg" method="post" enctype="multipart/form-data">
			<input type="file" name="file"> 
			<input type="hidden" name="memberId" id="memberId" value="${login.u_id}">
			<button type="submit" class="btn btn-primary">사진변경</button>
		</form>
	</div>
	
		<a href="/board/mypageView?select=log&u_id=${dto.u_id}" style="color: black">
			<img src="${pageContext.request.contextPath}/resources/profile_img/${dto.u_profile_img}" style=" max-width: 25px;  height: 25px;"> 
		<c:out value="${dto.u_nickname}" /> </a>
</body>
</html>
