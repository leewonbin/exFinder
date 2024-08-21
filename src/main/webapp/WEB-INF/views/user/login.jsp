<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
	<!-- header css -->

</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
	<div id="main">

		<h1>로그인</h1>
		<br>

		<c:if test="${param.error != null}">
			<p>아이디와 비밀번호가 잘못되었습니다.</p>
		</c:if>
		<c:if test="${param.logout != null}">
			<p>로그아웃 하였습니다.</p>
		</c:if>

		<c:url value="/login" var="loginUrl" />
		<form name="frmLogin" action="${loginUrl}" method="POST">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token }" />
			<p>
				<label for="u_id">아이디</label> <input type="text" class="input"
					name="u_id" value="${ids}" />
			</p>
			<p>
				<label for="u_pw">비밀번호</label> <input type="password" class="input"
					name="u_pw" value="${pws}" />
			</p>
			<input type="checkbox" name="id_save" value="id_save"
				${id_save_Checked}> 아이디 저장 <input type="checkbox"
				name="auto_login" value="auto_login" ${auto_login_Checked}>
			자동 로그인 <br>
			<button type="submit" class="button">로그인</button>
			<button type="button" class="button"
				onclick="location.href='/ex/user/join'">회원가입</button>
			<br>
		</form>
		<button type="button" class="button"
			onclick="location.href='/ex/find/idInquiry'">아이디 찾기</button>
		<button type="button" class="button"
			onclick="location.href='/ex/find/pwInquiry'">비밀번호 찾기</button>
		<br>



	</div>
</body>
</html>