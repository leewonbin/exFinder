<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 게시판</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myBoard.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/myBoard.js"></script>
</head>
<body>
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

    <div id="board">
        <h1>나의 게시판</h1>

        <form id="deletePostsForm" method="post" action="/ex/user/deleteMyBoard">
            <table class="board-table">
                <thead>
                    <tr class="board-header">
                        <th>
                            <input type="checkbox"   id="selectAll" onclick="selectAllCheckboxes(this.checked)"> <!-- 전체 선택 체크박스 -->
                        </th>
                        <th class="Hcategory">카테고리</th>
                        <th class="Htitle">제목</th>
                        <th class="HwroteDate">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="post" items="${userPosts}">
                        <tr class="board-item">
                            <td>
                                <input type="checkbox" class="checkbox" name="b_id" value="${post.b_id}">
                            </td>
                            <td class="category">${post.b_category}</td>
                            <td class="title">
                                <a href="/ex/board/read?b_id=${post.b_id}">${post.b_title}</a>
                            </td>
                            <td class="wroteDate">
                                <fmt:formatDate value="${post.b_date}" pattern="yyyy-MM-dd"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <ul class="button-container">
                <li class="button-write" onclick="submitDeleteForm()">
                    <span>삭제</span>
                </li>
            </ul>
        </form>
    </div>

    <script>
        function selectAllCheckboxes(checked) {
            // 체크박스 선택 상태에 따라 모든 체크박스 상태 변경
            const checkboxes = document.querySelectorAll('input[name="b_id"]');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = checked;
            });
        }
    </script>
</body>
</html>
