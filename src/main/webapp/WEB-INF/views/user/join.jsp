<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/validationJs.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style>
	    .error-message {
        color: red;
        font-size: 0.875em;
        margin-left: 5px;
    }
    .correct-message {
        color: green;
        font-size: 0.875em;
        margin-left: 5px;
        
   	}
	</style>
   	</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_Login_header.jsp"%>
	<div id="main">
		<h1>회원가입</h1><br>
		<form name="signupForm" action="/ex/user/joinDB" method="post" onsubmit="return validateForm()">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			아이디 : <input type="text" id="u_id" name="u_id" oninput="validateField('u_id')">
			<button type="button" onclick="id_check()">아이디 중복 검사</button><br>
            <span id="u_id-error" class="error-message"></span>
			<div id="idChk"></div>
			
			비밀번호  : <input type="password" class="input" name="u_pw" id="u_pw" oninput="validateField('u_pw')"> 
            <button type="button" id="togglePw" onclick="togglePassword('u_pw', 'togglePw')">보기</button><br>
            <span id="u_pw-error" class="error-message"></span><br>
            
         	비밀번호 확인 : <input type="password" class="input" name="u_pw_check" oninput="validateField('u_pw_check')"><br>
         	<span id="u_pw_check-error" class="error-message"></span><br> 
         	
			별명 : <input type="text" class="input" name="u_nickname" oninput="validateField('u_nickname')"><br>
            <span id="u_nickname-error" class="error-message"></span><br>
            
			이름 : <input type="text" class="input" name="u_name" oninput="validateField('u_name')"><br>
           <span id="u_name-error" class="error-message"></span><br>
           
			성별 : <input type="radio" name="u_gender" value="남성" oninput="validateField('u_gender')"> 남자
          	<input type="radio" name="u_gender" value="여성" oninput="validateField('u_gender')"> 여자<br> 
     		<span id="u_gender-error" class="error-message"></span><br>
     		
	       	생년월일 : <input type="date" name="u_birthday" oninput="validateField('u_birthday')"><br>
            <span id="u_birthday-error" class="error-message"></span><br>
	       	
	       	이메일 : <input type="text" class="input" name="email" oninput="validateField('email')">
            <label> @ </label>
            <select class="input" name="select">
                <option value="naver.com">naver.com</option>
                <option value="gmail.com">gmail.com</option>
                <option value="daum.net">daum.net</option>
            </select><br>
            <span id="email-error" class="error-message"></span><br>
            
	      	전화번호 : <input type="text" class="input" name="phoneNumber1" maxlength="3"> - 
	      			<input class="input" type="text" name="phoneNumber2" maxlength="4"> - 
	      			<input class="input" type="text" name="phoneNumber3" maxlength="4" oninput="validateField('phoneNumber3')"><br>
             <span id="phoneNumber3-error" class="error-message"></span><br>
             
	       	 주소 : <input type="text" name="u_address" id="u_address" placeholder="주소" oninput="validateField('u_address')">
				  <input type="button" onclick="sample4_execDaumPostcode()" value="주소검색"><br>
			      <span id="u_address-error" class="error-message"></span><br>
	       	
	       	<button type="button" class="button" onclick="location.href='/ex/user/login'">취소 </button>
			<input type="submit" class="button" value="회원가입">
		</form>
	</div>
	
</body>
</html>