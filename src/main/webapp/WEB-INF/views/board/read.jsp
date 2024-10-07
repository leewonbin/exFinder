<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExFinder</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boardRead.css">
<script
	src="${pageContext.request.contextPath}/resources/js/boardRead.js"></script>
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
			<c:if
				test="${sessionScope.dto != null && sessionScope.dto.u_id == boardDto.u_id}">
				<button type="button" class="btn btn-warning"
					onclick="location.href='/ex/board/update?b_id=${boardDto.b_id}'">수정</button>
				<button type="button" class="btn btn-danger"
					onclick="confirmBoardDelete('${boardDto.b_id}')">삭제</button>
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
				<c:forEach var="comment" items="${comments}">
					<div style="margin-bottom: 5px;">
						<!-- 댓글 윗 부분 -->
						<p style="margin-bottom: 10px;">
							<strong style="font-weight: bold;">${comment.u_id}</strong>
							<c:if test="${sessionScope.dto.u_id == comment.u_id }">
								<button class="btn btn-secondary"
									onclick="toggleButtons('${comment.comm_id}')">≡</button>
							</c:if>
							<c:if test="${sessionScope.dto ne null }">
								<button class="btn btn-secondary"
									onclick="toggleRecomm('${comment.comm_id}')">↲</button>
							</c:if>
						</p>
						<p style="margin-left: 10px;">${comment.comm_content}</p>
						<p style="margin-left: 10px; margin-top: 10px; font-size: 13px;">
							<c:if test="${comment.comm_date != null}">
								<fmt:formatDate value='${comment.comm_date}'
									pattern="yyyy-MM-dd HH:mm" />
							</c:if>
						</p>
						<!-- 작성자 수정 및 삭제 DIV -->
						<div id="buttons-${comment.comm_id}"
							style="display: none; text-align: right;">
							<form action="/ex/comments/update" method="post"
								style="display: inline;">
								<input type="hidden" name="comm_id" value="${comment.comm_id}" />
								<input type="hidden" name="b_id" value="${boardDto.b_id}" />
								<textarea class="update-content" name="comm_content" required>${comment.comm_content}</textarea>
								<button type="submit" class="btn btn-warning">수정</button>
							</form>
							<form action="/ex/comments/delete" method="post"
								style="display: inline;" onsubmit="return confirmDelete();">
								<input type="hidden" name="comm_id" value="${comment.comm_id}" />
								<input type="hidden" name="b_id" value="${boardDto.b_id}" />
								<button type="submit" class="btn btn-danger">삭제</button>
							</form>
						</div>
						<!-- 답글 DIV -->
						<div id="reCommDiv-${comment.comm_id}"
							style="display: none; text-align: right;">
							<form action="/ex/comments/reComment" method="post"
								style="display: inline;">
								<input type="hidden" name="comm_id" value="${comment.comm_id}" />
								<input type="hidden" name="b_id" value="${boardDto.b_id}" />
								<textarea class="update-content" name="comm_content"
									placeholder="답글을 입력해주세요." required></textarea>
								<button type="submit" class="btn btn-warning">등록</button>
							</form>
						</div>
						<!-- 대댓글 위치 -->
						<c:if test="${comment.reply ne null }">
							<div id="replySection-${comment.comm_id }"
								style="margin-bottom: 5px; border: none;">
								<c:forEach var="reply" items="${comment.reply }">
									<div class="replyElements">
										<p style="margin-bottom: 10px;">
											<strong style="font-weight: bold;">↳&nbsp;
												${reply.u_id}</strong>
											<c:if test="${sessionScope.dto.u_id == reply.u_id }">
												<button class="btn btn-secondary"
													onclick="toggleButtons('${reply.comm_id}')">≡</button>
											</c:if>
										</p>
										<p style="margin-left: 10px;">${reply.comm_content}</p>
										<p
											style="margin-left: 10px; margin-top: 10px; font-size: 13px;">
											<c:if test="${reply.comm_date != null}">
												<fmt:formatDate value='${reply.comm_date}'
													pattern="yyyy-MM-dd HH:mm" />
											</c:if>
										</p>
										<div id="buttons-${reply.comm_id}"
											style="display: none; text-align: right;">
											<form action="/ex/comments/update" method="post"
												style="display: inline;">
												<input type="hidden" name="comm_id"
													value="${reply.comm_id}" /> <input type="hidden"
													name="b_id" value="${boardDto.b_id}" />
												<textarea class="update-content" name="comm_content"
													required>${reply.comm_content}</textarea>
												<button type="submit" class="btn btn-warning">수정</button>
											</form>
											<form action="/ex/comments/delete" method="post"
												style="display: inline;" onsubmit="return confirmDelete();">
												<input type="hidden" name="comm_id"
													value="${reply.comm_id}" /> <input type="hidden"
													name="b_id" value="${boardDto.b_id}" />
												<button type="submit" class="btn btn-danger">삭제</button>
											</form>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
		</div>
</body>
</html>