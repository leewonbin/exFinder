<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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

.box {
	width: 190px; /* 박스의 너비 설정 */
	padding: 20px; /* 내부 여백 */
	border: none; /* 버튼의 테두리를 없앱니다. */
	border-radius: 8px; /* 모서리를 둥글게 */
	text-align: center; /* 텍스트 및 이미지 중앙 정렬 */
	background-color: #4158D0; /* 배경색 설정 */
	margin-right: 10px; /* 박스 사이의 간격 */
}

.box-container {
	display: flex; /* 박스를 가로로 나란히 배치 */
	justify-content: center; /* 박스를 중앙에 배치 */
	margin: 0 auto; /* 박스 컨테이너를 가로 중앙에 배치 */
}

.box img {
	display: block; /* 이미지를 블록으로 설정하여 중앙 정렬 */
	margin: 0 auto 10px auto; /* 이미지를 중앙에 위치시키고 아래쪽 여백 추가 */
}

.box a {
	text-decoration: none; /* 링크의 기본 밑줄 제거 */
	color: white; /* 링크 텍스트 색상 */
	font-size: 16px; /* 텍스트 크기 설정 */
}

/* 선택된 박스에 적용될 클래스 */
.selected {
	background-color: #2f46a2; /* 선택된 상태에서의 배경색 */
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

/* 선택 박스 스타일 */
.select {
	flex-shrink: 0; /* 선택 박스는 축소되지 않도록 설정 */
	height: 40px; /* 선택 박스의 높이 설정 */
	border: none;
	padding: 0 10px; /* 좌우 내부 여백 설정 */
	font-size: 16px; /* 텍스트 크기 설정 */
	background-color: #f9f9f9; /* 배경색 설정 (옵션) */
	box-sizing: border-box; /* 패딩을 포함하여 전체 너비 계산 */
}
</style>
<script>
	function selectBox(box) {
		// 기존에 선택된 박스가 있으면 선택 해제
		const selectedBox = document.querySelector('.box.selected');
		if (selectedBox) {
			selectedBox.classList.remove('selected');
		}

		// 클릭된 박스를 선택 상태로 변경
		box.classList.add('selected');
	}

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
	<%@include file="/WEB-INF/views/header/exFinder_Login_header.jsp"%>
	<div id="main">
		<h1>아이디 찾기</h1>
		<p>아이디 찾기를 위해 이메일이나 휴대폰을 선택해주세요.</p>
		<br>

		<div class="box-container">
			<div class="box" onclick="selectBox(this)">
				<a href="#" onclick="reg_type_select('email'); return false;"> <img
					src="${pageContext.request.contextPath}/resources/img/free-icon-email.png"
					alt="" style="width: 40px; height: auto;"> 이메일 확인
				</a>
			</div>
			<div class="box" onclick="selectBox(this)">
				<a href="#" onclick="reg_type_select('pcs'); return false;"> <img
					src="${pageContext.request.contextPath}/resources/img/free-icon-phone.png"
					alt="" style="width: 40px; height: auto;"> 휴대폰 확인
				</a>
			</div>
		</div>

		<c:if test="${not empty errorMessageEmail}">
			<p style="color: red; font-weight: bold;">${errorMessageEmail}</p>
		</c:if>
		<div class="type_email" style="display: none;">
			<h1 style="margin-top: 30px;">이메일 확인</h1>
			<p>이메일 확인을 선택하셨습니다.</p>
			<p>가입당시 이름과 이메일주소를 입력 후 확인을 눌러주세요.</p>

			<form action="/ex/find/idInquiryDB?type=email" method="post">
				<div class="input-container">
					<label>이름</label> 
					<input type="text" class="input" name="u_name" value="${UserDto_list.u_name }" /><br>
				</div>
				<div class="input-container">
					<label>이메일</label> 
					<input type="text" class="input" name="email" style="text-align: right;">
					<label style="width: 10px;">@</label> 
					<select class="input" name="select">
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
					</select>
				</div>
				<input type="submit" class="button" value="확인">
			</form>
		</div>

		<c:if test="${not empty errorMessagePhone}">
			<p style="color: red; font-weight: bold;">${errorMessagePhone}</p>
		</c:if>
		<div class="type_pcs" style="display: none;">
			<h1 style="margin-top: 30px;">휴대폰 확인</h1>
			<p>휴대폰 확인을 선택하셨습니다.</p>
			<p>가입당시 이름과 휴대폰번호를 입력 후 확인을 눌러주세요.</p>

			<form action="/ex/find/idInquiryDB?type=phone" method="post">
				<div class="input-container">
					<label>이름</label> 
					<input type="text" class="input" name="u_name" value="${UserDto_list.u_name }" /><br> 
				</div>
				<div class="input-container">
					<label>휴대폰 번호</label>
					<input type="text" class="input" name="phoneNumber1" style="text-align: right;"> - 
					<input type="text" class="input" name="phoneNumber2" style="text-align: center;"> - 
					<input type="text" class="input" name="phoneNumber3">
				</div>
					 
				<input type="submit" class="button" value="확인">
			</form>
		</div>


	</div>


</body>
</html>