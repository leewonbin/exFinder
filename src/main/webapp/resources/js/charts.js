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
    // 통화 정보 배열 정의
    const currencies_value = [
        { code: 'USD', valueId: 'value_USD', flagId: 'flag_USD' },
        { code: 'JPY', valueId: 'value_JPY', flagId: 'flag_JPY' },
        { code: 'EUR', valueId: 'value_EUR', flagId: 'flag_EUR' },
        { code: 'CNY', valueId: 'value_CNY', flagId: 'flag_CNY' },
        { code: 'GBP', valueId: 'value_GBP', flagId: 'flag_GBP' },
        { code: 'CHF', valueId: 'value_CHF', flagId: 'flag_CHF' },
        { code: 'INR', valueId: 'value_INR', flagId: 'flag_INR' },
        { code: 'AUD', valueId: 'value_AUD', flagId: 'flag_AUD' },
        { code: 'SAR', valueId: 'value_SAR', flagId: 'flag_SAR' },
        { code: 'RUB', valueId: 'value_RUB', flagId: 'flag_RUB' },
        { code: 'CAD', valueId: 'value_CAD', flagId: 'flag_CAD' },
        { code: 'HKD', valueId: 'value_HKD', flagId: 'flag_HKD' },
        { code: 'EGP', valueId: 'value_EGP', flagId: 'flag_EGP' },
        { code: 'THB', valueId: 'value_THB', flagId: 'flag_THB' },
        { code: 'VND', valueId: 'value_VND', flagId: 'flag_VND' },
        { code: 'ZAR', valueId: 'value_ZAR', flagId: 'flag_ZAR' },
        { code: 'MXN', valueId: 'value_MXN', flagId: 'flag_MXN' },
        { code: 'BRL', valueId: 'value_BRL', flagId: 'flag_BRL' },
        { code: 'ILS', valueId: 'value_ILS', flagId: 'flag_ILS' },
        { code: 'NZD', valueId: 'value_NZD', flagId: 'flag_NZD' }
    ];
    processCurrencies_value(currencies_value);
    
    // Google Charts 라이브러리가 로드된 후 차트 그리기
    google.charts.setOnLoadCallback(function() {
        //console.log('Google Charts 라이브러리 로드 완료');
    });
    
    // 통화 코드와 차트 ID 매핑 배열 정의
    const currencies_chart = [
        { code: 'USD', chartId: 'chart_USD' },
        { code: 'JPY', chartId: 'chart_JPY' },
        { code: 'EUR', chartId: 'chart_EUR' },
        { code: 'CNY', chartId: 'chart_CNY' },
        { code: 'GBP', chartId: 'chart_GBP' },
        { code: 'CHF', chartId: 'chart_CHF' },
        { code: 'INR', chartId: 'chart_INR' },
        { code: 'AUD', chartId: 'chart_AUD' },
        { code: 'SAR', chartId: 'chart_SAR' },
        { code: 'RUB', chartId: 'chart_RUB' },
        { code: 'CAD', chartId: 'chart_CAD' },
        { code: 'HKD', chartId: 'chart_HKD' },
        { code: 'EGP', chartId: 'chart_EGP' },
        { code: 'THB', chartId: 'chart_THB' },
        { code: 'VND', chartId: 'chart_VND' },
        { code: 'ZAR', chartId: 'chart_ZAR' },
        { code: 'MXN', chartId: 'chart_MXN' },
        { code: 'BRL', chartId: 'chart_BRL' },
        { code: 'ILS', chartId: 'chart_ILS' },
        { code: 'NZD', chartId: 'chart_NZD' }
    ];

    processCurrencies_chart(currencies_chart);

});

function processCurrencies_value(currencies_value) {
	currencies_value.forEach(currency_value => {
		 fetchExchangeRateData(currency_value.code, formattedDate, currency_value.valueId, currency_value.flagId);
	 });
}

