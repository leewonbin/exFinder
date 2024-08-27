<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<style>
#main {
	display: flex; /* Flexbox를 사용하여 수평 정렬 */
	justify-content: space-between; /* 왼쪽과 오른쪽 섹션 사이에 공간을 추가 */
	align-items: flex-start; /* 상단을 기준으로 정렬 */
	width: 100%; /* 부모 요소의 너비를 가득 채움 */
	height: 100%; /* 필요한 경우 전체 높이를 지정 */
}

#left_main {
	width: 48%; /* 왼쪽 섹션의 너비를 48%로 설정 */
	background-color: #f0f0f0; /* 테스트를 위한 배경색 */
}

#right_main {
	width: 48%; /* 오른쪽 섹션의 너비를 48%로 설정 */
	background-color: #e0e0e0; /* 테스트를 위한 배경색 */
}

.sidebar_menu {
	width: 400px; /* 너비 설정 */
	height: 100vh; /* 높이를 화면 전체에 맞춤 */
	background-color: #ffffff; /* 배경색을 하얀색으로 설정 */
	border-left: 1px solid #ddd; /* 왼쪽 선 */
	border-right: 1px solid #ddd; /* 오른쪽 선 */
	box-shadow: 4px 0 8px rgba(0, 0, 0, 0.2); /* 오른쪽에 그림자 효과 추가 */
	position: fixed; /* 화면에 고정되도록 설정 */
	top: 0; /* 상단에 고정 */
	left: 350px; /* 왼쪽에 고정 */
	z-index: 1000; /* 다른 요소들보다 위에 표시 */
	
}

.menu_logo {
	width: 160px;
	height: auto;
	display: block; /* 이미지가 인라인 요소가 아닌 블록 요소로 처리되도록 설정 */
	margin: 20px 220px 20px 20px; /* 상하로 20px, 좌로 20px, 우로 120px을 추가 */
	cursor: pointer;
}

.menu_user {
	width: 200px;
	height: auto;
	display: block; /* 이미지가 인라인 요소가 아닌 블록 요소로 처리되도록 설정 */
	margin: 0 auto; /* 수평 중앙 정렬 */
	cursor: pointer;
}

.all_info {
	display: flex; /* 플렉스박스 사용 */
	flex-direction: column; /* 수직 정렬 */
	align-items: center; /* 수평 중앙 정렬 */
	justify-content: center; /* 수직 중앙 정렬 */
	margin-bottom: 50px; /* 아래쪽 여백 추가 */
}

.user_info {
	font-size: 30px; /* 글씨 크기 조정 */
	font-weight: bold; /* 글씨 굵기 조정 */
	margin-bottom: 10px; /* 아래쪽 여백 추가 */
}

.email_info {
	font-size: 15px; /* 글씨 크기 작게 조정 */
	color: #303030; /* 글자 색상을 회색으로 설정 */
}

.menu_left {
	width: 360px; /* 메뉴 너비 설정 */
	
	border-bottom: 1px solid #ddd; /* 맨 밑에 실선 추가 */
	margin: 0 20px; /* 좌우 여백 설정 */
}
.menu_left ul {
	list-style-type: none; /* 기본 목록 스타일 제거 */
	padding: 0; /* 패딩 제거 */
	margin: 0; /* 마진 제거 */
}

.menu_left li {
	padding:  0; /* 항목 패딩 */
	font-family: Arial, sans-serif; /* 글꼴 설정 */
	font-size: 24px; /* 글꼴 크기 설정 */
	margin-bottom: 20px; /* 아래쪽 여백 추가 */
}
.mini_header {
	display: flex; /* 플렉스박스를 사용하여 수평 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: flex-end; /* 오른쪽 끝에 정렬 */
    padding: 10px; /* 패딩 추가 (필요에 따라 조정) */
    margin-top: 20px; /* 윗쪽 여백 추가 */
}
.mini_header img {
	width: auto;
	height: 30px;
	margin: 0 4px; /* 이미지 사이의 간격 (필요에 따라 조정) */
	cursor: pointer;
}
.mini_header p {
    margin: 0 5px; /* 텍스트와 이미지 사이의 간격 (필요에 따라 조정) */
    font-size: 16px; /* 텍스트 크기 설정 (필요에 따라 조정) */
    font-weight: bold; /* 텍스트를 강조 (선택 사항) */
}
.right_menu {
	width: 800px; /* 너비 설정 */
	height: 100vh; /* 높이를 화면 전체에 맞춤 */
	background-color: #ffffff; /* 배경색을 하얀색으로 설정 */
	border-left: 1px solid #ddd; /* 왼쪽 선 */
	border-right: 1px solid #ddd; /* 오른쪽 선 */
	
	position: fixed; /* 화면에 고정되도록 설정 */
	top: 0; /* 상단에 고정 */
	left: 800px; /* 왼쪽에 고정 */
	z-index: 1000; /* 다른 요소들보다 위에 표시 */
	
}
</style>
</head>
<body>
	<div id="main">
		<div id="left_main">
			<div class="sidebar_menu">
				<img class="menu_logo" src="${pageContext.request.contextPath}/resources/img/logo-Photoroom.png" onclick="location.href='/ex/'"> 
				<img class="menu_user" src="${pageContext.request.contextPath}/resources/img/user.png" onclick="">
				<div class="all_info">
					<p class="user_info">${dto.u_nickname}</p>
					<p class="email_info">${dto.u_email}</p>
				</div>
				<div class="menu_left">
					<ul>
						<li>내 프로필</li>
						<li>회원 정보 수정</li>
						<li>비밀번호 변경</li>
					</ul>
				</div>
			</div>
			
		</div>
		<div id="right_main">
			<div class="right_menu">
				<div class="mini_header">
					<img src="${pageContext.request.contextPath}/resources/img/user.png" onclick="">
					<p>${dto.u_nickname}</p>
					<img src="${pageContext.request.contextPath}/resources/img/Pboard.png" onclick="">
					<img src="${pageContext.request.contextPath}/resources/img/Palarm.png" onclick="">
					<img src="${pageContext.request.contextPath}/resources/img/Pbookmark.png" onclick="">
				</div>
				<div class="my_info" >
				</div>
			</div>
		</div>
	</div>
<body>
</html>