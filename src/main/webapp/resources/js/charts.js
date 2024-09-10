// 페이지의 모든 스크립트가 로드된 후 페이지를 표시
window.addEventListener('load', function() {
    // 모든 스크립트와 리소스가 로드된 후
    document.body.classList.remove('loading');
    document.body.classList.add('loaded');
});

// 날짜를 문자열로 포맷팅하는 함수
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
	'packages' : [ 'corechart' ]
});

$(document).ready(function() {
	ajaxData('USD', 'chart_USD'); 
	ajaxData('JPY', 'chart_JPY'); 
	ajaxData('EUR', 'chart_EUR');
	ajaxData('CNY', 'chart_CNY');
	ajaxData('GBP', 'chart_GBP');
	ajaxData('CHF', 'chart_CHF');
	ajaxData('INR', 'chart_INR');
	ajaxData('AUD', 'chart_AUD');
	ajaxData('SAR', 'chart_SAR');
	ajaxData('RUB', 'chart_RUB');

	ajaxData('CAD', 'chart_CAD'); 
	ajaxData('HKD', 'chart_HKD'); 
	ajaxData('EGP', 'chart_EGP');
	ajaxData('THB', 'chart_THB');
	ajaxData('VND', 'chart_VND');
	ajaxData('ZAR', 'chart_ZAR');
	ajaxData('MXN', 'chart_MXN');
	ajaxData('BRL', 'chart_BRL');
	ajaxData('ILS', 'chart_ILS');
	ajaxData('NZD', 'chart_NZD');
	
	
	fetchExchangeRateData('USD', formattedDate, 'value_USD', 'flag_USD');
	fetchExchangeRateData('JPY', formattedDate, 'value_JPY', 'flag_JPY');
	fetchExchangeRateData('EUR', formattedDate, 'value_EUR', 'flag_EUR');
	fetchExchangeRateData('CNY', formattedDate, 'value_CNY', 'flag_CNY');
	fetchExchangeRateData('GBP', formattedDate, 'value_GBP', 'flag_GBP');
	fetchExchangeRateData('CHF', formattedDate, 'value_CHF', 'flag_CHF');
	fetchExchangeRateData('INR', formattedDate, 'value_INR', 'flag_INR');
	fetchExchangeRateData('AUD', formattedDate, 'value_AUD', 'flag_AUD');
	fetchExchangeRateData('SAR', formattedDate, 'value_SAR', 'flag_SAR');
	fetchExchangeRateData('RUB', formattedDate, 'value_RUB', 'flag_RUB');
	
	fetchExchangeRateData('CAD', formattedDate, 'value_CAD', 'flag_CAD');
	fetchExchangeRateData('HKD', formattedDate, 'value_HKD', 'flag_HKD');
	fetchExchangeRateData('EGP', formattedDate, 'value_EGP', 'flag_EGP');
	fetchExchangeRateData('THB', formattedDate, 'value_THB', 'flag_THB');
	fetchExchangeRateData('VND', formattedDate, 'value_VND', 'flag_VND');
	fetchExchangeRateData('ZAR', formattedDate, 'value_ZAR', 'flag_ZAR');
	fetchExchangeRateData('MXN', formattedDate, 'value_MXN', 'flag_MXN');
	fetchExchangeRateData('BRL', formattedDate, 'value_BRL', 'flag_BRL');
	fetchExchangeRateData('ILS', formattedDate, 'value_ILS', 'flag_ILS');
	fetchExchangeRateData('NZD', formattedDate, 'value_NZD', 'flag_NZD');
});
// '2024/09/06'

