<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <c:forEach var="comment" items="${comments}">
                    <div style="margin-bottom: 5px;">
                        <p style="margin-bottom: 10px;">
                            <strong style="font-weight: bold;">${comment.u_id}</strong>
                            <sec:authorize access="hasRole('ROLE_ADMIN') or authentication.name == '${comment.u_id}'">
                                <button class="btn btn-secondary" onclick="toggleButtons('${comment.comm_id}')">≡</button>
                            </sec:authorize>
                            <c:if test="${sessionScope.dto ne null }">
                                <button class="btn btn-secondary" onclick="toggleRecomm('${comment.comm_id}')">↲</button>
                            </c:if>
                        </p>
                        <p style="margin-left: 10px;">${comment.comm_content}</p>
                        <p style="margin-left: 10px; margin-top: 10px; font-size: 13px;">
                            <c:if test="${comment.comm_date != null}">
                                <fmt:formatDate value='${comment.comm_date}' pattern="yyyy-MM-dd HH:mm" />
                            </c:if>
                        </p>
                        <div id="buttons-${comment.comm_id}" style="display: none; text-align: right;">
                            <form action="/ex/comments/update" method="post" style="display: inline;">
                                <input type="hidden" name="comm_id" value="${comment.comm_id}" />
                                <input type="hidden" name="b_id" value="${boardDto.b_id}" />
                                <textarea class="update-content" name="comm_content" required>${comment.comm_content}</textarea>
                                <button type="submit" class="btn btn-warning">수정</button>
                            </form>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <form action="/ex/comments/delete" method="post" style="display: inline;" onsubmit="return confirmDelete();">
                                    <input type="hidden" name="comm_id" value="${comment.comm_id}" />
                                    <input type="hidden" name="b_id" value="${boardDto.b_id}" />
                                    <button type="submit" class="btn btn-danger">삭제</button>
                                </form>
                            </sec:authorize>
                        </div>

                        <!-- 대댓글 섹션 -->
                        <div id="reCommDiv-${comment.comm_id}" style="display: none; text-align: right;">
                            <form action="/ex/comments/reComment" method="post" style="display: inline;">
                                <input type="hidden" name="comm_id" value="${comment.comm_id}" />
                                <input type="hidden" name="b_id" value="${boardDto.b_id}" />
                                <textarea class="update-content" name="comm_content" placeholder="답글을 입력해주세요." required></textarea>
                                <button type="submit" class="btn btn-warning">등록</button>
                            </form>
                        </div>

                        <c:if test="${comment.reply ne null }">
                            <div id="replySection-${comment.comm_id }" style="margin-bottom: 5px; border: none;">
                                <c:forEach var="reply" items="${comment.reply }">
                                    <div class="replyElements">
                                        <p style="margin-bottom: 10px;">
                                            <strong style="font-weight: bold;">↳&nbsp;${reply.u_id}</strong>
                                            <sec:authorize access="hasRole('ROLE_ADMIN') or authentication.name == '${reply.u_id}'">
                                                <button class="btn btn-secondary" onclick="toggleButtons('${reply.comm_id}')">≡</button>
                                            </sec:authorize>
                                        </p>
                                        <p style="margin-left: 10px;">${reply.comm_content}</p>
                                        <p style="margin-left: 10px; margin-top: 10px; font-size: 13px;">
                                            <c:if test="${reply.comm_date != null}">
                                                <fmt:formatDate value='${reply.comm_date}' pattern="yyyy-MM-dd HH:mm" />
                                            </c:if>
                                        </p>
                                        <div id="buttons-${reply.comm_id}" style="display: none; text-align: right;">
                                            <form action="/ex/comments/update" method="post" style="display: inline;">
                                                <input type="hidden" name="comm_id" value="${reply.comm_id}" />
                                                <input type="hidden" name="b_id" value="${boardDto.b_id}" />
                                                <textarea class="update-content" name="comm_content" required>${reply.comm_content}</textarea>
                                                <button type="submit" class="btn btn-warning">수정</button>
                                            </form>
                                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                                <form action="/ex/comments/delete" method="post" style="display: inline;" onsubmit="return confirmDelete();">
                                                    <input type="hidden" name="comm_id" value="${reply.comm_id}" />
                                                    <input type="hidden" name="b_id" value="${boardDto.b_id}" />
                                                    <button type="submit" class="btn btn-danger">삭제</button>
                                                </form>
                                            </sec:authorize>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
</body>
</html>