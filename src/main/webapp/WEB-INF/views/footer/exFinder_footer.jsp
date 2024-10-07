<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExFinder</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/exFinder_footer.css">
</head>
<body>
	<footer class="footer">
		<div class="footer_sides">
			<img src="${pageContext.request.contextPath}/resources/img/logo-Photoroom.png" class="footer_wrapper_img">
		</div>
		<div class="footer_wrapper">
			<div class="footer_left">
				<div class="footer_left_menu">
					<a href="/ex/board/listAll?bCategory=공지사항">공지사항</a>
					<a href="/ex/cs/main">고객센터</a>
				</div>
				<p>exFinder에서 제공하는 환율 정보는 단순히 정보의 제공을 목적으로 하고 있으며, </p> <p>사이트에서 제공되는 정보는 오류 및 지연이 발생될 수 있습니다.</p> 
				<p>제공된 정보이용에 따르는 책임은 이용자 본인에게 있으며, </p>  <p>exFinder는 이용자의 투자결과에 따른 법적 책임을 지지 않습니다.</p>
			</div>
			<div class="footer_center"></div>
			<div class="footer_right">
				<p class="footer_right_top">ⓒ exFinder</p>
				<p>- <label>대표 이사</label> : 이원빈, <label>이사</label> : 최현웅 함지훈 김정호</p>
				<p>- <label>주소</label> : <a href="https://github.com/leewonbin/exFinder" target="_blank" rel="noopener noreferrer">github exFinder</a> </p>
			</div>
		</div>
		<div class="footer_sides"></div>
	</footer>
</body>
</html>