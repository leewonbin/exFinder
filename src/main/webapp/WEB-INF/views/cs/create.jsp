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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csCreate.css">
</head>
<body>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>
	</div>

	<div class="main">
		<div class="box-header">
			<h1 class="box-title">FAQ 작성</h1>
		</div>

		<div class="horizontal-line"></div>

		<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->
		<!-- 	<form role="form" method="post"> -->
		<form role="form" method="post">

			<h2 class="cs_title">
				<input type="text" name='cs_title' placeholder="질문 내용 입력"
					style="width: 100%">
			</h2>


			<h2 class="cs_content">
				<textarea name="cs_content" rows="25" style="width: 100%"
					placeholder="답변 내용 입력"></textarea>
			</h2>
			

			<h2>
				<input type="text" name="admin_id" placeholder="관리자" style="width: 100%">
			</h2>			<!-- 나중에 삭제 -->


			<div class="submitBtn">
                <button type="submit">등록</button>
            </div>

		</form>

	</div>
</body>
</html>
