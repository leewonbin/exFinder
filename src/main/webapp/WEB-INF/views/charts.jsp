<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구글 차트</title>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/charts.css">  
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery.min.js"></script>
	<!-- google charts -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<!-- 슬라이드 효과를 위한 JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/charts.js"></script>
	<style>
/* p 태그 스타일 - 국가별 차트 */
.country-chart {
	font-size: 1.1em;
	font-weight: bold;
	margin-left: 325px; /* x 위치 조정 */
	margin-top: 100px; /* p 태그와 div 간의 간격 조정 */
}

/* 구분선 스타일 */
.divider {
	margin: 20px 0; /* 위 아래 여백 */
	border: none;
	height: 1px;
	background-color: #dcdcdc; /* 밝은 회색 구분선 */
}

.rectangle {
    position: absolute;    /* 부모 요소(.world_map)를 기준으로 고정 배치 */
    top: 200px;           /* 화면 위에서 100px 아래 */
    left: 50px;           /* 화면 왼쪽에서 50px 오른쪽으로 */
    width: 200px;         /* 직사각형의 가로 길이 */
    height: auto;         /* 내용에 따라 세로 길이를 자동 조정 */
    background-color: white; /* 배경색을 흰색으로 설정 */
    border: 1px solid gray;  /* 회색 테두리 */
    border-radius: 5px;   /* 직사각형 모서리를 살짝 둥글게 */
    padding: 10px;        /* 이미지와 텍스트의 안쪽 여백 */
    z-index: 10;
}

.rectangle img {
	width: 25px;         /* 이미지를 부모 요소의 너비에 맞게 조정 */
    height: 25px;
}

    </style>
	<script>


	</script>
</head>
<body>
	<!-- 중앙에 위치시키기 위한 div -->
    <div class="charts_view">
    	<div class="Cover-box1"></div>
        <div class="charts_container">
            <div class="slide-controls">
            	<div class="Cover-button-box">
            		<button id="prev-slide">
            			<img src="${pageContext.request.contextPath}/resources/img/arrow.png" class="slide-controls-img" style="transform: scaleX(-1);">
            		</button>
            	</div>
            	<div class="chart_graph_box_slide" id="slide-container">
            	    <div class="chart_graph_box_container">
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
            					<a>미국 USD</a>        					
            					<div id="value"></div>
            				</div>
            				<div id="chart_div" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY2.png">
            					<a>일본 JPY</a>
            					<div id="value2"></div>
            				</div>
            				<div id="chart_div2" class="chart_graph"></div>
            			</div>    	
    	        	</div>
	            	<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
            					<a>유럽연합 EUR</a>
            					<div id="value3"></div>
            				</div>
            				<div id="chart_div3" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
            					<a>중국 CNY</a>
            					<div id="value4"></div>
            				</div>
            				<div id="chart_div4" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
            					<a>영국 GBP</a>
            					<div id="value5"></div>
            				</div>
            				<div id="chart_div5" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
            					<a>스위스 CHF</a>
            					<div id="value6"></div>
            				</div>
            				<div id="chart_div6" class="chart_graph"></div>
            			</div>
            		</div>
            		
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
            					<a>캐나다 CAD</a>
            					<div id="value7"></div>
            				</div>
            				<div id="chart_div7" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">            	
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
            					<a>인도 INR</a>
            					<div id="value8"></div>
            				</div>
            				<div id="chart_div8" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
            					<a>홍콩 HKD</a>
            					<div id="value9" ></div>
            				</div>
            				<div id="chart_div9" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
            					<a>이집트 EGP</a>
            					<div id="value10"></div>
            				</div>
            				<div id="chart_div10" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
            					<a>사우디 SAR</a>
            					<div id="value11" ></div>
            				</div>
            				<div id="chart_div11" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
            					<a>호주 AUD</a>
            					<div id="value12"></div>
            				</div>
            				<div id="chart_div12" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
            					<a>태국 THB</a>
            					<div id="value13" ></div>
            				</div>
            				<div id="chart_div13" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
            					<a>러시아 RUB</a>
            					<div id="value14"></div>
            				</div>
            				<div id="chart_div14" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
            					<a>베트남 VND</a>
            					<div id="value15" ></div>
            				</div>
            				<div id="chart_div15" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
            					<a>남아공 ZAR</a>
            					<div id="value16"></div>
            				</div>
            				<div id="chart_div16" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
            					<a>멕시코 MXN</a>
            					<div id="value17" ></div>
            				</div>
            				<div id="chart_div17" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
            					<a>브라질 BRL</a>
            					<div id="value18"></div>
            				</div>
            				<div id="chart_div18" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
            					<a>이스라엘 ILS</a>
            					<div id="value19" ></div>
            				</div>
            				<div id="chart_div19" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
            					<a>뉴질랜드 NZD</a>
            					<div id="value20"></div>
            				</div>
            				<div id="chart_div20" class="chart_graph"></div>
            			</div>
            		</div>
            	</div>
            	<div class="Cover-button-box">
            		<button id="next-slide">
            			<img src="${pageContext.request.contextPath}/resources/img/arrow.png" class="slide-controls-img" >
            		</button>        		
            	</div>
    		</div>
    		<span id="slide-indicator">1 / 10</span>
        </div>
        <div class="Cover-box2"></div>
    </div>
    
    <!-- 국가별 차트 p 태그 -->
	<p class="country-chart">오늘의 세계 증시</p>

	<!-- 구분선 -->
	<hr class="divider">
	<div class="world_map_view">
		<div class="world_map">
			<img src="${pageContext.request.contextPath}/resources/img/gonfalon/world_map.png" class="map-image">
			<span class="rectangle">
				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
				<a>미국</a>
			</span>
		</div>
	</div>
