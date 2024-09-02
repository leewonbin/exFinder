$(document).ready(function() {
    $(".update-btn").click(function() {
        $(".result_p").text("업데이트 중....");
        $.ajax({
            url: "/ex/exchange/update",
            type: "post",
            success: function(res) {
                if (res === "SUCCESS") {
                    $(".result_p").text("업데이트 완료 !!!....");
                }
            }
        });
    });

    $(".select-btn").click(function() {
        $.ajax({
            url: "/ex/exchange/chartInfo",
            type: "POST",
            dataType: "json",
            data : {
            	startDate: "2024-08-01",
                endDate: "2024-08-30",
                currency: "c_code"
            },
            success: function(res) {
                console.log(res);
                
                for (var key in res) {
                    if (res.hasOwnProperty(key)) {
                        console.log("Currency Code: " + key);
                        console.log("Exchange Rates: ", res[key]);
                    }
                }
            }
        });
    });
});
