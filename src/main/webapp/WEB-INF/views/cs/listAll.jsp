<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="logout-status"
	content="${sessionScope.userId == null ? 'logged-out' : 'logged-in'}">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/js/listAllJs.js"></script>
<body>

	<h1>cs 문의글 목록 화면임</h1>
    <table border="1">
        <thead>
            <tr>
                <th>NO.</th>
                <th>상태</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>답변완료일</th>

            </tr>
        </thead>
        <tbody>
            <c:forEach var="csDto" items="${list}">
                <tr>
                    <td>${csDto.cs_id}</td>
                    <td>${csDto.cs_status}</td>
                    <td><a href="/ex/cs/read?cs_id=${csDto.cs_id}">${csDto.cs_title}</a></td>
                    <td>${csDto.u_id}</td>
                    <td><fmt:formatDate value="${csDto.cs_date}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${csDto.resolved_date}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <a href="/ex/cs/main">메인</a>
</body>
</html>

