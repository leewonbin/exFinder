<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/findPwJs.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_Login_header.jsp"%>
	<div id="main">
		<h2>본인확인을 해주세요.</h2>
		
		<p style="display: inline;">01. 아이디 입력 </p> 
		-> <p style="display: inline; color: blue;">02. 본인 확인 </p> 
		-> <p style="display: inline;">03. 비밀번호 재설정 </p> <br>
		
		<br>
		<br>
			<p class="check_info"style="font-weight: bold;"></p>
		<div id="contents"> 
		
			<a href="#" onclick="reg_type_select('email'); return false;">이메일 인증</a>
			<a href="#" onclick="reg_type_select('pcs'); return false;">휴대폰 인증</a>	
		
			
			<div class="type_email" style="display: none;">
				<h2>이메일 인증</h2>
				<p>이메일 인증을 선택하셨습니다. 등록하신 이름과 이메일주소를 입력 후 인증번호 전송버튼을 눌러주세요.</p>
				
					이메일 인증 <input type="text" class="email1" name="email">
	       			<label for="select"> @ </label>
					<select class="email2" name="select" >
	    	    		<option value="naver.com">naver.com</option>
		        		<option value="gmail.com">gmail.com</option>
		        		<option value="daum.net">daum.net</option>
					</select>
					<input class="email_btn" type="button" value="인증번호 전송">
				
			</div>
			
			<div class="type_pcs" style="display:none;">
				<h2>휴대폰 인증</h2>
				<p>휴대폰 인증을 선택하셨습니다. 등록하신 이름과 휴대폰번호를 입력 후 인증번호 전송버튼을 눌러주세요.</p>
			
					휴대폰 인증 <input type="text" class="phoneNum1">
					 - <input type="text" class="phoneNum2" >
					 - <input  type="text" class="phoneNum3">  <!-- 인증번호 받을사람 휴대폰 번호 -->
					<input class="phone_btn"type="button" value="인증번호 전송">
			</div>
			
			<form action="/ex/find/pwInquiry_check_complete" method="post">
				인증번호 : <input class="check_number" type="text">   <!-- 인증번호 입력창 -->
				<input type="button" class="check_btn" value="인증번호 확인" placeholder="인증번호 6자리를 입력해주세요." maxlength="6">  <!-- 인증번호와 내가 입력창에 입력한 인증번호 비교하는 창 -->
			</form>		
    	</div>
	</div>
</body>
	
</html>