// AJAX 요청 함수
function ajaxData(c_code, chartDivId) {

	var start_date = '2024/01/01'; // 필요한 값으로 수정
	var end_date = formattedDate; // 필요한 값으로 수정

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
		var date = new Date(item.rate_date.year, item.rate_date.month - 1, item.rate_date.day); // Date 객체 생성
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
function fetchExchangeRateData(c_code, rate_date, div_id, flag_id) {
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
                
                flag_result = '+' + percent.toFixed(2) + '%';
                flag_cssClass = 'flag-increased';
            } else if (today_base_r === yesterday_base_r) {
                result = today_base_r + ' -' + difference.toFixed(2) + ' ' + percent.toFixed(2) + '%';
                cssClass = 'unchanged';
                
                flag_result = ' ' + percent.toFixed(2) + '%';
                flag_cssClass = 'flag-unchanged';
            } else {
                result = today_base_r + ' ▼' + difference.toFixed(2) + ' ' + percent.toFixed(2) + '%';
                cssClass = 'decreased';
                
                flag_result = ' ' + percent.toFixed(2) + '%';
                flag_cssClass = 'flag-decreased';
                
            }

            console.log('결과 문자열:', result); // 결과 문자열 확인
            console.log('CSS 클래스:', cssClass); // CSS 클래스 확인

            // HTML 콘텐츠 업데이트
            const htmlContent = '<div class="' + cssClass + '">' + result + '</div>';
            console.log('업데이트할 HTML:', htmlContent); // 업데이트할 HTML 확인
            
            const htmlContent2 = '<span class="' + flag_cssClass + '">' + flag_result + '</span>';

            // HTML 업데이트
            $('#' + div_id).html(htmlContent);
            
            $('#' + flag_id).html(htmlContent2);

            // 업데이트 후 상태 확인
            console.log('업데이트된 HTML:', $('#' + div_id).html());
        },
        error: function(xhr, status, error) {
            console.error('데이터를 가져오는 데 실패했습니다:', error);
            $('#' + div_id).html('<div>데이터를 가져오는 데 실패했습니다.</div>');
            $('#' + flag_id).html('<span>데이터를 가져오는 데 실패했습니다.</span>');
        }
    });
}



document.addEventListener('DOMContentLoaded', function() {
    let currentSlide = 0;
    const slideContainer = document.querySelector('.chart_graph_box_slide');
    const slideItems = document.querySelectorAll('.chart_graph_box_container');
    const totalSlides = slideItems.length;
    const slideIndicator = document.getElementById('slide-indicator');
    const nextButton = document.getElementById('next-slide');
    const prevButton = document.getElementById('prev-slide');

    // 초기 슬라이드 업데이트
    updateSlide();

    // 다음 슬라이드로 이동
    nextButton.addEventListener('click', () => {
        if (currentSlide < totalSlides - 1) {
            currentSlide++;
        } else {
            currentSlide = 0; // 마지막 페이지에서 다음 버튼을 누르면 첫 페이지로 이동
        }
        updateSlide();
    });

    // 이전 슬라이드로 이동
    prevButton.addEventListener('click', () => {
        if (currentSlide > 0) {
            currentSlide--;
        } else {
            currentSlide = totalSlides - 1; // 첫 페이지에서 이전 버튼을 누르면 마지막 페이지로 이동
        }
        updateSlide();
    });

    // 슬라이드 업데이트 함수
    function updateSlide() {
        const slideWidth = document.querySelector('.chart_graph_box_container').clientWidth;
        slideContainer.style.transform = `translateX(-${currentSlide * slideWidth}px)`;
        slideIndicator.textContent = `${currentSlide + 1} / ${totalSlides}`;
    }
});


document.addEventListener('DOMContentLoaded', function() {
    const links = document.querySelectorAll('.world_map_header a');
    const flags = document.querySelectorAll('.world_map .flag');

    // 기본적으로 'world_all' 콘텐츠만 표시
    document.querySelectorAll('.flag').forEach(flag => {
        if (flag.classList.contains('map_all')) {
            flag.style.display = 'block';
        }
    });

    links.forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault();  // 링크 기본 동작 방지

            // 모든 flag를 숨김
            flags.forEach(flag => flag.style.display = 'none');

            // 클릭한 링크의 id에 따라 관련 flag만 표시
            const id = this.id;
            if (id === 'world_all') {
                document.querySelectorAll('.world_map .flag').forEach(flag => flag.style.display = 'block');
            } else {
                document.querySelectorAll(`.world_map .flag.map_${id.replace('world_', '')}`).forEach(flag => flag.style.display = 'block');
            }

            // 원래의 스크롤 위치로 돌아갑니다.
            window.scrollTo(0, scrollPosition);
        });
    });
});
