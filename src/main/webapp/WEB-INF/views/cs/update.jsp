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
	href="${pageContext.request.contextPath}/resources/css/csUpdate.css">
</head>
<body>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>
	</div>

	<div class="main">

		<form role="form" method="post">

				<h2 class="cs_title">
					<input type="text" name='cs_title' style="width: 100%"
						value="${CsDto.cs_title}">
				</h2>

				<h2 class="cs_content">
					<textarea style="width: 100%" name="cs_content" rows="25">${CsDto.cs_content}</textarea>
				</h2>
				
				<h2>
				<input type="text" name="admin_id" placeholder="관리자" style="width: 100%">
				</h2>			<!-- 나중에 삭제 -->
				
				<div class="box-footer">
					<button type="submit" class="btn btn-primary">저장</button>
					<button type="submit" class="btn btn-warning">취소</button>
				</div>
			</div>

		</form>
	
		<script>
			$(document).ready(function() {
				var formObj = $("form[role='form']");
				console.log(formObj);
				$(".btn-warning").on("click", function() {
					event.preventDefault(); // 폼 제출 방지---500오류 발생하는데 board에서도 똑같이 쓴 코드가 여기선 오류뜸
					self.location = "/ex/cs/listAll";
				});
				$(".btn-primary").on("click", function() {
					formObj.submit();
				});
			});
		</script>
	</div>
</body>
</html>
