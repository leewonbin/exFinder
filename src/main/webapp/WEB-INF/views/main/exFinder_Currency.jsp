<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<title>통화 상세 정보</title>
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery.min.js"></script>
	<!-- google charts -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
    height: 300px; 
    border: 1px solid #000; /* 검정색 1px 테두리 */
    box-sizing: border-box; /* 패딩과 테두리를 요소의 총 폭과 높이에 포함 */
    display: flex; /* 자식 요소들을 수평으로 배치 */
}
.Currency_left_chart {
	width: 500px;
    height: 100%; 
	border: 1px solid red;  /* 검정색 1px 테두리 */
	padding: 40px 20px;  /* 내부 여백 10px 추가 */
}
.Currency_left_chart_header {
	height: 50px; 
    display: flex;            /* flexbox 사용 */
    justify-content: space-between;  /* 요소들 사이의 공간을 균등하게 배치 (왼쪽과 오른쪽) */
    align-items: center;      /* 수직 가운데 정렬 */
    width: 100%;
    cursor: pointer; /* 클릭 가능한 요소로 표시 */
}
.Currency_left_chart_header a {
    font-size: 24px; /* 원하는 글자 크기 */
    font-weight: bold; /* 글자 굵기 설정 */
}
.Currency_left_chart_header div {
    font-size: 20px; /* 원하는 글자 크기 */
}

.increased {
   	color: red;
   	font-size: 15px; /* 글씨 크기를 살짝 줄여 가독성 개선 */
   	font-weight: bold;
   	padding-right: 30px;
}
.unchanged {
    color: gray;
    font-size: 15px; /* 글씨 크기를 살짝 줄여 가독성 개선 */
    font-weight: bold;
    padding-right: 30px;   
}
.decreased {
    color: blue;
    font-size: 15px; /* 글씨 크기를 살짝 줄여 가독성 개선 */
    font-weight: bold;
    padding-right: 30px;  
}
.circle {
    display: inline-block;
    width: 25px; /* 동그라미의 너비 */
    height: 25px; /* 동그라미의 높이 */
    border-radius: 50%; /* 동그라미 모양을 만들기 위한 속성 */
    background-color: #fff; /* 동그라미의 배경색을 흰색으로 설정 */
    border: 1px solid #000; /* 선택적으로 테두리 추가 */
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff; /* 동그라미 내부 텍스트 색상 */
    text-align: center;
    font-size: 12px; /* 동그라미 내부 텍스트 크기 */
    cursor: pointer; /* 클릭 가능한 요소로 표시 */
}

.arrow-up {
    display: inline-block;
    font-size: 20px; /* 화살표의 크기 */
    color: #000; /* 화살표의 색상 */
    /* 원하는 화살표 기호 또는 심볼을 삽입 */
}
.arrow-up::before {
    content: '∧'; /* 화살표 기호 */
    display: inline-block;
}

.Currency_left_chart_table {
    width: 100%; /* 테이블 너비를 100%로 설정 */
    height: 120px; 
    border-collapse: collapse; /* 테이블 셀의 경계가 겹치지 않게 설정 */
    margin: 10px 0; /* 상하 여백을 20px로 설정, 좌우 여백은 0으로 설정 */
}

.Currency_left_chart_table th,
.Currency_left_chart_table td {
    border: 1px solid #ddd; /* 연한 회색 경계선 추가 */
    padding: 8px; /* 셀 안쪽에 여백 추가 */
    text-align: center; /* 셀 내용 중앙 정렬 */
}

.Currency_left_chart_table th {
    background-color: #f4f4f4; /* 헤더 셀 배경색을 연한 회색으로 설정 */
    font-weight: bold; /* 헤더 텍스트를 굵게 설정 */
}

.Currency_left_chart_table td {
    background-color: #fff; /* 데이터 셀 배경색을 흰색으로 설정 */
}

.Currency_left_chart_table tr:nth-child(even) {
    background-color: #f9f9f9; /* 짝수 행 배경색을 연한 회색으로 설정 */
}


