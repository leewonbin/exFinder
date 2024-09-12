<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<title>통화 상세 정보</title>
<style>
.Currency_view {
    padding-top: 40px;
    align-items: center;
    width: 1100px;
    height: auto; 
    margin: 0 auto;
}
.Currency_header {
    display: flex;
    align-items: center; /* 세로 가운데 정렬 */
}

.Currency_header img {
    margin-right: 10px; /* 이미지와 텍스트 사이의 간격 */
    width: 50px;
    height: 50px; 
}

.Currency_header a {
	width: 150px;
    font-size: 18px; /* 필요에 따라 텍스트 크기 조정 */
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #666;            /* 글자 색상 설정 */
}
.Currency_header > a > b {
    font-size: 20px; /* 필요에 따라 텍스트 크기 조정 */
    font-weight: bold;
    color: #000; /* 필요 시 텍스트 색상 설정 */
}
.Currency_chart {
	width: 1100px;
    height: 350px; 
    border: 1px solid #000; /* 검정색 1px 테두리 */
    box-sizing: border-box; /* 패딩과 테두리를 요소의 총 폭과 높이에 포함 */
    display: flex; /* 자식 요소들을 수평으로 배치 */
}
.Currency_left_chart {
	width: 500px;
    height: 100%; 
	border: 1px solid red; /* 검정색 1px 테두리 */
}
.Currency_right_chart {
	width: 600px;
    height: 100%; 
	border: 1px solid blue; /* 검정색 1px 테두리 */
}
.Currency_chart_time_select {
    display: flex; 
    height: 50px; 
    justify-content: center; /* 자식 요소를 중앙으로 정렬 */
    border-bottom: 1px solid #ccc; /* 밑에 1px 회색 줄 추가 */
    padding-bottom: 10px; /* 줄과 내용 사이에 여백 추가 */
    margin: 0 20px; /* 양 옆에 여백 추가 */
}
.Currency_chart_time_select > ul {
    display: flex; /* 자식 요소를 수평으로 나열 */
    padding: 0; /* 기본 패딩 제거 */
    margin: 0; /* 기본 마진 제거 */
    list-style-type: none; /* 기본 리스트 스타일 제거 */
}
.Currency_chart_time_select > ul > li {
	margin-top: 10px; /* 각 리스트 항목 사이의 간격 설정 */
    margin-right: 30px; /* 각 리스트 항목 사이의 간격 설정 */
    border-right: 1px solid #ccc; /* 항목 사이에 회색 선 추가 */
    padding-right: 30px; /* 선과 텍스트 사이에 여백 추가 */
}

.Currency_chart_time_select > ul > li:last-child {
    margin-right: 0; /* 마지막 항목에는 간격을 주지 않음 */
    border-right: none; /* 마지막 항목에는 선을 추가하지 않음 */
}
.Currency_chart_time_select > ul > li:hover {
    /* 마우스 오버 시 스타일 설정 (선택사항) */
}

.Currency_chart_time_select > ul > li > a {
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
    color: #000; /* 링크 텍스트 색상 설정 (예: 검정색) */
    padding: 5px 10px; /* 링크의 패딩 설정 */
    display: inline-block; /* 링크를 인라인 블록으로 설정 */
}

.Currency_chart_time_select > ul > li > a:focus {
    outline: none; /* 포커스 시 기본 아웃라인 제거 */
    /* 포커스 시 스타일을 추가할 수 있습니다 (선택사항) */
}
.Currency_calculating_machine{
	margin-top: 10px;
	width: 1100px;
    height: 150px; 
    border: 1px solid #000; /* 검정색 1px 테두리 */
}
</style>

</head>
<body>
	<%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>
	
	<div style="width: 100%; height: 110px;"></div>
	
	<!-- 중앙에 위치시키기 위한 div -->
    <div class="Currency_view">
    	<div class="Currency_header">
    		<img src="${pageContext.request.contextPath}/resources/img/gonfalon/${currencyDto.c_code}.png">
            <a><b>${currencyDto.c_country}</b> ${currencyDto.c_code}</a> 
    	</div>
    	<div class="Currency_chart">
    	    <div class="Currency_left_chart">
    	    	나중에 표 여기에 넣어주세요.
    		</div>
    	    <div class="Currency_right_chart">
    	    	<div class="Currency_chart_time_select">
    	    		<ul>
						<li><a href="#" onclick="reg_type_select('1'); return false;" id="seven-day">7일</a></li>
        				<li><a href="#" onclick="reg_type_select('2'); return false;" id="one-month">1개월</a></li>
        				<li><a href="#" onclick="reg_type_select('3'); return false;" id="three-month">3개월</a></li>
        				<li><a href="#" onclick="reg_type_select('4'); return false;" id="one-year">1년</a></li>
					</ul>
    	    	</div>
    	    	<div id="chart_${currencyDto.c_code}" class="chart_graph"></div>
    		</div>
    	</div>
    	<div class="Currency_calculating_machine">
    	 나중에 계산기 넣어주세요.
    	</div>
    </div>
</body>
</html>