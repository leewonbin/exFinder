<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 조회 결과</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/find.css">
	
</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
	<div id="main">
		<h1>아이디 조회 결과</h1>
		
		<div class="id-check-result">
			<p>아이디 찾기가 완료 되었습니다.</p> 
			가입된 아이디가 총 <label><c:out value="${fn:length(UserDto_list)}"/>개</label> 있습니다.
		</div>
		
		<form action="/ex/find/pwInquiry" method="GET">
			<div class="table-container">			
				<table>
	            	<tr> 
	            		<th> </th><th>조회한 결과</th> 
	            	</tr>
					<c:forEach var="UserDto_list" items="${UserDto_list}">
            		<tr> 
            			<td style="background-color: #ddd; padding-right: 10px;">
            				<input type="radio" name="radio" value="${UserDto_list.u_id}"> 
						</td> 
            			<td>아이디 : ${UserDto_list.u_id},  가입 날짜 : ${UserDto_list.u_joinDate}</td> 
            		</tr>
            		</c:forEach>
       			</table>
       		</div>
       		<div class="find-button-container">
       			<button type="submit" name="action" value="login" class="find-button">로그인 하기</button>
       			<button type="submit" name="action" value="pwFind" class="find-button">비밀번호 찾기</button>
       		</div>
       	</form>
		
	</div>
</body>
</html>