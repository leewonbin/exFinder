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

// 통화 정보 배열 정의
const currencies_value = [
    { code: 'USD', valueId: 'value_USD', flagId: 'flag_USD', often_value: 'often_USD', sale_value: 'sale_USD', purchase_value: 'purchase_USD' },
    { code: 'JPY', valueId: 'value_JPY', flagId: 'flag_JPY', often_value: 'often_JPY', sale_value: 'sale_JPY', purchase_value: 'purchase_JPY' },
    { code: 'EUR', valueId: 'value_EUR', flagId: 'flag_EUR', often_value: 'often_EUR', sale_value: 'sale_EUR', purchase_value: 'purchase_EUR' },
    { code: 'CNY', valueId: 'value_CNY', flagId: 'flag_CNY', often_value: 'often_CNY', sale_value: 'sale_CNY', purchase_value: 'purchase_CNY' },
    { code: 'GBP', valueId: 'value_GBP', flagId: 'flag_GBP', often_value: 'often_GBP', sale_value: 'sale_GBP', purchase_value: 'purchase_GBP' },
    { code: 'CHF', valueId: 'value_CHF', flagId: 'flag_CHF', often_value: 'often_CHF', sale_value: 'sale_CHF', purchase_value: 'purchase_CHF' },
    { code: 'INR', valueId: 'value_INR', flagId: 'flag_INR', often_value: 'often_INR', sale_value: 'sale_INR', purchase_value: 'purchase_INR' },
    { code: 'AUD', valueId: 'value_AUD', flagId: 'flag_AUD', often_value: 'often_AUD', sale_value: 'sale_AUD', purchase_value: 'purchase_AUD' },
    { code: 'SAR', valueId: 'value_SAR', flagId: 'flag_SAR', often_value: 'often_SAR', sale_value: 'sale_SAR', purchase_value: 'purchase_SAR' },
    { code: 'RUB', valueId: 'value_RUB', flagId: 'flag_RUB', often_value: 'often_RUB', sale_value: 'sale_RUB', purchase_value: 'purchase_RUB' },
    { code: 'CAD', valueId: 'value_CAD', flagId: 'flag_CAD', often_value: 'often_CAD', sale_value: 'sale_CAD', purchase_value: 'purchase_CAD' },
    { code: 'HKD', valueId: 'value_HKD', flagId: 'flag_HKD', often_value: 'often_HKD', sale_value: 'sale_HKD', purchase_value: 'purchase_HKD' },
    { code: 'EGP', valueId: 'value_EGP', flagId: 'flag_EGP', often_value: 'often_EGP', sale_value: 'sale_EGP', purchase_value: 'purchase_EGP' },
    { code: 'THB', valueId: 'value_THB', flagId: 'flag_THB', often_value: 'often_THB', sale_value: 'sale_THB', purchase_value: 'purchase_THB' },
    { code: 'VND', valueId: 'value_VND', flagId: 'flag_VND', often_value: 'often_VND', sale_value: 'sale_VND', purchase_value: 'purchase_VND' },
    { code: 'ZAR', valueId: 'value_ZAR', flagId: 'flag_ZAR', often_value: 'often_ZAR', sale_value: 'sale_ZAR', purchase_value: 'purchase_ZAR' },
    { code: 'MXN', valueId: 'value_MXN', flagId: 'flag_MXN', often_value: 'often_MXN', sale_value: 'sale_MXN', purchase_value: 'purchase_MXN' },
    { code: 'BRL', valueId: 'value_BRL', flagId: 'flag_BRL', often_value: 'often_BRL', sale_value: 'sale_BRL', purchase_value: 'purchase_BRL' },
    { code: 'ILS', valueId: 'value_ILS', flagId: 'flag_ILS', often_value: 'often_ILS', sale_value: 'sale_ILS', purchase_value: 'purchase_ILS' },
    { code: 'NZD', valueId: 'value_NZD', flagId: 'flag_NZD', often_value: 'often_NZD', sale_value: 'sale_NZD', purchase_value: 'purchase_NZD' }
];

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


