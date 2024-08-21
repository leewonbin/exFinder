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
		<h2>비밀번호를 찾고자하는 아이디를 입력해주세요.</h2>
		
		<p style="display: inline; color: blue;">01. 아이디 입력 </p> 
		-> <p style="display: inline;">02. 본인 확인 </p> 
		-> <p style="display: inline;">03. 비밀번호 재설정 </p> <br>
		
		<br>
		<c:if test="${not empty errorMessage}">
			<p style="color: red; font-weight: bold;">${errorMessage}</p>
		</c:if>
		<br>
		
		<form action="/ex/find/pwInquiryDB" method="post">
			아이디 <input type="text" class="input" name="u_id" value="${u_id_result}" /><br>
				<input type="submit" class="button" value="확인">
		</form>
	</div>
	

</body>
</html>