<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완료 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
	<div id="header">
		<a id="header-a" href="/ex/">Home</a>
	</div>
	<div id="main">
	<h1>회원 정보</h1><br>
		<%
		String action = (String) session.getAttribute("action");
		String id = (String) session.getAttribute("userId");
	   
	    if ("join".equals(action)) {
	    	out.println("회원 가입이 완료 되었습니다.<br>");
	    	out.println("<button type=\"button\" class=\"button\" onclick=\"location.href='/ex/'\">메인 화면</button>");
	    } 
	    if ("login".equals(action)) {
	    	out.println(id + "님 환영합니다. <br>");
	    	out.println("<button type=\"button\" class=\"button\" onclick=\"location.href='/ex/user/index'\">마이 페이지</button>");
	    } 
	    if ("update".equals(action)) {
	    	out.println("회원 정보가 수정되었습니다.<br>");
	    	out.println("<button type=\"button\" class=\"button\" onclick=\"location.href='/ex/user/index'\">마이 페이지</button>");
	    } 
	    if ("delete".equals(action)) {
	    	out.println(id + "님의 회원 정보가 삭제되었습니다.<br>");
	    	out.println("<button type=\"button\" class=\"button\" onclick=\"location.href='/ex/'\">메인 화면</button>");
	    } 
	    if ("pw_update".equals(action)) {
	    	out.println("비밀번호가 변경되었습니다.<br>");
	    	out.println("<button type=\"button\" class=\"button\" onclick=\"location.href='/ex/'\">메인 화면</button>");
	    } 
	    %><br>
	    <!--<button type="button" onclick="location.href='/shopping/main.jsp'">메인 화면</button>-->
    </div>
</body>
</html>