$(document).ready(function() {
	console.time('Total Execution Time');

    //processCurrencies_value(currencies_value);
    
    // Google Charts 라이브러리가 로드된 후 차트 그리기
    google.charts.setOnLoadCallback(function() {
        //console.log('Google Charts 라이브러리 로드 완료');
    	
    	// AJAX 요청을 위한 가치 프로미스
        const valuePromise = processCurrencies_value(currencies_value);
        
        // 프로미스 배열 생성
        const chartPromise = processCurrencies_chart(currencies_chart);
        
        // 모든 요청이 완료될 때까지 대기
        Promise.all([valuePromise, chartPromise]).then(() => {
            // 모든 요청 완료 후 종료 시간 기록
            console.timeEnd('Total Execution Time');
        }).catch(error => {
            console.error('요청 중 오류 발생:', error);
        });
    });
    

    
});
/*<div class="chart_loading" id="loadingMessage_${exchange.c_code}"></div>
 * 
 * const loadingMessage = document.getElementById('loadingMessage_' + currency_chart.code);
            loadingMessage.innerText = '차트를 불러오고 있습니다...'; // 로딩 메시지 텍스트 설정
            loadingMessage.style.display = 'flex'; // 로딩 메시지 표시
*/
function processCurrencies_chart(currencies_chart) {
    const c_codes = currencies_chart.map(currency_chart => currency_chart.code); // 통화 코드 리스트 추출

    return new Promise((resolve, reject) => {
        // AJAX 요청을 한 번에 전송하기 위해, 로딩 메시지를 설정하는 부분을 수정
        const ajaxPromises = currencies_chart.map((currency_chart, index) => {
            

            return new Promise((ajaxResolve, ajaxReject) => {
                $.ajax({
                    type: "POST",
                    url: "/ex/charts/graph",
                    data: {
                        c_codes: c_codes, // 통화 코드 리스트를 전송
                        rate_date: formattedDate // 필요한 값으로 수정
                    },
                    traditional: true,
                    dataType: "json",
                }).done(response => {
                    const data = response[index].data; // 성공적으로 응답 받은 데이터를 가져오기

                    if (Array.isArray(data) && data.length > 0) {
                        drawTimeCharts(data, currency_chart.chartId); // 차트 그리기 함수 호출
                    } else {
                        console.error(`차트 데이터가 배열이 아닙니다: ${currency_chart.code}`);
                    }
                    //loadingMessage.style.display = 'none'; // 로딩 메시지 숨기기
                    ajaxResolve(); // 프로미스 해결
                }).fail((xhr, status, error) => {
                    console.error("AJAX 요청 오류:", error);
                    //loadingMessage.style.display = 'none'; // 에러 발생 시 로딩 메시지 숨기기
                    ajaxReject(error); // 프로미스 거부
                });
            });
        });

        // 모든 AJAX 요청이 완료되기를 기다림
        Promise.all(ajaxPromises)
            .then(resolve)
            .catch(reject);
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


//정보 함수
function processCurrencies_value(currencies_value) {
    return new Promise((resolve, reject) => {
        // AJAX 요청
        $.ajax({
            url: '/ex/charts/values', // 서버 URL
            type: 'POST',
            success: function(response) {
                console.log('응답 데이터:', response); // 응답 데이터 로깅

                // 응답 데이터와 currencies_value를 매칭
                currencies_value.forEach(currency_value => {
                    // response에서 통화 코드에 해당하는 데이터 찾기
                    const matchedData = response.find(item => item.c_code === currency_value.code);

                    if (matchedData) {
                        const today_base_r = matchedData.deal_bas_r;  // 현재 환율
                        const difference = matchedData.diff;  // 차이
                        const percent = matchedData.diff_percent;  // 퍼센트 차이

                        let result;
                        let cssClass;
                        let flag_result;
                        let flag_cssClass;
                        
                        let all_value;
                        let all_cssClass;

                        const absDifference = Math.abs(difference); // 차이의 절대값
                        const absPercent = Math.abs(percent); // 퍼센트의 절대값

                        if (difference > 0) {
                            // 차이가 양수인 경우 (현재 환율이 어제 환율보다 높음)
                            result = today_base_r + ' ▲' + absDifference.toFixed(2) + ' +' + absPercent.toFixed(2) + '%';
                            cssClass = 'increased';
                            flag_result = '+' + absPercent.toFixed(2) + '%';
                            flag_cssClass = 'flag-increased';
       
                            all_value = '+' + absPercent.toFixed(2) + '%';
                            all_cssClass = 'all-increased';
                        } else if (difference === 0) {
                            result = today_base_r + ' -' + absDifference.toFixed(2) + ' ' + absPercent.toFixed(2) + '%';
                            cssClass = 'unchanged';
                            flag_result = ' ' + absPercent.toFixed(2) + '%';
                            flag_cssClass = 'flag-unchanged';
                            
                            all_value = ' ' + absPercent.toFixed(2) + '%';
                            all_cssClass = 'all-unchanged';
                        } else if (difference < 0) {
                        	// 차이가 음수인 경우 (현재 환율이 어제 환율보다 낮음)
                            result = today_base_r + ' ▼' + absDifference.toFixed(2) + ' -' + absPercent.toFixed(2) + '%';
                            cssClass = 'decreased';
                            flag_result = ' -' + absPercent.toFixed(2) + '%';
                            flag_cssClass = 'flag-decreased';
                            
                            all_value = ' -' + absPercent.toFixed(2) + '%';
                            all_cssClass = 'all-decreased';
                        }

                        // HTML 콘텐츠 업데이트
                        const htmlContent = '<div class="' + cssClass + '">' + result + '</div>';
                        const htmlContent2 = '<span class="' + flag_cssClass + '">' + flag_result + '</span>';
                        
                        const htmlContent3 = '<i class="' + all_cssClass + '">' + all_value + '</i>';

                        // ID로 HTML 업데이트
                        $('#' + currency_value.valueId).html(htmlContent);
                        $('#' + currency_value.flagId).html(htmlContent2);
                        
                        $('#' + currency_value.often_value).html(htmlContent3);
                        $('#' + currency_value.sale_value).html(htmlContent3);
                        $('#' + currency_value.purchase_value).html(htmlContent3);
                        
                    } else {
                        // 응답 데이터가 없을 경우 처리 (예: 기본 메시지)
                        $('#' + currency_value.valueId).html('<div>데이터 없음</div>');
                        $('#' + currency_value.flagId).html('<span>데이터 없음</span>');
                        
                        $('#' + currency_value.often_value).html('<i>데이터 없음</i>');
                        $('#' + currency_value.sale_value).html('<i>데이터 없음</i>');
                        $('#' + currency_value.purchase_value).html('<i>데이터 없음</i>');
                    }
                });
                resolve(); // 프로미스 해결
            },
            error: function(xhr, status, error) {
                console.error('데이터를 가져오는 데 실패했습니다:', error);
                currencies_value.forEach(currency_value => {
                    $('#' + currency_value.valueId).html('<div>데이터를 가져오는 데 실패했습니다.</div>');
                    $('#' + currency_value.flagId).html('<span>데이터를 가져오는 데 실패했습니다.</span>');
                    
                    $('#' + currency_value.often_value).html('<i>데이터를 가져오는 데 실패했습니다.</i>');
                    $('#' + currency_value.sale_value).html('<i>데이터를 가져오는 데 실패했습니다.</i>');
                    $('#' + currency_value.purchase_value).html('<i>데이터를 가져오는 데 실패했습니다.</i>');
                });
                reject(error); // 프로미스 거부
            }
        });
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