.Currency_right_chart {
	width: 600px;
    height: 100%; 
	/*  border: 1px solid blue; 검정색 1px 테두리 */	
}
.Currency_chart_time_select {
    display: flex; 
    height: 49px; 
    justify-content: center; /* 자식 요소를 중앙으로 정렬 */
    align-items: center; /* 자식 요소를 수직으로 중앙 정렬 */
    border-bottom: 1px solid #ccc; /* 밑에 1px 회색 줄 추가 */
    padding: 15px 0;
    margin: 0 40px; /* 양 옆에 여백 추가 */
}
.Currency_chart_time_select > ul {
    display: flex; /* 자식 요소를 수평으로 나열 */
    padding: 0; /* 기본 패딩 제거 */
    margin: 0; /* 기본 마진 제거 */
    list-style-type: none; /* 기본 리스트 스타일 제거 */
}
.Currency_chart_time_select > ul > li {
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
}
.active {
    font-weight: bold;
}
.chart_graph {    
    width: 90%;
    height: 248px; /* 차트 높이 조정 */
    overflow: hidden;
    margin: 0 auto;
	/* border: 1px solid yellow; 검정색 1px 테두리 */
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
            <i class="circle" id="toggle-list">
        		<i class="arrow-up"></i>
    		</i>
    	</div>
    	<div class="Currency_chart">
    	    <div class="Currency_left_chart">
    	    	<div class="Currency_left_chart_header">
    	    		<a>매매 기준율</a>
    	    		<div id="value_Currency"></div>
    	    	</div>
    	    	<table class="Currency_left_chart_table">    			
     		   		<tr>
            			<th colspan="2">현찰</th>
            			<th colspan="2">송금 (전신환)</th>
        			</tr>   			
        			<tr>
            			<th>사실때</th>
            			<td>${exchangeRateDto.cash_buy}</td>
            			<th>보낼때</th>
            			<td>${exchangeRateDto.ttb}</td>
        			</tr>
	        			<tr>
    	        		<th>파실때</th>
        	    		<td>${exchangeRateDto.cash_sell}</td>
            			<th>받을때</th>
            			<td>${exchangeRateDto.tts}</td>
        			</tr>
				</table>
				<div>
					기준일 : ${exchangeRateDto.rate_date}
				</div>
    		</div>
    	    <div class="Currency_right_chart">
    	    	<div class="Currency_chart_time_select">
    	    		<ul>
						<li><a href="#" id="seven-day" >7일</a></li>
        				<li><a href="#" id="one-month" >1개월</a></li>
        				<li><a href="#" id="three-month">3개월</a></li>
        				<li><a href="#" id="one-year">1년</a></li>
					</ul>
    	    	</div>
    	    	<div id="chart_7day" class="chart_graph" ></div>
    	    	<div id="chart_1month" class="chart_graph" ></div>
    	    	<div id="chart_3month" class="chart_graph" ></div>
    	    	<div id="chart_1year" class="chart_graph" ></div>
    		</div>
    	</div>
    	<div class="Currency_calculating_machine">
    	 나중에 계산기 넣어주세요.
    	</div>
    </div>
</body>
<script>
//날짜를 문자열로 포맷팅하는 함수
function formatDate(date) {
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
    var day = ('0' + date.getDate()).slice(-2); // 일자는 2자리로 맞추기
    return year + '/' + month + '/' + day;
}

// 오늘 날짜를 가져옴
var today = new Date();
var formattedDate = formatDate(today);

// Google Charts 라이브러리 로드
google.charts.load('current', {
    'packages': ['corechart']
});

$(document).ready(function() {
    // AJAX 요청
    ajaxData(`${currencyDto.c_code}`, 'chart_7day', 'seven-day');
//    ajaxData(`${currencyDto.c_code}`, 'chart_1month', 'one-month'); 
//    ajaxData(`${currencyDto.c_code}`, 'chart_3month', 'three-month'); 
//    ajaxData(`${currencyDto.c_code}`, 'chart_1year', 'one-year'); 

	fetchExchangeRateData(`${currencyDto.c_code}`, formattedDate, 'value_Currency');
    // Google Charts 라이브러리가 로드된 후 차트 그리기
    google.charts.setOnLoadCallback(function() {
        console.log('Google Charts 라이브러리 로드 완료');
    });
});

// AJAX 요청 함수
function ajaxData(c_code, chartDivId, cart_day) {
    var end_date = formattedDate; // 오늘 날짜

    $.ajax({
        type: "POST",
        url: "/ex/currency/chart",
        data: {
            c_code: c_code,
            start_date: '2024/01/01', // 기본 시작 날짜 설정
            end_date: end_date,
            cart_day: cart_day
        },
        dataType: "json", // Expect JSON response
        success: function(response) {
            console.log('응답 데이터 확인');
            console.log(response); // 응답 데이터 확인
            drawCharts(response, chartDivId); // 차트 그리기 함수 호출
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 오류:", status, error);
        }
    });
}

// 차트 그리기 함수
function drawCharts(data, chartDivId) {
    if (typeof google === 'undefined' || !google.visualization || typeof google.visualization.DataTable !== 'function') {
        console.error("Google Charts 라이브러리가 로드되지 않았습니다. 재시도합니다.");
        setTimeout(function() {
            drawCharts(data, chartDivId);
        }, 1000); // 1초 후 재시도
        return;
    }

    var chartData = new google.visualization.DataTable();
    chartData.addColumn('date', '날짜'); // 날짜 열
    chartData.addColumn('number', '값'); // 값 열

    // 응답 데이터를 [날짜, 값] 형식으로 변환
    var formattedData = data.map(function(item) {
        var date = new Date(item.rate_date.year, item.rate_date.month - 1, item.rate_date.day); // Date 객체 생성
        return [date, item.base_r]; // [날짜, 값] 형식으로 배열 반환
    });

    // 데이터가 유효한지 확인
    if (formattedData.length === 0) {
        console.error('차트에 표시할 데이터가 없습니다.');
        return;
    }

    chartData.addRows(formattedData); // DataTable에 데이터 추가

	 // X축에 표시할 날짜 계산
    var minDate = new Date(Math.min.apply(null, formattedData.map(function(row) { return row[0].getTime(); })));
    var maxDate = new Date(Math.max.apply(null, formattedData.map(function(row) { return row[0].getTime(); })));
    var dateRange = (maxDate - minDate) / 4; // 4로 나누어 5개의 주요 눈금을 생성
    var ticks = [];

    // 주요 눈금을 계산하여 추가
    for (var i = 0; i <= 4; i++) {
        var tickDate = new Date(minDate.getTime() + i * dateRange);
        ticks.push(tickDate);
    }

    var options = {
    	    hAxis: {
    	        format: 'yy/MM/dd', // 날짜 형식 지정
    	        ticks: ticks, // X축에 표시할 날짜 설정
    	        gridlines: {
    	            count: 5 // X축의 그리드라인 수 설정 (주요 눈금에 맞춤)
    	        },
    	        
    	    },
    	    vAxis: {
    	        logScale: false, // 선형 스케일 사용
    	        gridlines: {
    	            count: 5, // Y축의 그리드라인 수 설정
    	            color: 'lightgray' // Y축 그리드라인 색상
    	        },
    	        baselineColor: 'black' // Y축 기준선 색상
    	    },
    	    colors: ['#a52714'], // 그래프 선 색상
    	    legend: {
    	        position: 'none' // 범례 숨기기
    	    },
    	    chartArea: {
    	        width: '80%', // 차트 영역 너비
    	        height: '70%' // 차트 영역 높이
    	    }
    	};

    var chart = new google.visualization.LineChart(document.getElementById(chartDivId));
    chart.draw(chartData, options);
}

//정보 함수
function fetchExchangeRateData(c_code, rate_date, div_id) {
    $.ajax({
        url: '/ex/charts/value',
        type: 'POST',
        data: {
            c_code: c_code,
            rate_date: rate_date
        },
        success: function(response) {
            // console.log('서버 응답:', response); // 서버 응답 확인

            // 응답 데이터가 JSON 객체로 가정
            const today_base_r = response.today_base_r;
            const yesterday_base_r = response.yesterday_base_r;
            const difference = response.difference;
            const percent = response.percent;

            // 결과 문자열 생성
            let result;
            let cssClass;

            if (today_base_r > yesterday_base_r) {
                result = today_base_r + ' ▲' + difference.toFixed(2) + ' +' + percent.toFixed(2) + '%';
                cssClass = 'increased';
                
            } else if (today_base_r === yesterday_base_r) {
                result = today_base_r + ' -' + difference.toFixed(2) + ' ' + percent.toFixed(2) + '%';
                cssClass = 'unchanged';
                
            } else {
                result = today_base_r + ' ▼' + difference.toFixed(2) + ' ' + percent.toFixed(2) + '%';
                cssClass = 'decreased';
                
            }

            console.log('결과 문자열:', result); // 결과 문자열 확인
            console.log('CSS 클래스:', cssClass); // CSS 클래스 확인

            // HTML 콘텐츠 업데이트
            const htmlContent = '<div class="' + cssClass + '">' + result + '</div>';
            console.log('업데이트할 HTML:', htmlContent); // 업데이트할 HTML 확인               

            // HTML 업데이트
            $('#' + div_id).html(htmlContent);
           
            // 업데이트 후 상태 확인
            console.log('업데이트된 HTML:', $('#' + div_id).html());
        },
        error: function(xhr, status, error) {
            console.error(c_code,'에 대한 데이터를 가져오는 데 실패했습니다:', error);
            $('#' + div_id).html('<div>데이터를 가져오는 데 실패했습니다.</div>');
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const charts = document.querySelectorAll('.chart_graph');
    const sevenDayLink = document.getElementById('seven-day');
    const oneMonthLink = document.getElementById('one-month');
    const threeMonthLink = document.getElementById('three-month');
    const oneYearLink = document.getElementById('one-year');

    // 모든 차트를 숨기고, 모든 링크에서 active 제거
    function hideAllCharts() {
        charts.forEach(chart => {
            chart.style.display = 'none';
        });

        document.querySelectorAll('.Currency_chart_time_select a').forEach(link => {
            link.classList.remove('active');
        });
    }

    // 특정 차트를 보이고, 링크에 active 클래스 추가
    function showChart(chartId, link) {
        hideAllCharts(); // 차트와 active 상태 초기화
        document.getElementById(chartId).style.display = 'block'; // 선택된 차트 표시
        link.classList.add('active'); // 선택된 링크에 active 클래스 추가
    }

    // 스크롤 위치를 유지하는 함수
    function handleChartClick(event, chartId, link) {
        event.preventDefault(); // 기본 동작 방지
        const scrollPosition = window.pageYOffset || document.documentElement.scrollTop; // 현재 스크롤 위치 저장
        showChart(chartId, link); // 차트 표시
        window.scrollTo(0, scrollPosition); // 스크롤 위치를 유지
    }

    // 기본적으로 7일 차트를 보여줌
    showChart('chart_7day', sevenDayLink);

    // 각 링크에 클릭 이벤트 추가
    sevenDayLink.addEventListener('click', function(event) {
        handleChartClick(event, 'chart_7day', sevenDayLink);
        
    });

    oneMonthLink.addEventListener('click', function(event) {
        handleChartClick(event, 'chart_1month', oneMonthLink);
        ajaxData(`${currencyDto.c_code}`, 'chart_1month', 'one-month'); 
    });

    threeMonthLink.addEventListener('click', function(event) {
        handleChartClick(event, 'chart_3month', threeMonthLink);
        ajaxData(`${currencyDto.c_code}`, 'chart_3month', 'three-month'); 
    });

    oneYearLink.addEventListener('click', function(event) {
        handleChartClick(event, 'chart_1year', oneYearLink);
        ajaxData(`${currencyDto.c_code}`, 'chart_1year', 'one-year'); 
    });
});
/*
<span id="currency-list" class="hidden">
<a>미국 USD</a>
<a>일본 JPY</a>
<a>유럽연합 EUR</a>
<a>중국 CNY</a>
<a>영국 GBP</a>
		
<a>스위스 CHF</a>
<a>캐나다 CAD</a>
<a>인도 INR</a>
<a>홍콩 HKD</a>
<a>이집트 EGP</a>
		
<a>사우디 SAR</a>
<a>호주 AUD</a>
<a>태국 THB</a>
<a>러시아 RUB</a>
<a>베트남 VND</a>
		
<a>남아공 ZAR</a>
<a>멕시코 MXN</a>
<a>브라질 BRL</a>
<a>이스라엘 ILS</a>
<a>뉴질랜드 NZD</a> 		
</span>*/
</script>
</html>