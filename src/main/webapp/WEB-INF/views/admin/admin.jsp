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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_board.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_cs.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_auth.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_users.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/exchangeUpdate.js"></script>
	
</head>
<style>
</style>
<body>
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
						<li><a href="#" onclick="reg_type_select('1'); return false;" id="profile-link">계정정보 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('2'); return false;" id="info-link">계정권한 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('3'); return false;" id="password-link">고객센터 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('4'); return false;" id="board-link">게시판 관리</a></li>
        				<li><a href="#" onclick="reg_type_select('5'); return false;" id="cancel-account">환율 업데이트</a></li>
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
		
				<div class="my_info type_2" style="display: none; height: auto;">
				    <h2 class="profile-title">계정 권한</h2>
				    <table class="user-table" id="auth-table">
				        <thead>
				            <tr>
				                <th style="width:200px">아이디</th>
				                <th style="width:150px">권한</th>
				                <th style="width:100px">작업</th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:forEach var="auth" items="${authorityList}">
				                <tr class="auth">
				                    <td style="font-size:20px; font-weight:700px;">${auth.u_id}</td>
				                    <td>
				                    	<form action="${pageContext.request.contextPath}/admin/updateAuthority" method="post">
				                            <input type="hidden" name="u_id" value="${auth.u_id}" />
				                            <select name="authority" class="selectA">
				                                <option value="ROLE_ADMIN" <c:if test="${auth.authority == 'ROLE_ADMIN'}">selected</c:if>>관리자</option>
				                                <option value="ROLE_MEMBER" <c:if test="${auth.authority == 'ROLE_MEMBER'}">selected</c:if>>일반회원</option>
				                            </select>
				                    </td>
				                    <td><input type="submit" value="변경" /></td>
				                   		</form> 
				                </tr>
				            </c:forEach>
				        </tbody>
				    </table>
				    <!-- 페이징 버튼 -->
					<div id="pagination">
					    <button id="firstAuth">&laquo;</button>
					    <button id="prevAuth">&lt;</button>
					    <span id="pageAuthNumbers"></span>
					    <button id="nextAuthPage">&gt;</button>
					    <button id="lastAuthPage">&raquo;</button>
					</div>
				    
				</div>

			<div class="my_info type_3" style="display: none; height:auto;" >
				<h2 class="profile-title">고객센터</h2>
					<div class="content">
						<table id="cs" class="user-table">
							<thead>
								<tr>
									<th style="width:100px;">NO.</th>
									<th style="width:300px;">제목</th>
									<th style="width:100px;">관리자ID</th>
									<th style="width:200px;">글 상태</th>
	
								</tr>
							</thead>
							<tbody>
								<c:forEach var="csDto" items="${list}">
									<tr>
										<td>${csDto.cs_id}</td>
										<td><a href="/ex/cs/read?cs_id=${csDto.cs_id}">${csDto.cs_title}</a></td>
										<td>${csDto.u_id}</td>
										<!-- 상태 변경 폼 -->
										<td>
										    <form action="${pageContext.request.contextPath}/cs/updateStatus" method="post">
										        <input type="hidden" name="cs_id" value="${csDto.cs_id}" />
										        <select name="cs_state">
										            <option value="1" <c:if test="${csDto.cs_state == 1}">selected</c:if>>활성화</option>
										            <option value="0" <c:if test="${csDto.cs_state == 0}">selected</c:if>>비활성화</option>
										        </select>
										        <input type="submit" value="변경" />
										    </form>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
	
					<div class="box-footer">
					    <button type="submit" class="writeBtn" onclick="location.href='/ex/cs/create'">글쓰기</button>
					</div>
					
					<!-- 페이징 버튼 -->
					<div id="pagination">
					    <button id="firstPage">&laquo;</button>
					    <button id="prevPage">&lt;</button>
					    <span id="pageNumbers"></span>
					    <button id="nextPage">&gt;</button>
					    <button id="lastPage">&raquo;</button>
					</div>

					
					

			</div>
			<div class="my_info type_4" style="display: none; height: auto;">
				<h2 class="profile-title">게시판 관리</h2>
					<table border="1" class="user-table" id="boardTable">
					    <thead>
					        <tr>
					            <th style="width:100px;">게시판 번호</th>
					            <th style="width:300px;">제목</th>
					            <th style="width:100px;">작성자</th>
					            <th style="width:100px;">활성화 여부</th>
					            <th style="width:50px;">게시글 삭제</th>
					        </tr>
					    </thead>
					    <tbody id="boardBody">
					        <!-- 게시판 목록 출력 -->
					        <c:forEach var="board" items="${boardList}">
					            <tr>
					                <td>${board.b_id}</td>
					                <td>${board.b_title}</td>
					                <td>${board.u_id}</td>
					                <td>
					                    <form action="${pageContext.request.contextPath}/admin/updateBoardStatus" method="post">
					                        <input type="hidden" name="b_id" value="${board.b_id}" />
					                        <select name="b_del">
					                            <option value="Y" <c:if test="${board.b_del == 'Y'}">selected</c:if>>Y</option>
					                            <option value="N" <c:if test="${board.b_del == 'N'}">selected</c:if>>N</option>
					                        </select>
					                        <input type="submit" value="변경" />
					                    </form>
					                </td>
					                <td>
					                    <form action="${pageContext.request.contextPath}/admin/deleteBoardAdmin" method="post" style="display:inline;">
					                        <input type="hidden" name="b_id" value="${board.b_id}" />
					                        <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
					                    </form>
					                </td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
					
			<!-- 페이징 버튼 -->
			    <div id="pagination">
			        <button id="boardFirst" disabled>&laquo;</button>
			        <button id="boardPrev" disabled>&lt;</button>
			        <div id="boardPageButtons"></div>
			        <button id="boardNext">&gt;</button>
			        <button id="boardLast">&raquo;</button>
			    </div>				    				
								
			</div>

			<div class="my_info2 type_5" style="display: none; height: 550px;">
				<h2 class="profile-title">환율 업데이트</h2>
					<div class="update-section">
					    <p class="update-description">통화 1년치 내역 업데이트</p>
					    <button class="update-btn">업데이트</button>
					    <p class="result_p"></p>
					</div>

						
					
								
			</div>
		</div>
	</div>
</body>
<script>

</script>
</html>