<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardRead.css">
    <script src="${pageContext.request.contextPath}/resources/js/boardRead.js"></script>

</head>
<body>
	<div>
		<%@include file="../header/exFinder_header.jsp"%>

		<!-- 알림을 표시할 div -->
		<div id="alramContainer" style="display: none;"></div>
	</div>

	<div class="main">

		<form role="form" method="post">
			<input type='hidden' name='b_id' value="${boardDto.b_id}">
		</form>

		<h2 class="b_category">
			<input type="text" name='b_category' style="width: 20%"
				value="${boardDto.b_category}" readonly="readonly">
		</h2>

		<h2 class="b_title">
			<input type="text" name='b_title' style="width: 100%"
				value="${boardDto.b_title}" readonly="readonly">
		</h2>

		<h2 class="u_id">
			<input type="text" name="u_id" style="width: 20%"
				value="${boardDto.u_id}" readonly="readonly">
		</h2>

		<h2 class="u_date">
			<input type="text" name="u_date" style="width: 20%"
				value="<fmt:formatDate value='${boardDto.b_date}' pattern='yyyy-MM-dd HH:mm'/>"
				readonly="readonly">
		</h2>

		<h2 class="b_content">
			<textarea style="width: 100%" name="b_content" rows="35"
				readonly="readonly">${boardDto.b_content}</textarea>
		</h2>

		<div class="box-footer">
			<c:if test="${sessionScope.dto != null}">
				<c:choose>
					<c:when test="${sessionScope.dto.u_id == boardDto.u_id}">
						<!-- 게시글 작성자인 경우 -->
						<button type="button" class="btn btn-warning"
							onclick="location.href='/ex/board/update?b_id=${boardDto.b_id}'">수정</button>
						<button type="button" class="btn btn-danger"
							onclick="confirmBoardDelete('${boardDto.b_id}')">삭제</button>
					</c:when>
					<c:otherwise>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<!-- 관리자인 경우 -->
							<button type="button" class="btn btn-danger"
								onclick="confirmBoardDelete('${boardDto.b_id}')">삭제</button>
						</sec:authorize>
					</c:otherwise>
				</c:choose>
			</c:if>
			<button type="button" class="btn btn-primary"
				onclick="location.href='/ex/board/listAll'">목록</button>
		</div>


		<div class="horizontal-line"></div>

		<c:choose>
			<c:when test="${sessionScope.dto eq null}">
				<p>로그인 후 댓글 작성 가능 합니다.</p>
			</c:when>
			<c:otherwise>
				<div class="comment-container">
					<form action="/ex/comments/create" method="post">
						<input type="hidden" name="b_id" value="${boardDto.b_id}" />
						<div>
							<textarea name="comm_content" required placeholder="댓글을 남겨보세요."></textarea>
							<button type="submit">등록</button>
						</div>
					</form>
				</div>
			</c:otherwise>
		</c:choose>

		<div id="comments">
			<c:if test="${not empty comments}">
				<%@include file="comment.jsp"%>
			</c:if>
		</div>
	</div>
	<%@include file="/WEB-INF/views/footer/exFinder_footer.jsp"%>
</body>
</html>