</body>

</html>


<!-- 
글자 스타일    
red 	today_base_r > yesterday_base_r  ${today_base_r} ▲${difference.toFixed(2)} +${percent.toFixed(2)}% 
Gray	today_base_r = yesterday_base_r  ${today_base_r} -${difference.toFixed(2)} ${percent.toFixed(2)}% 
green   today_base_r < yesterday_base_r  ${today_base_r} ▼${difference.toFixed(2)} -${percent.toFixed(2)}%

	google.charts.load('current', {'packages':['corechart']}); //차트 스타일
	google.charts.setOnLoadCallback(drawCharts);
	
	function drawCharts() {
        var data = new google.visualization.DataTable();
        data.addColumn('date', 'Date');     // 첫 번째 열: 날짜
        data.addColumn('number', 'Value');  // 두 번째 열: 값

       
        data.addRows([   		
            [new Date(2024, 0, 2), 1289.4], [new Date(2024, 0, 3), 1299.3], [new Date(2024, 0, 4), 1308.8], [new Date(2024, 0, 5), 1310.2], 
            [new Date(2024, 0, 8), 1313.7], [new Date(2024, 0, 9), 1314.8], [new Date(2024, 0, 10), 1312.1], [new Date(2024, 0, 11), 1320.1], [new Date(2024, 0, 12), 1316], 
            [new Date(2024, 0, 15), 1314.1], [new Date(2024, 0, 16), 1319.3], [new Date(2024, 0, 17), 1329], [new Date(2024, 0, 18), 1343.2], [new Date(2024, 0, 19), 1342.4], 
            [new Date(2024, 0, 22), 1336.5], [new Date(2024, 0, 23), 1334.7], [new Date(2024, 0, 24), 1336], [new Date(2024, 0, 25), 1339.1], [new Date(2024, 0, 26), 1335.7], 
            [new Date(2024, 0, 29), 1336.6], [new Date(2024, 0, 30), 1336.9], [new Date(2024, 0, 31), 1330.6],  [new Date(2024, 1, 1), 1336.5], [new Date(2024, 1, 2), 1322.5], 
            
            [new Date(2024, 1, 5), 1325.1], [new Date(2024, 1, 6), 1334.6], [new Date(2024, 1, 7), 1329.6], [new Date(2024, 1, 8), 1325.3], 
            [new Date(2024, 1, 13), 1327.2], [new Date(2024, 1, 14), 1328.4], [new Date(2024, 1, 15), 1336.9], [new Date(2024, 1, 16), 1333.2], 
            [new Date(2024, 1, 19), 1329.3], [new Date(2024, 1, 20), 1331.4], [new Date(2024, 1, 21), 1331.3], [new Date(2024, 1, 22), 1335], [new Date(2024, 1, 23), 1331], 
            [new Date(2024, 1, 26), 1329.3], [new Date(2024, 1, 27), 1331.4], [new Date(2024, 1, 28), 1331.3], [new Date(2024, 1, 29), 1334],
            
            [new Date(2024, 2, 4), 1334.1], [new Date(2024, 2, 5), 1330.1], [new Date(2024, 2, 6), 1333.2], [new Date(2024, 2, 7), 1335.7], [new Date(2024, 2, 8), 1329.6],
            [new Date(2024, 2, 11), 1323.1], [new Date(2024, 2, 12), 1314.4], [new Date(2024, 2, 13), 1311.1], [new Date(2024, 2, 14), 1312.8], [new Date(2024, 2, 15), 1316.9],
            [new Date(2024, 2, 18), 1328.4], [new Date(2024, 2, 19), 1333], [new Date(2024, 2, 20), 1338.5], [new Date(2024, 2, 21), 1338.7], [new Date(2024, 2, 22), 1326.3],
            [new Date(2024, 2, 25), 1336.1], [new Date(2024, 2, 26), 1340.7], [new Date(2024, 2, 27), 1338.6], [new Date(2024, 2, 28), 1345.8], [new Date(2024, 2, 29), 1346.8],
            
            
        ]);
		
	    var options = {
	    	    hAxis: {
	    	        title: '년도',
	    	        format: 'yy/MM/dd', // 날짜 형식 지정
	    	        gridlines: { count: -1 }, // 자동 그리드라인 수 조정
	    	        viewWindowMode: 'maximized',
	    	        ticks: [ // X축에 표시할 날짜를 지정
	    	            new Date(2024, 0, 2),
	    	            new Date(2024, 0, 8),
	    	            new Date(2024, 0, 15),
	    	            new Date(2024, 0, 22),
	    	            new Date(2024, 0, 29),
	    	            new Date(2024, 1, 5),
	    	            new Date(2024, 1, 13),
	    	            new Date(2024, 1, 19),
	    	            new Date(2024, 1, 26),
	    	            new Date(2024, 2, 4),
	    	            new Date(2024, 2, 11),
	    	            new Date(2024, 2, 18),
	    	            new Date(2024, 2, 25),
	    	            new Date(2024, 2, 29),
	    	        ]
	    	    },
	    	    vAxis: {
	    	        title: '달러, USD',
	    	        logScale: false
	    	    },
	    	    colors: ['#a52714'],
	    	    legend: { position: 'none' } // 범례를 숨깁니다.
	    	};

	    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	    chart.draw(data, options);
	}
-->