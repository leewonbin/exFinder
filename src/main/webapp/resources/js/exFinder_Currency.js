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
    ajaxData(currencyCode, 'chart_7day', 'seven-day');
//    ajaxData(`${currencyDto.c_code}`, 'chart_1month', 'one-month'); 
//    ajaxData(`${currencyDto.c_code}`, 'chart_3month', 'three-month'); 
//    ajaxData(`${currencyDto.c_code}`, 'chart_1year', 'one-year'); 

	fetchExchangeRateData(currencyCode, formattedDate, 'value_Currency');
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
        ajaxData(currencyCode, 'chart_1month', 'one-month'); 
    });

    threeMonthLink.addEventListener('click', function(event) {
        handleChartClick(event, 'chart_3month', threeMonthLink);
        ajaxData(currencyCode, 'chart_3month', 'three-month'); 
    });

    oneYearLink.addEventListener('click', function(event) {
        handleChartClick(event, 'chart_1year', oneYearLink);
        ajaxData(currencyCode, 'chart_1year', 'one-year'); 
    });
});


document.addEventListener('DOMContentLoaded', function() {
    const toggleList = document.getElementById('toggle-list');
    const currencyList = document.getElementById('currency-list');
    const arrow = toggleList.querySelector('.arrow-up');

    toggleList.addEventListener('click', function() {
        if (currencyList.classList.contains('hidden')) {
            currencyList.classList.remove('hidden');
            currencyList.classList.add('visible');
            arrow.classList.remove('arrow-up');
            arrow.classList.add('arrow-down'); // 화살표를 아래로 변경
        } else {
            currencyList.classList.add('hidden');
            currencyList.classList.remove('visible');
            arrow.classList.remove('arrow-down');
            arrow.classList.add('arrow-up'); // 화살표를 위로 변경
        }
    });
});

function interestAction(isCheck,c_code) {
	var favorit_img = $(".favorit_img");
	$.ajax({
		url : "/ex/interestAction",
		type : "post",
		data : {
			isCheck : isCheck,
			c_code : c_code
		},
		success: function(res) {
			var imgSrc = "star-before-selection.png";
			var isCheckParam = "false";
			if(res === "FALSE") {
				alert('로그인 후 이용해주세요');
				location.href='/ex/user/login';
			}else if(res === "INSERT") {
				imgSrc = "star-after-selection.png";
				isCheckParam = "true";
			}
			favorit_img.attr("src","resources/img/"+imgSrc);
			favorit_img.attr("onclick","interestAction('"+isCheckParam+"','"+c_code+"');")
		}
	})
}
