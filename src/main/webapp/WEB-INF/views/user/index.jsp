<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
			<%
			String id= (String) session.getAttribute("userId");
			if (id != null) {
				out.println("사용자 아이디: " + id + "<br>");
			} else {
			    out.println("로그인 후, 사용자 아이디 정보 없음<br>");
			}  
			%><br>
			 	
			<h1>마이 페이지</h1>
			
			<button type="button" class="button" onclick="location.href='/ex/user/update_pw'">회원정보 수정 </button><br>
			
			<form action="${pageContext.request.contextPath}/user/logout" method="POST">
    			<input type="submit" class="button" value="로그아웃" />
			</form>
			<br><br>
			<button type="button" class="button" onclick="location.href='/ex/'">메인화면으로 </button>
			
		</div>
	</div>
</body>
</html>