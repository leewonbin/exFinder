<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<script src="${pageContext.request.contextPath}/resources/js/admin_users.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	
</head>
<style>
</style>
<body>
	<!-- 메시지 표시 부분 -->
	<script>
        // 페이지 로드 후 메시지 출력
        window.onload = function() {
            <c:if test="${not empty message}">
                alert('${message}');
            </c:if>
        }
    </script>

	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

	<!-- 알림을 표시할 div -->
	<div id="alramContainer" style="display: none;"></div>
		
	<div id="main">
		<div id="left_main">
			<div class="sidebar_menu">		
				<c:choose>
    				<c:when test="${not empty dto.u_profile_img}">
    					<div class="menu_user_container">
        					<img class="menu_user" src="${pageContext.request.contextPath}/resources/profile_img/${dto.u_profile_img}">
        				</div>
    				</c:when>
    				<c:otherwise>
    					<div class="menu_user_container">
        					<img class="menu_user" src="${pageContext.request.contextPath}/resources/img/user.png">
        				</div>
    				</c:otherwise>
				</c:choose>
				
				<div class="all_info">
					<p class="user_info">관리자 옵션</p>
				</div>
				<div class="menu_left">
					<ul>
						<li><a href="${pageContext.request.contextPath}/admin/adminUserinfo" id="profile-link" style="font-weight: bold;">계정정보 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminAuthority" id="info-link">계정권한 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminCs" id="password-link">고객센터 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminBoard" id="board-link">게시판 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminUpdateEx" id="cancel-account">환율 업데이트</a></li>
					</ul>
				</div>
				
			</div>
			
		</div>
		
	</div>
	<div id="right_main">
		<div class="right_menu">
			<div class="my_info type_1" style= "height: auto;">
				<h2 class="profile-title">계정 목록</h2>
				<form id="updateForm"
					action="${pageContext.request.contextPath}/admin/updateUser"
					method="post" style="display: none; ">
					<input type="hidden" name="u_id" id="u_id"> 
					<input type="hidden" name="u_nickname" id="u_nickname"> 
					<input type="hidden" name="u_name" id="u_name"> 
					<input type="hidden" name="u_gender" id="u_gender"> 
					<input type="hidden" name="u_email" id="u_email"> 
					<input type="hidden" name="u_phoneNumber" id="u_phoneNumber"> 
					<input type="hidden" name="u_address" id="u_address">
					<input type="hidden" name="u_birthday" id="u_birthday">
				</form>

				<!-- 기존 테이블 코드 유지 -->
				<table class="user-table" id="users-table">
					<thead>
						<tr>
							<th>아이디</th>
							<th>닉네임</th>
							<th>이름</th>
							<th>성별</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>주소</th>
							<th>생년월일</th>
							<th>가입 날짜</th>
							<th>작업</th>
							<th>계정 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${userList}">
							<tr>
								<td>${user.u_id}</td>
								<td><input type="text" value="${user.u_nickname}"
									data-field="u_nickname" class="u_nickname" /></td>
								<td><input type="text" value="${user.u_name}"
									data-field="u_name" class="u_name"/></td>
								<td><select data-field="u_gender">
										<option value="남성"
											<c:if test="${user.u_gender == '남성'}">selected</c:if>>남성</option>
										<option value="여성"
											<c:if test="${user.u_gender == '여성'}">selected</c:if>>여성</option>
								</select></td>
								<td><input type="email" value="${user.u_email}"
									data-field="u_email" /></td>
								<td><input type="text" value="${user.u_phoneNumber}"
									data-field="u_phoneNumber" class="u_phoneNumber" /></td>
								<td><input type="text" value="${user.u_address}"
									data-field="u_address" /></td>
								<td><input type="date" value="${user.u_birthday}"
									data-field="u_birthday" /></td>
								<td>${user.u_joinDate}</td>
								<td>
									<button onclick="submitForm('${user.u_id}', this)" class="storageBtn">저장</button>
								</td>
								<!-- 상태 변경 폼 -->
								<td>
									<form
										action="${pageContext.request.contextPath}/admin/updateStatus"
										method="post">
										<input type="hidden" name="u_id" value="${user.u_id}" /> <select
											name="enabled">
											<option value="1"
												<c:if test="${user.enabled == 1}">selected</c:if>>활성화</option>
											<option value="0"
												<c:if test="${user.enabled == 0}">selected</c:if>>비활성화</option>
										</select> <input type="submit" value="변경" />
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<!-- 페이징 버튼 -->
					<div id="pagination">
					    <button id="firstUsers">&laquo;</button>
					    <button id="prevUsers">&lt;</button>
					    <span id="pageUsersNumbers"></span>
					    <button id="nextUsersPage">&gt;</button>
					    <button id="lastUsersPage">&raquo;</button>
					</div>
			</div>
		
				
			</div>
		</div>
	
</body>
<script>

</script>
</html>