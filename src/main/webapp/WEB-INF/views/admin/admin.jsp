<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</head>
<style>
</style>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
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
						<li><a href="#" onclick="reg_type_select('1'); return false;" id="profile-link">계정정보 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('2'); return false;" id="info-link">계정권한 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('3'); return false;" id="password-link">고객센터 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('4'); return false;" id="cancel-account"></a></li>
					</ul>
				</div>
				
			</div>
			
		</div>
		
	</div>
	<div id="right_main">
		<div class="right_menu">
			<div class="my_info type_1">
				<h2 class="profile-title">계정 목록</h2>
				<form id="updateForm"
					action="${pageContext.request.contextPath}/admin/updateUser"
					method="post" style="display: none;">
					<input type="hidden" name="u_id" id="u_id"> <input
						type="hidden" name="u_nickname" id="u_nickname"> <input
						type="hidden" name="u_name" id="u_name"> <input
						type="hidden" name="u_gender" id="u_gender"> <input
						type="hidden" name="u_email" id="u_email"> <input
						type="hidden" name="u_phoneNumber" id="u_phoneNumber"> <input
						type="hidden" name="u_address" id="u_address">
				</form>

				<!-- 기존 테이블 코드 유지 -->
				<table class="user-table">
					<thead>
						<tr>
							<th>아이디</th>
							<th>닉네임</th>
							<th>이름</th>
							<th>성별</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>주소</th>
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
								<td>${user.u_joinDate}</td>
								<td>
									<button onclick="submitForm('${user.u_id}', this)">저장</button>
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
			</div>
		</div>
	</div>
	<div class="my_info2 type_2" style="display: none;" >
					<h2 class="profile-title">계정 권한</h2>
					<c:forEach var="auth" items="${authorityList}">
					    <tr>
					        <td>${auth.u_id}</td>
					        <!-- 권한을 선택할 수 있는 드롭다운 목록 -->
					        <td>
					            <form action="${pageContext.request.contextPath}/admin/updateAuthority" method="post">
					                <input type="hidden" name="u_id" value="${auth.u_id}" />
					                <select name="authority">
					                    <!-- 권한 목록을 생성 -->
					                    <option value="ROLE_ADMIN" <c:if test="${auth.authority == 'ROLE_ADMIN'}">selected</c:if>>
					                      	  관리자
					                    </option>
					                    <option value="ROLE_MEMBER" <c:if test="${auth.authority == 'ROLE_MEMBER'}">selected</c:if>>
					                       	 일반회원
					                    </option>
					                </select>
					                <input type="submit" value="권한 변경" />
					            </form>
					        </td>
					    </tr>
					</c:forEach>


				</div>
				<div class="my_info type_3" style="display: none;">
					<h2 class="profile-title">비밀번호 변경</h2>
					
				</div>
				
				<div class="my_info2 type_4" style="display: none; height: 550px;">
					<h2 class="profile-title">회원 탈퇴</h2>
				
					
								
			</div>
		</div>
	</div>
</body>
<script>

</script>
</html>