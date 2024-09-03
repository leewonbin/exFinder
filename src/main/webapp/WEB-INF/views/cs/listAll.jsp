<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="logout-status"
	content="${sessionScope.userId == null ? 'logged-out' : 'logged-in'}">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csList.css">


<script
	src="${pageContext.request.contextPath}/resources/js/listAllJs.js"></script>
<body>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>
	</div>

	<div class="content">
		<h1>관리자가 cs글 관리하는 화면임, 아이디는 임의로 넣음</h1>
		<br> <br> <br>

		<table id="cs" border="1">
			<thead>
				<tr>
					<th style="width: 20px;">NO.</th>
					<th style="width: 200px;">제목</th>
					<th style="width: 30px;">관리자</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="csDto" items="${list}">
					<tr>
						<td>${csDto.cs_id}</td>
						<td><a href="/ex/cs/read?cs_id=${csDto.cs_id}">${csDto.cs_title}</a></td>
						<td>${csDto.admin_id}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="box-footer">
		<button type="submit" class="btn btn-warning"
			onclick="location.href='/ex/cs/create'">글쓰기</button>
		<button type="submit" class="btn btn-primary"
			onclick="location.href='/ex/cs/main'">메인</button>
	</div>
	
</body>
</html>

