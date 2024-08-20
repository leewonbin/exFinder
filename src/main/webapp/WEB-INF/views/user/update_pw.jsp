<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
	<div id="header">
		<a id="header-a" href="/ex/">Home</a>
	</div>
	<div id="main">
		<div id="left_main">
			<button type="button" class="button" onclick="location.href='/ex/user/index'">마이 페이지</button><br>
			<button type="button" class="button" onclick="location.href='/ex/user/update_pw'">회원정보 수정 </button><br>
			<button type="button" class="button" onclick="location.href='/ex/shop/order_history'">주문 내역</button><br>
		</div>
		<div id="right_main">
			<h1>회원 정보 수정, 본인 확인</h1><br>
			비밀번호를 입력하시오.<br>
			<form action="/ex/user/update_Check" method="get">
				<input type="password" class="input" name="pw_Check" > <br>
				<input type="submit" class="button" value="확인"><br>
			</form>
		</div>
				

	</div>
	
</body>
</html>