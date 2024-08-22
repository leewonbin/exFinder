<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<div class="main">

	<form role="form" method="post">
		<input type='hidden' name='b_id' value="${boardDto.b_id}">
	</form>
	<h2>
		카테고리 <input type="text" name='b_category' style="width: 100%"
			value="${boardDto.b_category}" readonly="readonly">
	</h2>

	</h2>
	<h1>제목</h1>
	<h2>
		<input type="text" name='b_title' style="width: 100%"
			value="${boardDto.b_title}" readonly="readonly">
	</h2>

	<h2>
		내용
		<textarea style="width: 100%" name="b_content" rows="3"
			readonly="readonly">${boardDto.b_content}</textarea>
	</h2>

	<h2>
		작성자 <input type="text" name="u_id" style="width: 100%"
			value="${boardDto.u_id}" readonly="readonly">
		<h2>

			<div class="box-footer">
				<button type="submit" class="btn btn-warning" onclick="location.href='/ex/board/update?b_id=${boardDto.b_id}'">수정</button>
				<button type="submit" class="btn btn-danger" onclick="location.href='/ex/board/delete?b_id=${boardDto.b_id}'">삭제</button>
				<button type="submit" class="btn btn-primary" onclick="location.href='/ex/board/listAll'">전체글보기</button>
			</div>
</div>

