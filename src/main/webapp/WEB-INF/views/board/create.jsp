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
</head>
<body>
	<div class="main">
	<div class="box-header">
		<h1 class="box-title">새 글쓰기</h1>
	</div>

	<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->
	<!-- 	<form role="form" method="post"> -->
	<form role="form" method="post">

		<h3>
			제목 <input type="text" name='b_title' placeholder="제목 입력"
				style="width: 100%">
		</h3>

		<h2>
			카테고리<select name="b_category">
				<option value="공지사항">공지사항</option>
				<option value="자유게시판">자유게시판</option>
				<option value="고객센터">고객센터</option>
			</select>
		</h2>

		<h2>
			내용
			<textarea name="b_content" rows="8" style="width: 100%"
				placeholder="내용 입력"></textarea>
		</h2>

		<h2>
			작성자 <input type="text" name="u_id" placeholder="작성자"
				style="width: 100%">
		</h2>

		<button type="submit" class="btn btn-primary">글쓰기</button>

	</form>

</div>
</body>
</html>