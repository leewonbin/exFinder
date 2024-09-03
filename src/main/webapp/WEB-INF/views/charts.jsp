<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구글 차트</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

	<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawCharts);
	
	function drawCharts() {
        var data = new google.visualization.DataTable();
        data.addColumn('date', '달러');     // 첫 번째 열: 날짜
        data.addColumn('number', '환율');  // 두 번째 열: 값

        data.addRows([
            [new Date(2024, 0, 2), 1289.4], [new Date(2024, 0, 3), 1299.3], [new Date(2024, 0, 4), 1308.8], [new Date(2024, 0, 5), 1310.2], 
            [new Date(2024, 0, 8), 1313.7], [new Date(2024, 0, 9), 1314.8], [new Date(2024, 0, 10), 1312.1], [new Date(2024, 0, 11), 1320.1], [new Date(2024, 0, 12), 1316], 
            [new Date(2024, 0, 15), 1314.1], [new Date(2024, 0, 16), 1319.3], [new Date(2024, 0, 17), 1329], [new Date(2024, 0, 18), 1343.2], [new Date(2024, 0, 19), 1342.4], 
            [new Date(2024, 0, 22), 1336.5], [new Date(2024, 0, 23), 1334.7], [new Date(2024, 0, 24), 1336], [new Date(2024, 0, 25), 1339.1], [new Date(2024, 0, 26), 1335.7], 
            [new Date(2024, 0, 29), 1336.6], [new Date(2024, 0, 30), 1336.9], [new Date(2024, 0, 31), 1330.6],  [new Date(2024, 1, 1), 1336.5], [new Date(2024, 1, 2), 1322.5], 
            
            [new Date(2024, 1, 5), 1325.1], [new Date(2024, 1, 6), 1334.6], [new Date(2024, 1, 7), 1329.6], [new Date(2024, 1, 8), 1325.3], 
            [new Date(2024, 1, 13), 1327.2], [new Date(2024, 1, 14), 1328.4], [new Date(2024, 1, 15), 1336.9], [new Date(2024, 1, 16), 1333.2], 
            [new Date(2024, 1, 19), 1329.3], [new Date(2024, 1, 20), 1331.4], [new Date(2024, 1, 21), 1331.3], [new Date(2024, 1, 22), 1335], [new Date(2024, 1, 23), 1331], 
            [new Date(2024, 1, 26), 1329.3], [new Date(2024, 1, 27), 1331.4], [new Date(2024, 1, 28), 1331.3], [new Date(2024, 1, 29), 1334]
        ]);

	    var options = {
	    	    hAxis: {
	    	        title: 'Date',
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
	    	            new Date(2024, 1, 29),
	    	        ]
	    	    },
	    	    vAxis: {
	    	        title: 'Value',
	    	        logScale: false
	    	    },
	    	    colors: ['#a52714'],
	    	    legend: { position: 'none' } // 범례를 숨깁니다.
	    	};

	    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	    chart.draw(data, options);
	}
    </script>
</head>
<body>
	<div id="chart_div" style="float: left; width:1000px; height:auto;"></div>
</body>
</html>