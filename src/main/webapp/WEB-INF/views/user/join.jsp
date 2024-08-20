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
   	<script type="text/javascript">
    function id_check() {
        $.ajax({
            url: "/ex/user/id_duplicate_check",
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",  // 폼 데이터 형식
            data: { "u_id": $("#u_id").val() },  // 쿼리 파라미터 형식으로 데이터 전송
            success: function(data) {
                // 문자열 "true" 또는 "false"를 반환 받음
                if (data === "true") {
                    //alert("중복된 아이디입니다.");
                    $("#idChk").text("중복된 아이디입니다.").css("color", "red");  // idChk div에 텍스트 추가
                } else {
                    //alert("사용 가능한 아이디입니다.");
                    $("#idChk").text("사용 가능한 아이디입니다.").css("color", "green");  // idChk div에 텍스트 추가
                }
            },
            error: function() {
                alert("서버 오류 발생");
            }
        });
    }
	</script>
</head>
<body>
	<div id="header">
		<a id="header-a" href="/ex/">Home</a>
	</div>
	<div id="main">
		<h1>회원가입</h1><br>
		<form action="/ex/user/joinDB" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			아이디 : <input type="text" class="input" id="u_id" name="u_id" required>
			<button type="button" onclick="id_check()">아이디 중복 검사</button><br>
			<div id="idChk"></div>
			
			비밀번호 : <input type="password" class="input" name="u_pw"> <br>
			비밀번호 확인 : <input type="password" class="input" name="u_pw_check"> <br>
			닉네임 : <input type="text" class="input" name="u_nickname" > <br>
			이름 : <input type="text" class="input" name="u_name" > <br>
			성별 : <input type="radio" name="u_gender" value="남성"> 남자
	        	<input type="radio" name="u_gender" value="여성"> 여자 <br>
	       	생일 : <input type="text" class="input" name="year" placeholder="출생 년도 숫자만">
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
	       	<input type="text" class="input" name="day" placeholder="출생일 숫자만"> <br>
	       	
	       	이메일 : <input type="text" class="input" name="email">
	       	<label> @ </label>
			<select class="input" name="select">
	        	<option value="naver.com">naver.com</option>
	        	<option value="gmail.com">gmail.com</option>
	        	<option value="daum.net">daum.net</option>
			</select><br>
	       	전화번호 : <input type="text" class="input" name="phoneNumber1"> - <input class="input" type="text" name="phoneNumber2" > - <input class="input" type="text" name="phoneNumber3" > <br>
	       	주소 : <input type="text" class="input" name="u_address" > <br>
	       	
	       	<button type="button" class="button" onclick="location.href='/ex/user/login'">취소 </button>
			<input type="submit" class="button" value="회원가입">
		</form>
	</div>
	
</body>
</html>