// Google Charts 라이브러리 로드
google.charts.load('current', {
	'packages' : [ 'corechart' ]
});

$(document).ready(function() {
	ajaxData('USD', 'chart_div'); // 페이지가 로드될 때 첫 번째 AJAX 요청
	ajaxData('JPY', 'chart_div2'); // 페이지가 로드될 때 두 번째 AJAX 요청
	ajaxData('EUR', 'chart_div3');
	ajaxData('CNY', 'chart_div4');
	
	ajaxData('GBP', 'chart_div5');
	ajaxData('CHF', 'chart_div6');
	
	ajaxData('INR', 'chart_div7');
	ajaxData('AUD', 'chart_div8');
	ajaxData('SAR', 'chart_div9');
	ajaxData('RUB', 'chart_div10');
	
	fetchExchangeRateData('USD', '2024/03/26', 'value' );
	fetchExchangeRateData('JPY', '2024/03/26', 'value2' );
	fetchExchangeRateData('EUR', '2024/03/26', 'value3' );
	fetchExchangeRateData('CNY', '2024/03/26', 'value4' );
	fetchExchangeRateData('GBP', '2024/03/26', 'value5' );
	fetchExchangeRateData('CHF', '2024/03/26', 'value6' );
	fetchExchangeRateData('INR', '2024/03/26', 'value7' );
	fetchExchangeRateData('AUD', '2024/03/26', 'value8' );
	fetchExchangeRateData('SAR', '2024/03/26', 'value9' );
	fetchExchangeRateData('RUB', '2024/03/26', 'value10' );
});

// AJAX 요청 함수
function ajaxData(c_code, chartDivId) {

	var start_date = '2024/01/01'; // 필요한 값으로 수정
	var end_date = '2024/08/31'; // 필요한 값으로 수정

	$.ajax({
		type : "POST",
		url : "/ex/charts/graph", // contextPath 사용 "${pageContext.request.contextPath}/charts/graph",
		data : {
			c_code : c_code,
			start_date : start_date,
			end_date : end_date
		},
		dataType : "json", // Expect JSON response
		success : function(response) {
			console.log(response); // 응답 데이터 확인
			drawCharts(response, chartDivId); // 차트 그리기 함수 호출
		},
		error : function(xhr, status, error) {
			console.error("AJAX 요청 오류:", status, error);
		}
	});
}
// 차트 그리기 함수
function drawCharts(data, chartDivId) {
	var chartData = new google.visualization.DataTable();
	chartData.addColumn('date', 'yy년MM월dd일'); // 첫 번째 열: 날짜
	chartData.addColumn('number', '값'); // 두 번째 열: 값

	// 응답 데이터를 [날짜, 값] 형식으로 변환
	var formattedData = data.map(function(item) {
		var date = new Date(item.rate_date.year, item.rate_date.month - 1,
				item.rate_date.day); // Date 객체 생성
		return [ date, item.base_r ]; // [날짜, 값] 형식으로 배열 반환
	});
	chartData.addRows(formattedData); // DataTable에 데이터 추가

	var options = {
		hAxis : {

			format : 'yy/MM/dd', // 날짜 형식 지정
			gridlines : {
				count : -1
			}, // 자동 그리드라인 수 조정
			viewWindowMode : 'maximized',

		},
		vAxis : {

			logScale : false
		},
		colors : [ '#a52714' ],
		legend : {
			position : 'none'
		}
	// 범례를 숨깁니다.
	};

	var chart = new google.visualization.LineChart(document
			.getElementById(chartDivId));
	chart.draw(chartData, options);
}

// 정보 함수
function fetchExchangeRateData(c_code, rate_date, div_id) {
    $.ajax({
        url: '/ex/charts/value',
        type: 'POST',
        data: {
            c_code: c_code,
            rate_date: rate_date
        },
        success: function(response) {
            console.log('서버 응답:', response); // 서버 응답 확인

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
                result = today_base_r + ' ▼' + difference.toFixed(2) + ' -' + percent.toFixed(2) + '%';
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
            console.error('데이터를 가져오는 데 실패했습니다:', error);
            $('#' + div_id).html('<div>데이터를 가져오는 데 실패했습니다.</div>');
        }
    });
}



// 슬라이드
$(document).ready(function() {
    var currentIndex = 0;
    var totalSlides = $('.chart_graph_box_container').length; // 총 슬라이드 개수
    var container = $('#slide-container');
    var slideWidth = $('.chart_graph_box_slide').width(); // 슬라이드 폭 계산 (chart_graph_box_slide의 너비와 동일)

    function showSlide(index) {
        var maxIndex = totalSlides - 1; // 최대 슬라이드 인덱스
        var newIndex = (index > maxIndex) ? 0 : (index < 0) ? maxIndex : index; // 인덱스 범위 조정
        var offset = -newIndex * slideWidth; // 이동할 거리 계산
        container.css('transform', 'translateX(' + offset + 'px)'); // 슬라이드 이동
        currentIndex = newIndex; // 현재 인덱스 업데이트
        updateSlideIndicator(); // 슬라이드 인디케이터 업데이트
    }

    function updateSlideIndicator() {
        $('#slide-indicator').text((currentIndex + 1) + ' / ' + totalSlides);
    }

    $('#next-slide').click(function() {
        showSlide(currentIndex + 1);
    });

    $('#prev-slide').click(function() {
        showSlide(currentIndex - 1);
    });

    // 초기 슬라이드 표시
    showSlide(currentIndex);

    // 윈도우 리사이즈 시 슬라이드 폭 업데이트
    $(window).resize(function() {
        slideWidth = $('.chart_graph_box_slide').width();
        showSlide(currentIndex);
    });
});