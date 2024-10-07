<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="logout-status"
	content="${sessionScope.userId == null ? 'logged-out' : 'logged-in'}">
<title>ExFinder</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boardCreate.css">
</head>
<body>
	<c:if test="${sessionScope.dto eq null }">
		<script>
			alert('로그인이 필요합니다.');
			location.href = "/ex/user/login";
		</script>
	</c:if>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>

		<!-- 알림을 표시할 div -->
		<div id="alramContainer" style="display: none;"></div>
	</div>

	<div class="main">
		<div class="box-header">
			<h1 class="box-title">글쓰기</h1>
		</div>

		<div class="horizontal-line"></div>

		<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->
		<!-- 	<form role="form" method="post"> -->
		<form role="form" method="post">

			<h2 class="b_category">
				<select name="b_category">
					<sec:authorize access="hasAnyRole('ADMIN')">
						<option value="공지사항">공지사항</option>
					</sec:authorize>
					<option value="자유게시판">자유게시판</option>
				</select>
			</h2>

			<%-- <h2 class="b_category">
				<select name="b_category" id="b_category">
					<option value="자유게시판">자유게시판</option>
					<c:if test="${sessionScope.authority == 'ROLE_ADMIN'}">
						<option value="공지사항">공지사항</option>
					</c:if>
				</select>
			</h2> --%>

			<h2 class="b_title">
				<input type="text" name='b_title' placeholder="제목 입력"
					style="width: 100%">
			</h2>


			<h2 class="b_content">
				<textarea name="b_content" rows="35" style="width: 100%"
					placeholder="내용 입력"></textarea>
			</h2>


			<div class="submitBtn">
				<button type="submit">등록</button>
			</div>

		</form>
	</div>

<%@include file="/WEB-INF/views/footer/exFinder_footer.jsp"%>
</body>
</html>
