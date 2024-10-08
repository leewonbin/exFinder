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

//통화 정보 배열 정의
const currencies_value = [
    { code: 'USD', valueId: 'value_USD' },
    { code: 'JPY', valueId: 'value_JPY' },
    { code: 'EUR', valueId: 'value_EUR' },
    { code: 'CNY', valueId: 'value_CNY' },
    { code: 'GBP', valueId: 'value_GBP' },
    { code: 'CHF', valueId: 'value_CHF' },
    { code: 'INR', valueId: 'value_INR' },
    { code: 'AUD', valueId: 'value_AUD' },
    { code: 'SAR', valueId: 'value_SAR' },
    { code: 'RUB', valueId: 'value_RUB' },
    { code: 'CAD', valueId: 'value_CAD' },
    { code: 'HKD', valueId: 'value_HKD' },
    { code: 'EGP', valueId: 'value_EGP' },
    { code: 'THB', valueId: 'value_THB' },
    { code: 'VND', valueId: 'value_VND' },
    { code: 'ZAR', valueId: 'value_ZAR' },
    { code: 'MXN', valueId: 'value_MXN' },
    { code: 'BRL', valueId: 'value_BRL' },
    { code: 'ILS', valueId: 'value_ILS' },
    { code: 'NZD', valueId: 'value_NZD' }
];

$(document).ready(function() {
	processCurrencies_value(currencies_value);
	
});

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
                       
                        const absDifference = Math.abs(difference); // 차이의 절대값
                        const absPercent = Math.abs(percent); // 퍼센트의 절대값

                        if (difference > 0) {
                            // 차이가 양수인 경우 (현재 환율이 어제 환율보다 높음)
                            result = today_base_r + ' ▲' + absDifference.toFixed(2) + ' +' + absPercent.toFixed(2) + '%';
                            cssClass = 'increased';
       
                        } else if (difference === 0) {
                            result = today_base_r + ' -' + absDifference.toFixed(2) + ' ' + absPercent.toFixed(2) + '%';
                            cssClass = 'unchanged';
                            
                        } else if (difference < 0) {
                        	// 차이가 음수인 경우 (현재 환율이 어제 환율보다 낮음)
                            result = today_base_r + ' ▼' + absDifference.toFixed(2) + ' -' + absPercent.toFixed(2) + '%';
                            cssClass = 'decreased';
                        }

                        // HTML 콘텐츠 업데이트
                        const htmlContent = '<span class="' + cssClass + '">' + result + '</span>';

                        // ID로 HTML 업데이트
                        $('#' + currency_value.valueId).html(htmlContent);
                    } else {
                        // 응답 데이터가 없을 경우 처리 (예: 기본 메시지)
                        $('#' + currency_value.valueId).html('<span>데이터 없음</span>');         
                    }
                });
                resolve(); // 프로미스 해결
            },
            error: function(xhr, status, error) {
                console.error('데이터를 가져오는 데 실패했습니다:', error);
                currencies_value.forEach(currency_value => {
                    $('#' + currency_value.valueId).html('<span>데이터를 가져오는 데 실패했습니다.</span>');                
                });
                reject(error); // 프로미스 거부
            }
        });
    });
}

