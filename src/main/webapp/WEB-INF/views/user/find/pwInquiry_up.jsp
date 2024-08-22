<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	
	<script type="text/javascript">
        function validateForm() {
            var pw = document.forms["passwordForm"]["u_pw"].value;
            var pw_check = document.forms["passwordForm"]["pw_check"].value;
            var errorMessage = document.getElementById("error-message");
            
            if (pw !== pw_check) {
            	errorMessage.textContent = "비밀번호가 일치하지 않습니다.";
                return false; // 폼 제출을 막습니다.
            }
            return true; // 폼을 제출합니다.
        }
    </script>
    
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_Login_header.jsp"%>
	<div id="main">
		<h2>비밀번호를 변경해주세요.</h2>
		
		<p style="display: inline;">01. 아이디 입력 </p> 
		-> <p style="display: inline;">02. 본인 확인 </p> 
		-> <p style="display: inline; color: blue;">03. 비밀번호 재설정 </p> <br>
		
		<br>
		<br>
		
		<c:if test="${not empty errorMessage}">
			<p style="color: red; font-weight: bold;">${errorMessage}</p>
		</c:if>
		<form name="passwordForm" action="/ex/find/pwInquiry_upDB" method="post" onsubmit="return validateForm()">
        	변경할 비밀번호 입력 <input type="text" class="input" name="u_pw" /><br>
       	 	비밀번호 확인 <input type="password" class="input" name="pw_check" /><br>
       	 	<div style="color: red;" id="error-message"></div> <!-- 오류 메시지를 표시할 영역 -->
	        <input type="submit" class="button" value="변경하기">
    	</form>
	</div>
	

</body>
</html>