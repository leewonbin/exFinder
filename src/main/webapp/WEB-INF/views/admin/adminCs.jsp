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
	<script src="${pageContext.request.contextPath}/resources/js/admin_cs.js"></script>
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
						<li><a href="${pageContext.request.contextPath}/admin/adminUserinfo" id="profile-link">계정정보 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminAuthority" id="info-link">계정권한 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminCs" id="password-link" style="font-weight: bold;">고객센터 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminBoard" id="board-link">게시판 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminUpdateEx" id="cancel-account">환율 업데이트</a></li>
					</ul>
				</div>
				
			</div>
			
		</div>
		
	</div>
	<div id="right_main">
		<div class="right_menu">
			<div class="my_info type_3" style="height: auto;">
				<h2 class="profile-title">고객센터</h2>
				<div class="content">
					<table id="cs" class="user-table">
						<thead>
							<tr>
								<th style="width: 100px;">NO.</th>
								<th style="width: 300px;">제목</th>
								<th style="width: 100px;">관리자ID</th>
								<th style="width: 200px;">글 상태</th>

							</tr>
						</thead>
						<tbody>
							<c:forEach var="csDto" items="${list}">
								<tr>
									<td>${csDto.cs_id}</td>
									<td><a href="/ex/cs/read?cs_id=${csDto.cs_id}"
										class="csTitle">${csDto.cs_title}</a></td>
									<td>${csDto.u_id}</td>
									<!-- 상태 변경 폼 -->
									<td>
										<form
											action="${pageContext.request.contextPath}/cs/updateStatus"
											method="post">
											<input type="hidden" name="cs_id" value="${csDto.cs_id}" />
											<select name="cs_state">
												<option value="1"
													<c:if test="${csDto.cs_state == 1}">selected</c:if>>활성화</option>
												<option value="0"
													<c:if test="${csDto.cs_state == 0}">selected</c:if>>비활성화</option>
											</select> <input type="submit" value="변경" />
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="box-footer">
					<button type="submit" class="writeBtn"
						onclick="location.href='/ex/cs/create'">글쓰기</button>
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
		</div>
	</div>
</body>
<script>

</script>
</html>