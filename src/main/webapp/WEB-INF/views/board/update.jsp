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
</head>
<body>
	<div class="main">

		<form role="form" method="post" >

			<div class="box-body">

				<h2>
					번호 <input type="text" name='bId' style="width: 100%"
						value="${boardDto.b_id}" readonly="readonly">
				</h2>

				<h2>
					카테고리<select name="b_category">
						<option value="공지사항">공지사항</option>
						<option value="자유게시판">자유게시판</option>
						<option value="고객센터">고객센터</option>
					</select>
				</h2>

				<h2>
					제목 <input type="text" name='b_title' style="width: 100%"
						value="${boardDto.b_title}">
				</h2>

				<h2>
					내용
					<textarea style="width: 100%" name="b_content" rows="3">${boardDto.b_content}</textarea>
				</h2>

				<h2>
					작성자 <input type="text" name="u_id" style="width: 100%"
						value="${boardDto.u_id}" readonly>
					<h2>
			</div>
			<div class="box-footer">
				<button type="submit" class="btn btn-primary">저장</button>
				<button type="button" class="btn btn-warning"
					onclick="window.location.href='/ex/board/listAll'">취소</button>
			</div>
		</form>
	</div>
</body>
</html>