function processCurrencies_chart(currencies_chart) {
    const c_codes = currencies_chart.map(currency_chart => currency_chart.code); // 통화 코드 리스트 추출

    $.ajax({
        type: "POST",
        url: "/ex/charts/graph", 
        data: {
            c_codes: c_codes, // 통화 코드 리스트를 전송
            rate_date: formattedDate // 필요한 값으로 수정
        },
        traditional: true, // 배열을 전송할 수 있도록 설정
        dataType: "json",
        success: function(response) {
            //console.log("응답 데이터:", response); // 응답 데이터를 확인
            response.forEach((item, index) => {
                const data = item.data; // 여기서 각 항목의 data 배열을 가져옴
                
                //console.log("현재 처리 중인 데이터:", item); // 각 항목 로그
                //console.log("데이터 배열:", item.data); // data 배열 로그
                
                if (Array.isArray(data) && data.length > 0) {  // 응답이 배열이고 비어있지 않은 경우에만 처리
                    drawTimeCharts(data, currencies_chart[index].chartId);  // 차트 그리기 함수 호출
                } else {
                    console.error(`차트 데이터가 배열이 아닙니다: ${item.c_code}`);
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 오류:", status, error);
        }
    });
}

//차트 그리기 함수
function drawTimeCharts(data, chartDivId) {
    if (typeof google === 'undefined' || !google.visualization || typeof google.visualization.DataTable !== 'function') {
        console.error("Google Charts 라이브러리가 로드되지 않았습니다. 재시도합니다.");
        setTimeout(function() {
            drawTimeCharts(data, chartDivId);
        }, 1000);
        return;
    }

    var chartData = new google.visualization.DataTable();
    chartData.addColumn('timeofday', '시간'); // 첫 번째 열: 시간 (시간, 분, 초)
    chartData.addColumn('number', '값'); // 두 번째 열: 값

    // 응답 데이터가 배열인지 확인
    if (!Array.isArray(data)) {
        console.error("응답 데이터가 배열이 아닙니다:", data);
        return;
    }
    
    // 응답 데이터를 [시간, 값] 형식으로 변환
    var formattedData = data.map(function(item) {
        // annoTime을 [hours, minutes] 형식으로 변환
        var timeParts = item.annoTime.split(':');
        var hours = parseInt(timeParts[0], 10);
        var minutes = parseInt(timeParts[1], 10);
        var time = [hours, minutes, 0]; // seconds는 0으로 설정
        return [time, item.deal_bas_r]; // [시간, 값] 형식으로 배열 반환
    });

    chartData.addRows(formattedData); // DataTable에 데이터 추가

    var options = {
        hAxis: {
            format: 'HH:mm', // 시간 형식 지정
            gridlines: {
                count: -1
            },
            viewWindowMode: 'maximized'
        },
        vAxis: {
            logScale: false
        },
        colors: ['#a52714'],
        legend: {
            position: 'none'
        }
    };

    var chart = new google.visualization.LineChart(document.getElementById(chartDivId));
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

            //console.log('결과 문자열:', result); // 결과 문자열 확인
            //console.log('CSS 클래스:', cssClass); // CSS 클래스 확인

            // HTML 콘텐츠 업데이트
            const htmlContent = '<div class="' + cssClass + '">' + result + '</div>';
            //console.log('업데이트할 HTML:', htmlContent); // 업데이트할 HTML 확인
            
            const htmlContent2 = '<span class="' + flag_cssClass + '">' + flag_result + '</span>';

            // HTML 업데이트
            $('#' + div_id).html(htmlContent);
            
            $('#' + flag_id).html(htmlContent2);

            // 업데이트 후 상태 확인
            //console.log('업데이트된 HTML:', $('#' + div_id).html());
        },
        error: function(xhr, status, error) {
            console.error(c_code,'에 대한 데이터를 가져오는 데 실패했습니다:', error);
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
