$(document).ready(function() {
    console.log('여기로 들어옴');
    
    $.ajax({
        url: "/ex/exchange/todayExchange",
        type: "POST",
        dataType: "json",
        success: function(res) {
        	console.log("response Result");
            console.log(res);
            updateCurrencySelect('#base-currency-select', res);
            updateCurrencySelect('#result-currency-select', res);
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
        if (rates[currencyCode]) {
            $(this).attr('data-rate', rates[currencyCode]);
        }else if(currencyCode == "KRW") {
        	$(this).attr('data-rate', 1);
        }else {
            $(this).removeAttr('data-rate'); // 데이터가 없는 경우 data-rate 속성 제거
        }
    });
}

$("#base-amount-input").keyup(function(e) {
	var beforeCurr = $("#base-currency-select option:selected");
	var afterCurr = $("#result-currency-select option:selected");
	var input = $("#base-amount-input").val();
	console.log(beforeCurr.val());
	var exchangeVal = currencyConvert(input, beforeCurr, afterCurr);

	$("#result-amount-input").val(exchangeVal.toFixed(2));
});

$("#result-amount-input").keyup(function(e) {
	var beforeCurr = $("#base-currency-select option:selected");
	var afterCurr = $("#result-currency-select option:selected");
	var input = $("#base-amount-input").val();
	var exchangeVal = currencyConvert(input, afterCurr, beforeCurr);

	$("#base-amount-input").val(exchangeVal.toFixed(2));
});

function currencyConvert(amount, fromCurr, toCurr) {
	
	if (fromCurr !== "KRW") {
		amount = amount * fromCurr.data('rate');
	}

	let c_Amount = amount / toCurr.data('rate');
	console.log("toCurr.val() : " + toCurr.val());
	if(toCurr.val() == 'JPY' || toCurr.val() == 'VND') {
		c_Amount = c_Amount * 100;
	}
	
	console.log(c_Amount);
	return c_Amount;
}