<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


</head>
<body>	
	<h2>댓글 수정</h2>

    <c:choose>
        <c:when test="${sessionScope.dto eq null}">
            <p>로그인 후 댓글 수정이 가능합니다.</p>
        </c:when>
        <c:otherwise>
            <form action="${pageContext.request.contextPath}/comments/update" method="post">
                <input type="hidden" name="comm_id" value="${comment.comm_id}">
                <input type="hidden" name="b_id" value="${param.b_id}">
                <textarea name="comm_content" required>${comment.comm_content}</textarea>
                <button type="submit">댓글 수정</button>
            </form>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/board/read?b_id=${param.b_id}">게시글로 돌아가기</a>
</body>
</html>
