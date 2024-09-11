$(document).ready(function() {
    console.log('여기로 들어옴');

    $.ajax({
        url: "/ex/exchange/todayExchange",
        type: "POST",
        dataType: "json",
        success: function(res) {
            updateCurrencySelect('#base-currency-select', res);
            updateCurrencySelect('#result-currency-select', res);

            // 기준 통화 입력값으로 초기 계산
            updateExchangeRate();
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", status, error);  // 오류 내용 출력
            console.error(xhr.responseText);  // 서버에서 응답한 에러 메시지 출력
        }
    });
});

function updateCurrencySelect(selectId, rates) {
    $(selectId).find('option').each(function() {
        const currencyCode = $(this).val(); // <option>의 value 값
        const rate = rates[currencyCode] || (currencyCode === "KRW" ? 1 : undefined);
        if (rate) {
            $(this).attr('data-rate', rate);
        } else {
            $(this).removeAttr('data-rate'); // 데이터가 없는 경우 data-rate 속성 제거
        }
    });
}

function currencyConvert(amount, fromCurr, toCurr) {
    let exchangeAmount = parseFloat(amount);
    
    const fromRate = fromCurr.data('rate') || 1;
    const toRate = toCurr.data('rate') || 1;

    // KRW가 아닌 경우, fromCurr의 data-rate 적용
    if (fromCurr.val() !== "KRW") {
        exchangeAmount *= fromRate;
    }

    // 결과를 도착 통화의 data-rate로 나누기
    let result = exchangeAmount / toRate;

    if(toCurr.val() === 'JPY' && fromCurr.val() === 'VND' || fromCurr.val() === 'JPY' && toCurr.val() === 'VND') {
    	return result;
    }else if(toCurr.val() === fromCurr.val()) {
    	return result;
    }else if (toCurr.val() === 'JPY' || toCurr.val() === 'VND' || fromCurr.val() == 'JPY' || fromCurr.val() == 'VND') {
    	result /= 100;
    }
    // 출발 통화가 JPY 또는 VND인 경우 100을 곱함

    return result;
}

function updateExchangeRate() {
    const baseAmount = $("#base-amount-input").val();
    const baseCurr = $("#base-currency-select option:selected");
    const resultCurr = $("#result-currency-select option:selected");

    const exchangeVal = currencyConvert(baseAmount, baseCurr, resultCurr);
    $("#result-amount-input").val(exchangeVal.toFixed(2));
}

$("#base-amount-input").keyup(updateExchangeRate);
$("#result-amount-input").keyup(function() {
    const baseCurr = $("#base-currency-select option:selected");
    const resultCurr = $("#result-currency-select option:selected");
    const resultAmount = $("#result-amount-input").val();
    const exchangeVal = currencyConvert(resultAmount, resultCurr, baseCurr);

    $("#base-amount-input").val(exchangeVal.toFixed(2));
});

$("#base-currency-select, #result-currency-select").change(updateExchangeRate);
