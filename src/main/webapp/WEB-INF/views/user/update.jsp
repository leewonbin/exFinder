<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
	<div id="header">
		<a id="header-a" href="/ex/">Home</a>
	</div>
	<div id="main">
		<div id="left_main">
			<button type="button" class="button" onclick="location.href='/ex/user/index'">마이 페이지</button><br>
			<button type="button" class="button" onclick="location.href='/ex/user/update_pw'">회원정보 수정 </button><br>
			<button type="button" class="button" onclick="location.href='/ex/shop/order_history'">주문 내역</button><br>
		</div>
		<div id="right_main">
		    <h1>회원 정보 수정</h1>
		
		    <form name= "updateForm" action="/ex/user/updateDB" method="post">
		    	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				아이디 : <input type="text" class="input" name="u_id" value="${UserDto.u_id }" readonly> <br>
				비밀번호 : <input type="password" class="input" name="u_pw" value=""> <br>
				비밀번호 확인 : <input type="password" class="input" name="pw_check" value=""> <br>
				닉네임 : <input type="text" class="input" name="u_nickname" value="${UserDto.u_nickname }"> <br>
				이름 : <input type="text" class="input" name="u_name" value="${UserDto.u_name }"> <br>
				성별 : <input type="radio" name="u_gender" value="남성" ${UserDto.u_gender.equals("남성") ? "checked" : ""}> 남자
		        	 <input type="radio" name="u_gender" value="여성" ${UserDto.u_gender.equals("여성") ? "checked" : ""}> 여자 <br>
		       	생일 : <input type="text" class="input" name="year" placeholder="출생 년도 숫자만" value="${u_birthdayArr[0] }">년
		       	<select class="input" name="month">
		        	<option value="01">1월</option>
		        	<option value="02">2월</option>
		        	<option value="03">3월</option>
		        	<option value="04">4월</option>
		        	<option value="05">5월</option>
		        	<option value="06">6월</option>
		        	<option value="07">7월</option>
		        	<option value="08">8월</option>
		        	<option value="09">9월</option>
		        	<option value="10">10월</option>
		        	<option value="11">11월</option>
		        	<option value="12">12월</option>
				</select>
		       	<input type="text" class="input" name="day" placeholder="출생일 숫자만" value="${u_birthdayArr[2] }">일 <br>
		       	
		       	이메일 : <input type="text" class="input" name="email" value="${u_emailArr[0] }">
		       	<label for="select"> @ </label>
				<select class="input" name="select">
		        	<option value="naver.com">naver.com</option>
		        	<option value="gmail.com">gmail.com</option>
		        	<option value="daum.net">daum.net</option>
				</select><br>
		       	전화번호 : <input type="text" class="input" name="phoneNumber1" value="${u_phoneNumberArr[0] }">
		       	 - <input type="text" class="input" name="phoneNumber2" value="${u_phoneNumberArr[1] }">
		       	 - <input type="text" class="input" name="phoneNumber3" value="${u_phoneNumberArr[2] }"> <br>
		       	주소 : <input type="text" class="input" name="u_address" value="${u_address }"> <br>
		       	
		       	<button type="button" class="button" onclick="confirmDelete()">회원 탈퇴</button>
				<input type="submit" class="button" value="수정">
			</form>
			
		    <button type="button" class="button" onclick="location.href='/ex/user/index'">취소</button><br>
	    </div>
    </div>
     <script>
	    var monthVal = ${u_birthdayArr[1]};
	    var emailVal = ${u_emailArr[1]};
	</script>
	<script src="/resources/js/userUpdateJs.js"></script>
</body>
</html>
