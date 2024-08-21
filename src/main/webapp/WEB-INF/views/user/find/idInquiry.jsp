<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script>
        function reg_type_select(type) {
            // 모든 섹션을 숨기기
            document.querySelector('.type_email').style.display = 'none';
            document.querySelector('.type_pcs').style.display = 'none';

            // 선택된 타입에 따라 해당 섹션을 표시
            if (type === 'email') {
                document.querySelector('.type_email').style.display = 'block';
            } else if (type === 'pcs') {
                document.querySelector('.type_pcs').style.display = 'block';
            }
        }
    </script>
</head>
<body>
	<div id="header">
		<a id="header-a" href="/ex/">Home</a>
	</div>
	<div id="main">
		<h2>아이디 찾기</h2>
		아이디 찾기를 위해 이메일이나 휴대폰을 선택해주세요.<br>
		
		<a href="#" onclick="reg_type_select('email'); return false;">이메일 확인</a>
		<a href="#" onclick="reg_type_select('pcs'); return false;">휴대폰 확인</a>	
		
		<c:if test="${not empty errorMessageEmail}">
			<p style="color: red; font-weight: bold;">${errorMessageEmail}</p>
		</c:if>
		<div class="type_email" style="display: none;">
			<h2>이메일 확인</h2>
			<p>이메일 확인을 선택하셨습니다. 가입당시 이름과 이메일주소를 입력 후 확인을 눌러주세요.</p>
			
			<form action="/ex/find/idInquiryDB?type=email" method="post">
				이름 <input type="text" class="input" name="u_name" value="${UserDto_list.u_name }" /><br>
				이메일 <input type="text" class="input" name="email">
	       		<label for="select"> @ </label>
				<select class="input" name="select">
	        		<option value="naver.com">naver.com</option>
	        		<option value="gmail.com">gmail.com</option>
	        		<option value="daum.net">daum.net</option>
				</select><br>
				<input type="submit" class="button" value="확인">
			</form>
		</div>
		
		<c:if test="${not empty errorMessagePhone}">
			<p style="color: red; font-weight: bold;">${errorMessagePhone}</p>
		</c:if>
		<div class="type_pcs" style="display:none;">
			<h2>휴대폰 확인</h2>
			<p>휴대폰 확인을 선택하셨습니다. 가입당시 이름과 휴대폰번호를 입력 후 확인을 눌러주세요.</p>
			
			<form action="/ex/find/idInquiryDB?type=phone" method="post">
				이름 <input type="text" class="input" name="u_name" value="${UserDto_list.u_name }" /><br>
				휴대폰 번호 <input type="text" class="input" name="phoneNumber1">
				 - <input class="input" type="text" name="phoneNumber2" >
				 - <input class="input" type="text" name="phoneNumber3" ><br>
				<input type="submit" class="button" value="확인">
			</form>
		</div>
				

	</div>
	

</body>
</html>