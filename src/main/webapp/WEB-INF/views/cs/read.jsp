<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExFinder</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csRead.css">
</head>
<body>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>
		
		<!-- 알림을 표시할 div -->
		<div id="alramContainer" style="display: none;"></div>
	</div>

	<div class="main">

		<form role="form" method="post">
			<input type='hidden' name='cs_id' value="${CsDto.cs_id}">
		</form>

		<h2 class="cs_title">
			<input style="width: 100%" type="text" name='cs_title' 
				value="${CsDto.cs_title}" readonly="readonly">
		</h2>


		<h2 class="cs_content">
			<textarea style="width: 100%" name="cs_content" rows="25"
				readonly="readonly">${CsDto.cs_content}</textarea>
		</h2>

		<div class="box-footer">
			<button type="submit" class="btn btn-warning"
				onclick="location.href='/ex/cs/update?cs_id=${CsDto.cs_id}'">수정</button>
			<button type="submit" class="btn btn-danger"
				onclick="location.href='/ex/cs/delete?cs_id=${CsDto.cs_id}'">삭제</button>
			<button type="submit" class="btn btn-primary"
				onclick="location.href='/ex/admin/admin'">목록</button>
		</div>

</body>
</html>