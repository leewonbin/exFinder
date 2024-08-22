<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	<style>
	/* #main 요소의 크기와 정렬 설정 */
	#main {
    	width: 100%; /* 필요에 따라 조정 가능 */
    	text-align: center; /* 텍스트 중앙 정렬 */
    	padding: 20px;
    	margin-top: 100px; /* 높이만큼 여백 추가 */
	}
	#main h1 {
		height: 40px;
    	font-size: 25px; /* 글자 크기 설정 */
    	font-weight: bold; /* 글자 굵기 설정 */
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
	/* 입력 필드 컨테이너 스타일 */
.input-container {
	width: 400px; /* 전체 너비 설정 */
	margin: 20px auto; /* 상하 여백 설정, 좌우 중앙 정렬 */
	display: flex; /* 플렉스 박스 레이아웃 사용 */
	align-items: center; /* 수직 중앙 정렬 */
	border: 1px solid #ccc; /* 테두리 색상 설정 */
	padding: 5px; /* 내부 여백 설정 */
	box-sizing: border-box; /* 패딩과 테두리를 포함하여 전체 너비 계산 */
}

/* 입력 필드 컨테이너 hover 효과 */
.input-container:hover {
	border-color: #2f46a2; /* 마우스를 올렸을 때 테두리 색상 설정 */
}

/* 레이블 스타일 */
.input-container label {
	flex-shrink: 0; /* 레이블이 축소되지 않도록 설정 */
	width: 80px; /* 레이블 너비 설정 */
	margin-right: 10px; /* 레이블과 입력 필드 사이의 간격 설정 */
	font-weight: bold; /* 레이블 텍스트를 굵게 설정 */
	text-align: right; /* 레이블 텍스트 오른쪽 정렬 */
	white-space: nowrap; /* 레이블 텍스트가 줄바꿈되지 않도록 설정 */
}

/* 이메일 입력 필드 스타일 */
.input {
	flex: 1; /* 남은 공간을 채우도록 설정 */
	min-width: 0; /* 최소 너비를 0으로 설정 */
	height: 40px; /* 입력 필드의 높이 설정 */
	padding: 0 10px; /* 좌우 내부 여백 설정 */
	border: none;
	box-sizing: border-box; /* 패딩을 포함하여 전체 너비 계산 */
	font-size: 16px; /* 텍스트 크기 설정 */
	background-color: #f9f9f9; /* 배경색 설정 (옵션) */
	margin-right: 10px; /* 선택 박스와의 간격 설정 */
}
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_Login_header.jsp"%>
	<div id="main">
		<h1 style="margin-bottom: 20px;">비밀번호를 찾고자하는 아이디를 입력해주세요.</h1>
		
		<p style="display: inline; color: blue;">01. 아이디 입력 </p> 
		-> <p style="display: inline;">02. 본인 확인 </p> 
		-> <p style="display: inline;">03. 비밀번호 재설정 </p> <br>
		
		<br>
		<c:if test="${not empty errorMessage}">
			<p style="color: red; font-weight: bold;">${errorMessage}</p>
		</c:if>
		<br>
		
		<form action="/ex/find/pwInquiryDB" method="post">
			<div class="input-container">
				<label>이름</label> 
				<input type="text" class="input" name="u_id" value="${u_id_result}" />
			</div>
			<input type="submit" class="button" value="확인">
		</form>
	</div>
	

</body>
</html>