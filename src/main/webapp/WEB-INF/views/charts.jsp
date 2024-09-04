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
    <script type="text/javascript">
    	var contextPath = "${pageContext.request.contextPath}";
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/charts.js"></script>
   
    
</head>
<body>
	<!-- 중앙에 위치시키기 위한 div -->
    <div class="charts_view">
        <div class="charts_container">
            <h1>주요국 차트</h1>
            <button id="prev-slide"> 이전 </button>
            <div class="chart_graph_box_slide" id="slide-container">
            	<div class="chart_graph_box_container">
            		<div class="chart_graph_box">
            			<img src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
            			<a>미국 USD</a><br>
            			<div id="chart_div" class="chart_graph"></div>
            		</div>
            		<div class="chart_graph_box">
            			<img src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY2.png">
            			<a>일본 JPY</a><br>
            			<div id="chart_div2" class="chart_graph"></div>
            		</div>    	
    	        </div>
	            <div class="chart_graph_box_container">
        	    	<div class="chart_graph_box">
            			<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
            			<a>유럽연합 EUR</a>
            			<div id="chart_div3" class="chart_graph"></div>
            		</div>
            		<div class="chart_graph_box">
            			<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
            			<a>중국 CNY</a><br>
            			<div id="chart_div4" class="chart_graph"></div>
            		</div>
            	</div>
            </div>
            <button id="next-slide">다음</button>
            <div class="slide-controls">
        		<button id="prev-slide"> 이전 </button>
        		<span id="slide-indicator">1/2</span>
        		<button id="next-slide">다음</button>
    		</div>
        </div>
    </div>
</body>

</html>


<!--
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