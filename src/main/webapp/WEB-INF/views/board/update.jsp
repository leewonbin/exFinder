<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boardUpdate.css">
</head>
<body>
	<div class="main">

		<form role="form" method="post">

			<div class="box-body">

				<h2>
					<input type="text" name='bId' style="width: 20%"
						value="${boardDto.b_id}" readonly="readonly">
				</h2>

				<h2>
					<select name="b_category">
						<option value="공지사항">공지사항</option>
						<option value="자유게시판">자유게시판</option>
						<option value="고객센터">고객센터</option>
					</select>
				</h2>

				<h2>
					<input type="text" name='b_title' style="width: 100%"
						value="${boardDto.b_title}">
				</h2>

				<h2>
					<input type="text" name="u_id" style="width: 20%"
						value="${boardDto.u_id}" readonly>
				</h2>

				<h2>
					<textarea style="width: 100%" name="b_content" rows="35">${boardDto.b_content}</textarea>
				</h2>

			</div>

		</form>
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">저장</button>
			<button type="submit" class="btn btn-warning">취소</button>
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
</body>
</html>
