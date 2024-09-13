<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="logout-status"
	content="${sessionScope.userId == null ? 'logged-out' : 'logged-in'}">
<title></title>

</head>
<body>
 	<h2>댓글 작성</h2>

    <c:choose>
        <c:when test="${sessionScope.dto eq null}">
            <p>로그인 후 댓글 작성이 가능합니다.</p>
        </c:when>
        <c:otherwise>
            <form action="${pageContext.request.contextPath}/comments/create" method="post">
                <input type="hidden" name="b_id" value="${param.b_id}">
                <textarea name="comm_content" placeholder="댓글을 입력하세요..." required></textarea>
                <button type="submit">댓글 등록</button>
            </form>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/board/read?b_id=${param.b_id}">게시글로 돌아가기</a>
</body>
</html>
