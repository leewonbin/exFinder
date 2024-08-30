<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardCreate.css">

<div>
<%@include file="../header/exFinder_header.jsp"%>
</div> 

<div class="main">
	<div class="box-header">
		<h1 class="box-title">글쓰기</h1>
	</div>
	
	<div class="horizontal-line"></div>

	<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->
	<!-- 	<form role="form" method="post"> -->
	<form role="form" method="post">
		
		<h2>
			<select name="b_category">
				<option value="공지사항">공지사항</option>
				<option value="자유게시판">자유게시판</option>
				<option value="고객센터">고객센터</option>
			</select>
		</h2>
		
		<h3>
			<input type="text" name='b_title' placeholder="제목 입력"
				style="width: 100%">
		</h3>


		<h2>
			<textarea name="b_content" rows="35" style="width: 100%"
				placeholder="내용 입력"></textarea>
		</h2>

		<h2>
			<input type="text" name="u_id" placeholder="작성자"
				style="width: 100%">
		</h2>

		<button type="submit" class="btn btn-primary">등록</button>

	</form>

</div>

