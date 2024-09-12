<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
<title>뉴스 크롤링</title>
<style>
/* p 태그 스타일 - 국가별 차트 */
.country-chart {
    font-size: 1.1em;
    font-weight: bold;
    margin-left: 325px; /* x 위치 조정 */
    margin-top: 100px; /* p 태그와 div 간의 간격 조정 */
}

/* 구분선 스타일 */
.divider {
    margin: 20px 0; /* 위 아래 여백 */
    border: none;
    height: 1px;
    background-color: #dcdcdc; /* 밝은 회색 구분선 */
}

/* 뉴스 리스트 스타일 */
.news-list {
    margin: 20px 325px;
    font-size: 1.0em;
}

/* 뉴스 항목 스타일 */
.news-item {
    margin-bottom: 15px;
}
</style>

</head>
<body>
    <!-- 국가별 차트 p 태그 -->
    <p class="country-chart">뉴스 크롤링</p>

    <!-- 구분선 -->
    <hr class="divider">

    <!-- 뉴스 리스트 출력 -->
    <div class="news-list">
        <!-- EL을 사용하여 newsTitles와 newsURLs 출력 -->
        <c:forEach var="i" items="${newsTitles}" varStatus="status">
            <c:if test="${status.index < 4}">
                <div class="news-item">
                    <a href="${newsURLs[status.index]}" target="_blank">${newsTitles[status.index]}</a>
                </div>
            </c:if>
        </c:forEach>
    </div>

</body>
</html>