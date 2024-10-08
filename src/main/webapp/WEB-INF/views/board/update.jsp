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
<title>게시판-수정</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boardUpdate.css">
</head>
<body>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>

		<!-- 알림을 표시할 div -->
		<div id="alramContainer" style="display: none;"></div>
	</div>

	<div class="main">

		<form role="form" method="post">

			<h2 class="b_category">
				<select name="b_category">
					<sec:authorize access="hasAnyRole('ADMIN')">
						<option value="공지사항">공지사항</option>
					</sec:authorize>
					<option value="자유게시판">자유게시판</option>
					<option value="질문게시판">질문게시판</option>
					<option value="정보공유게시판">정보공유게시판</option>
				</select>
			</h2>

			<h2 class="b_title">
				<input type="text" name='b_title' style="width: 100%"
					value="${boardDto.b_title}">
			</h2>

			<h2 class="b_content">
				<textarea style="width: 100%" name="b_content" rows="35">${boardDto.b_content}</textarea>
			</h2>

			<div class="box-footer">
				<button type="submit" class="btn btn-primary">저장</button>
				<button type="submit" class="btn btn-warning">취소</button>
			</div>
		</form>
	</div>


	<script>
		$(document).ready(function() {
			var formObj = $("form[role='form']");
			console.log(formObj);
			$(".btn-warning").on("click", function() {
				self.location = "/ex/board/listAll";
			});
			$(".btn-primary").on("click", function() {
				formObj.submit();
			});
		});
	</script>
	</div>
	<%@include file="/WEB-INF/views/footer/exFinder_footer.jsp"%>
</body>
</html>
