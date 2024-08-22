<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- header css -->
	<style>
	/* #main 요소의 크기와 정렬 설정 */
	#main {
    	width: 100%; /* 필요에 따라 조정 가능 */
    	text-align: center; /* 텍스트 중앙 정렬 */
    	padding: 20px;
    	margin-top: 80px; /* 높이만큼 여백 추가 */
	}
	#main h1 {
		height: 40px;
    	font-size: 30px; /* 글자 크기 설정 */
    	font-weight: bold; /* 글자 굵기 설정 */
	}
	/* 입력 필드 컨테이너 스타일 */
	.input-container {
    	width: 400px; /* 입력 필드와 같은 너비 설정 */
    	margin: 20px auto; /* 상하 여백 설정, 좌우 중앙 정렬 */
    	display: flex; /* 플렉스 박스 레이아웃 사용 */
    	align-items: center; /* 수직 중앙 정렬 */
    	justify-content: center; /* 수평 중앙 정렬 */
    	border: 1px solid #ccc; /* 테두리 색상 설정 */
    	padding: 5px; /* 내부 여백 설정 */
    	box-sizing: border-box; /* 패딩과 테두리를 포함하여 전체 너비 계산 */
	}
	/* 입력 필드 컨테이너 hover 효과 */
	.input-container:hover {
	    border: 1px solid #2f46a2; /* 마우스를 올렸을 때 테두리 색상 설정 */
	}
	/* 레이블 스타일 */
	.input-container label {
    	width: 80px; /* 레이블 너비 설정 */
    	margin-right: 10px; /* 레이블과 입력 필드 사이의 간격 설정 */
    	font-weight: bold; /* 레이블 텍스트를 굵게 설정 */
    	text-align: right; /* 레이블 텍스트 오른쪽 정렬 */
	}

	/* 입력 필드 스타일 */
	.input {
    	flex: 1; /* 남은 공간을 채우도록 설정 */
    	height: 40px; /* 입력 필드의 높이 설정 */
    	padding: 0 10px; /* 좌우 내부 여백 설정 */
    	border: none; /* 테두리 제거 */
    	box-sizing: border-box; /* 패딩을 포함하여 전체 너비 계산 */
    	font-size: 16px; /* 텍스트 크기 설정 */
    	background-color: #f9f9f9; /* 배경색 설정 (옵션) */
	}

	/* 버튼 스타일 */
	.button {
		width: 400px;
		height: 70px;
    	background-color: #4158D0; /* 버튼 배경색을 설정합니다. */
    	color: white; /* 버튼 텍스트 색상을 흰색으로 설정합니다. */
    	padding: 10px 20px; /* 버튼의 내부 여백을 상하 10px, 좌우 20px로 설정합니다. */
    	margin: 10px 0; /* 버튼의 상하 여백을 10px로 설정합니다. */
    	border: none; /* 버튼의 테두리를 없앱니다. */
    	cursor: pointer; /* 마우스 커서를 포인터로 변경하여 클릭 가능함을 나타냅니다. */
    	font-size: 16px; /* 버튼 텍스트의 크기를 16px로 설정합니다. */
	}

	/* 버튼 hover 효과 */
	.button:hover {
    	background-color: #2f46a2; /* 버튼 위에 마우스를 올렸을 때 배경색을 어두운 파란색으로 변경합니다. */
	}
	/* 체크박스 컨테이너 스타일 */
	.checkbox-container {
    	display: flex; /* 플렉스 박스를 사용하여 자식 요소를 정렬 */
    	justify-content: space-between; /* 자식 요소를 컨테이너의 양 끝으로 배치 */
    	width: 400px; /* 컨테이너의 너비 설정 (필요에 따라 조정) */
    	margin: 10px auto; /* 컨테이너를 중앙 정렬 */
	}

	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_Login_header.jsp"%>
	<div id="main">

		<h1>회원 로그인</h1>
		<p>회원님의 아이디와 비밀번호를 입력해 주세요.</p>
		<br>

		<c:if test="${param.error != null}">
			<p>아이디와 비밀번호가 잘못되었습니다.</p>
		</c:if>
		<c:if test="${param.logout != null}">
			<p>로그아웃 하였습니다.</p>
		</c:if>

		<c:url value="/login" var="loginUrl" />
		<form name="frmLogin" action="${loginUrl}" method="POST">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token }" />
			<div class="input-container">
				<label>아이디</label> 
				<input type="text" class="input" name="u_id" value="${ids}" />
			</div>
			<div class="input-container">
				<label>비밀번호</label> 
				<input type="password" class="input" name="u_pw" value="${pws}" />
			</div>
			<button type="submit" class="button">로그인</button><br>
			
			<div class="checkbox-container">
    			<div class="checkbox-container1">
        			<input type="checkbox" id="id_save" name="id_save" value="id_save" ${id_save_Checked} class="custom-checkbox">
        			<label for="id_save">아이디 저장</label>
    			</div>
    			<div class="checkbox-container2">
        			<input type="checkbox" id="auto_login" name="auto_login" value="auto_login" ${auto_login_Checked} class="custom-checkbox">
        			<label for="auto_login">자동 로그인</label>
			    </div>
			</div>
		</form>

	</div>
</body>
</html>