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
	<script src="${pageContext.request.contextPath}/resources/js/admin_board.js"></script>
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
        				<li><a href="${pageContext.request.contextPath}/admin/adminCs" id="password-link">고객센터 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminBoard" id="board-link" style="font-weight: bold;">게시판 관리</a></li>
        				<li><a href="${pageContext.request.contextPath}/admin/adminUpdateEx" id="cancel-account">환율 업데이트</a></li>
					</ul>
				</div>
				
			</div>
			
		</div>
		
	</div>
	<div id="right_main">
		<div class="right_menu">
			<div class="my_info type_4" style=" height: auto;">
				<h2 class="profile-title">게시판 관리</h2>
				<table border="1" class="user-table" id="boardTable">
					<thead>
						<tr>
							<th style="width: 100px;">게시판 번호</th>
							<th style="width: 300px;">제목</th>
							<th style="width: 100px;">작성자</th>
							<th style="width: 100px;">비활성화 여부</th>
							<th style="width: 50px;">게시글 삭제</th>
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
									<form
										action="${pageContext.request.contextPath}/admin/updateBoardStatus"
										method="post">
										<input type="hidden" name="b_id" value="${board.b_id}" /> <select
											name="b_del">
											<option value="Y"
												<c:if test="${board.b_del == 'Y'}">selected</c:if>>Y</option>
											<option value="N"
												<c:if test="${board.b_del == 'N'}">selected</c:if>>N</option>
										</select> <input type="submit" value="변경" />
									</form>
								</td>
								<td>
									<form
										action="${pageContext.request.contextPath}/admin/deleteBoardAdmin"
										method="post" style="display: inline;">
										<input type="hidden" name="b_id" value="${board.b_id}" /> <input
											type="submit" value="삭제"
											onclick="return confirm('정말 삭제하시겠습니까?');" />
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




		</div>
	</div>
</body>
<script>

</script>
</html>