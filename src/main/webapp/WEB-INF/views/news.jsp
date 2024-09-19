<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	width: 1100px;        
    display: grid;
    grid-template-columns: repeat(2, 1fr); /* 2개의 열 설정 */
}

/* 뉴스 항목 스타일 */
.news-item {
    display: flex;
    flex-direction: column;
	width: 500px;    
	height: 150px;
	margin-right: 100px;
    margin-bottom: 15px;
}
.new-header {
	height: 30px;
}
.new-header img { 
	width: 24px;        
    height: 24px;
    margin-right: 10px;
}
.new-main {
	width: 500px;
	height: 120px;
    display: flex;
    align-items: flex-start; /* 위쪽 정렬 */
    cursor: pointer; /* 클릭 가능 시 cursor 변경 */
}
.new-main img { 
	width: 100px;        
    height: 100px;
    border-radius: 10px; /* 이미지 모서리 둥글게 만들기 */
}
.new-main-text {
    margin-right: 10px; /* 이미지와의 간격 조정 */
    max-width: 390px; /* 최대 너비를 390px로 설정 */
    overflow: hidden; /* 넘치는 내용 숨기기 */
    text-overflow: ellipsis; /* 넘치는 텍스트에 '...' 표시 */
}
.new-main-text label {
    font-weight: bold; /* 글씨 굵게 */
    font-size: 18px; /* 글자 크기 16px */
    white-space: nowrap; /* 줄 바꿈하지 않고 한 줄로 표시 */
    height: 24px; /* 고정 높이 설정 (필요에 따라 조정) */
}
.new-main-text label:hover {
    text-decoration: underline; /* 호버 시 밑줄 추가 */
}
.new-main-text a {
    display: -webkit-box; /* Flexbox 기반으로 박스 모델 설정 */
    -webkit-box-orient: vertical; /* 세로 방향으로 박스 방향 설정 */
    -webkit-line-clamp: 4; /* 4줄까지 표시 */
    overflow: hidden; /* 넘치는 내용 숨기기 */
    text-overflow: ellipsis; /* 넘치는 텍스트에 '...' 표시 */
    line-height: 1.5; /* 줄 높이 설정 (필요에 따라 조정) */
    max-height: 6em; /* 4줄 높이에 맞게 설정 (줄 높이와 맞춰야 함) */
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
                	<div class="new-header">
                		<img src="${newsIcons.get(status.index)}">${newsNames.get(status.index)} - ${newsTimes.get(status.index)}
                	</div>
                	<div class="new-main" onclick="window.location.href='${newsURLs.get(status.index)}';">
                		<div class="new-main-text">
                			<label>${newsTitles.get(status.index)} </label><br>
                			<a>${newsTexts.get(status.index)}</a>
                		</div>
                		<img src="${newsImgs.get(status.index)}" alt="뉴스 이미지">
                	</div>
                </div>
            </c:if>
        </c:forEach>	
    </div>

</body>
</html>