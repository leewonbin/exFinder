<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExFinder</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/exchangeUpdate.js"></script>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const rowsPerPage = 6; // 한 페이지에 보여줄 행 수
	    let currentBoardPage = 1;
	    const boardRows = document.querySelectorAll("#boardBody tr"); // 모든 데이터 행

	    // 전체 페이지 수 계산
	    const totalBoardPages = Math.ceil(boardRows.length / rowsPerPage);

	    function displayBoardTable(page) {
	        const start = (page - 1) * rowsPerPage;
	        const end = start + rowsPerPage;

	        // 테이블 행을 모두 숨긴 후 해당 페이지의 행만 보이게 함
	        boardRows.forEach((row, index) => {
	            row.style.display = (index >= start && index < end) ? "" : "none";
	        });

	        // 페이지 버튼 동적 생성
	        createBoardPageButtons();

	        // 버튼 상태 업데이트
	        document.getElementById('boardPrev').disabled = (page === 1);
	        document.getElementById('boardFirst').disabled = (page === 1);
	        document.getElementById('boardNext').disabled = (page === totalBoardPages);
	        document.getElementById('boardLast').disabled = (page === totalBoardPages);

	        // 버튼 보이기/숨기기
	        document.getElementById('boardFirst').style.display = (page === 1) ? 'none' : 'inline-block';
	        document.getElementById('boardPrev').style.display = (page === 1) ? 'none' : 'inline-block';
	        document.getElementById('boardNext').style.display = (page === totalBoardPages) ? 'none' : 'inline-block';
	        document.getElementById('boardLast').style.display = (page === totalBoardPages) ? 'none' : 'inline-block';
	    }

	    // 페이지 번호 버튼을 동적으로 생성하는 함수
	    function createBoardPageButtons() {
	        const boardPageButtonsDiv = document.getElementById("boardPageButtons");
	        boardPageButtonsDiv.innerHTML = ""; // 기존 버튼들을 모두 제거

	        const groupSize = 10; // 그룹당 버튼 수
	        const currentGroup = Math.ceil(currentBoardPage / groupSize);
	        const startPage = (currentGroup - 1) * groupSize + 1;
	        const endPage = Math.min(startPage + groupSize - 1, totalBoardPages);

	        // 버튼 생성
	        for (let i = startPage; i <= endPage; i++) {
	            const pageButton = document.createElement("button");
	            pageButton.textContent = i;
	            pageButton.classList.add("page-btn");

	            if (i === currentBoardPage) {
	                pageButton.classList.add("active");
	            }

	            // 페이지 버튼 클릭 이벤트
	            pageButton.addEventListener("click", function () {
	                currentBoardPage = i;
	                displayBoardTable(currentBoardPage);
	            });

	            boardPageButtonsDiv.appendChild(pageButton);
	        }
	    }

	    // 이전 버튼 클릭 이벤트
	    document.getElementById('boardPrev').addEventListener('click', function () {
	        if (currentBoardPage > 1) {
	            currentBoardPage--;
	            displayBoardTable(currentBoardPage);
	        }
	    });

	    // 다음 버튼 클릭 이벤트
	    document.getElementById('boardNext').addEventListener('click', function () {
	        if (currentBoardPage < totalBoardPages) {
	            currentBoardPage++;
	            displayBoardTable(currentBoardPage);
	        }
	    });

	    // 첫 페이지 버튼 클릭 이벤트
	    document.getElementById('boardFirst').addEventListener('click', function () {
	        currentBoardPage = 1;
	        displayBoardTable(currentBoardPage);
	    });

	    // 마지막 페이지 버튼 클릭 이벤트
	    document.getElementById('boardLast').addEventListener('click', function () {
	        currentBoardPage = totalBoardPages;
	        displayBoardTable(currentBoardPage);
	    });

	    // 초기 테이블 및 버튼 표시
	    displayBoardTable(currentBoardPage);
	});

	</script>
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
			<div class="my_info type_1">
				<h2 class="profile-title">계정 목록</h2>
				<form id="updateForm"
					action="${pageContext.request.contextPath}/admin/updateUser"
					method="post" style="display: none;">
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
			</div>
		
				<div class="my_info type_2" style="display: none;">
				    <h2 class="profile-title">계정 권한</h2>
				    <table class="user-table">
				        <thead>
				            <tr>
				                <th>아이디</th>
				                <th>권한</th>
				                <th>작업</th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:forEach var="auth" items="${authorityList}">
				                <tr>
				                    <td>${auth.u_id}</td>
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
				</div>

			<div class="my_info type_3" style="display: none;">
				<h2 class="profile-title">고객센터</h2>
					<div class="content">
						<table id="cs" class="user-table">
							<thead>
								<tr>
									<th style="width: 20px;">NO.</th>
									<th style="width: 200px;">제목</th>
									<th style="width: 30px;">관리자ID</th>
									<th style="width: 30px;">글 상태</th>
	
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
						<button type="submit" class="writeBtn"onclick="location.href='/ex/cs/create'">글쓰기</button>
					</div>


			</div>
			<div class="my_info type_4" style="display: none; height: 550px;">
				<h2 class="profile-title">게시판 관리</h2>
					<table border="1" class="user-table" id="boardTable">
					    <thead>
					        <tr>
					            <th>게시판 번호</th>
					            <th>제목</th>
					            <th>작성자</th>
					            <th>활성화 여부</th>
					            <th>게시글 삭제</th>
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
					
					<div id="pagination">
					    <button id="boardFirst" disabled>&laquo;</button>
					    <button id="boardPrev" disabled>&lt;</button>
					    <span id="boardPageInfo"></span>
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