$(document).ready(function() {
    updateExchangeRate();
});
function currencyConvert(amount, fromCurr, toCurr) {
    let exchangeAmount = parseFloat(amount.replace(/,/g, ''));
    
    const fromRate = fromCurr.data('rate') || 1;
    const toRate = toCurr.data('rate') || 1;

    // KRW가 아닌 경우, fromCurr의 data-rate 적용
    if (fromCurr.val() !== "KRW") {
        exchangeAmount *= fromRate;
    }

    // 결과를 도착 통화의 data-rate로 나누기
    let result = exchangeAmount / toRate;

   if (toCurr.val() === fromCurr.val()) {
      return result;
    }
    return result;
}

function numberWithCommas(val) {
    // 숫자형 값으로 변환 후 포맷 적용
    const number = parseFloat(val);
    if (isNaN(number)) return '';
    return number.toLocaleString();
}

function updateResultInput() {
    const baseCurr = $("#base-currency-select option:selected");
    const resultCurr = $("#result-currency-select option:selected");

    // 숫자로 변환 후 포맷 적용
    const baseAmount = $("#base-amount-input").val().replace(/,/g, '');
    const resultAmount = $("#result-amount-input").val().replace(/,/g, '');

    const beforeFormatted = numberWithCommas(baseAmount) + baseCurr.data('curr');
    $("#base-result-input").val(beforeFormatted);
    
    const afterFormatted = numberWithCommas(resultAmount) + resultCurr.data('curr');
    $("#result-result-input").val(afterFormatted);
    
    // 입력 필드에 포맷 적용
    $("#base-amount-input").val(numberWithCommas(baseAmount));
    $("#result-amount-input").val(numberWithCommas(resultAmount));
}

function updateExchangeRate() {
    const baseAmount = $("#base-amount-input").val();
    const baseCurr = $("#base-currency-select option:selected");
    const resultCurr = $("#result-currency-select option:selected");

    const exchangeVal = currencyConvert(baseAmount, baseCurr, resultCurr);
    $("#result-amount-input").val(exchangeVal.toFixed(2));

    updateResultInput();
}

$("#base-amount-input").keyup(updateExchangeRate);
$("#result-amount-input").keyup(function() {
    const baseCurr = $("#base-currency-select option:selected");
    const resultCurr = $("#result-currency-select option:selected");
    const resultAmount = $("#result-amount-input").val();
    const exchangeVal = currencyConvert(resultAmount, resultCurr, baseCurr);

    $("#base-amount-input").val(exchangeVal.toFixed(2));
    updateResultInput();
});

$("#base-currency-select, #result-currency-select").change(function() {
	updateExchangeRate();
    const baseCurr = $("#base-currency-select option:selected");
    const resultCurr = $("#result-currency-select option:selected");
    const baseImgUrl = "resources/img/gonfalon/"+baseCurr.val()+".png";
    const resultImgUrl = "resources/img/gonfalon/"+resultCurr.val()+".png";
    $(".baseImg").attr("src",baseImgUrl);
    $(".resultImg").attr("src",resultImgUrl);
});
