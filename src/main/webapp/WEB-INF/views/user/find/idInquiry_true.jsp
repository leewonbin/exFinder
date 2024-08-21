<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 조회 결과</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	
</head>
<body>
	<div id="header">
		<a id="header-a" href="/ex/">Home</a>
	</div>
	<div id="main">
		<h2>아이디 조회 결과</h2>
		<c:forEach var="UserDto_list" items="${UserDto_list}">
			아이디 : ${UserDto_list.u_id}<br>
			이름 : ${UserDto_list.u_name}<br>
			이메일 : ${UserDto_list.u_email}<br>
			전화번호 : ${UserDto_list.u_phoneNumber}<br><br>
			<button type="button" class="button" onclick="location.href='/ex/find/pwInquiry?u_id=${UserDto_list.u_id}'">비밀번호 찾기</button><br>
		</c:forEach>
		
				

	</div>
	

</body>
</html>