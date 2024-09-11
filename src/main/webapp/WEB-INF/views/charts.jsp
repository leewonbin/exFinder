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
        /* 로딩 상태에서 페이지를 숨기기 위한 스타일 */
        body.loading {
            visibility: hidden;
            overflow: hidden;
        }
        body {
            transition: visibility 0s, opacity 0.5s linear;
        }
        body.loaded {
            visibility: visible;
            opacity: 1;
        }
    </style>
	<script>


	</script>
</head>
<body class="loading">
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
            					<div id="value_USD"></div>
            				</div>
            				<div id="chart_USD" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY2.png">
            					<a>일본 JPY</a>
            					<div id="value_JPY"></div>
            				</div>
            				<div id="chart_JPY" class="chart_graph"></div>
            			</div>    	
    	        	</div>
	            	<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
            					<a>유럽연합 EUR</a>
            					<div id="value_EUR"></div>
            				</div>
            				<div id="chart_EUR" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
            					<a>중국 CNY</a>
            					<div id="value_CNY"></div>
            				</div>
            				<div id="chart_CNY" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
            					<a>영국 GBP</a>
            					<div id="value_GBP"></div>
            				</div>
            				<div id="chart_GBP" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
            					<a>스위스 CHF</a>
            					<div id="value_CHF"></div>
            				</div>
            				<div id="chart_CHF" class="chart_graph"></div>
            			</div>
            		</div>
            		
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
            					<a>캐나다 CAD</a>
            					<div id="value_CAD"></div>
            				</div>
            				<div id="chart_CAD" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">            	
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
            					<a>인도 INR</a>
            					<div id="value_INR"></div>
            				</div>
            				<div id="chart_INR" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
            					<a>홍콩 HKD</a>
            					<div id="value_HKD" ></div>
            				</div>
            				<div id="chart_HKD" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
            					<a>이집트 EGP</a>
            					<div id="value_EGP"></div>
            				</div>
            				<div id="chart_EGP" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
            					<a>사우디 SAR</a>
            					<div id="value_SAR" ></div>
            				</div>
            				<div id="chart_SAR" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
            					<a>호주 AUD</a>
            					<div id="value_AUD"></div>
            				</div>
            				<div id="chart_AUD" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
            					<a>태국 THB</a>
            					<div id="value_THB" ></div>
            				</div>
            				<div id="chart_THB" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
            					<a>러시아 RUB</a>
            					<div id="value_RUB"></div>
            				</div>
            				<div id="chart_RUB" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
            					<a>베트남 VND</a>
            					<div id="value_VND" ></div>
            				</div>
            				<div id="chart_VND" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
            					<a>남아공 ZAR</a>
            					<div id="value_ZAR"></div>
            				</div>
            				<div id="chart_ZAR" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
            					<a>멕시코 MXN</a>
            					<div id="value_MXN" ></div>
            				</div>
            				<div id="chart_MXN" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
            					<a>브라질 BRL</a>
            					<div id="value_BRL"></div>
            				</div>
            				<div id="chart_BRL" class="chart_graph"></div>
            			</div>
            		</div>
            		<div class="chart_graph_box_container">
        	    		<div class="chart_graph_box">
        	    			<div class="chart_graph_box_top">
        	    				<img src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
            					<a>이스라엘 ILS</a>
            					<div id="value_ILS" ></div>
            				</div>
            				<div id="chart_ILS" class="chart_graph"></div>
            			</div>
            			<div class="chart_graph_box">
            				<div class="chart_graph_box_top">
            					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
            					<a>뉴질랜드 NZD</a>
            					<div id="value_NZD"></div>
            				</div>
            				<div id="chart_NZD" class="chart_graph"></div>
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
		<div class="world_map_header">
			<ul>
				<li><a href="#" id="world_all">전세계</a></li>
        		<li><a href="#" id="world_asia">아시아</a></li>
        		<li><a href="#" id="world_america">아메리카</a></li>
        		<li><a href="#" id="world_europe">유럽</a></li>
        		<li><a href="#" id="world_middle_east">중동</a></li>
        		<li><a href="#" id="world_oceania">오세아니아</a></li>
			</ul>
		</div>							
		<div class="world_map">
			<img src="${pageContext.request.contextPath}/resources/img/gonfalon/world_map3.png" class="map-image">
			<div class="flag map_america" style="top: 175px; left: 910px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
					<label>미국</label>
					<span id="flag_USD"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 300px; left: 485px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY.png">
					<label>일본</label>
					<span id="flag_JPY"></span>
				</a>
				<i class="line" style="top: -55px; left: 20px;"></i>
				<i class="circle" style="top: -55px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_europe" style="top: 240px; left: 20px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
					<label>유럽연합</label>
					<span id="flag_EUR"></span>
				</a>
				<i class="line" style="top: -40px; left: 80px; height: 30px;"></i>
				<i class="circle" style="top: -42px; left: 71px; width: 20px; height: 20px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 200px; left: 420px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
					<label>중국</label>
					<span id="flag_CNY"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_europe" style="top: 80px; left: 75px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
					<label>영국</label>
					<span id="flag_GBP"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px; height: 75px;"></i>
				<i class="circle" style="top: 95px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_europe" style="top: 133px; left: 100px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
					<label>스위스</label>
					<span id="flag_CHF"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_america" style="top: 110px; left: 810px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
					<label>캐나다</label>
					<span id="flag_CAD"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 250px; left: 270px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
					<label>인도</label>
					<span id="flag_INR"></span>
				</a>
				<i class="line" style="top: 19px; left: 40px;"></i>
				<i class="circle" style="top: 65px; left: 33px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 340px; left: 420px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
					<label>홍콩</label>
					<span id="flag_HKD"></span>
				</a>
				<i class="line" style="top: -50px; left: 10px; height: 40px;"></i>
				<i class="circle" style="top: -50px; left: 3px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_middle_east" style="top: 340px; left: 150px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
					<label>이집트</label>
					<span id="flag_EGP"></span>
				</a>
				<i class="line" style="top: -55px; left: 20px;"></i>
				<i class="circle" style="top: -55px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_middle_east" style="top: 215px; left: 200px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
					<label>사우디</label>
					<span id="flag_SAR"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px; height: 60px;"></i>
				<i class="circle" style="top: 80px; left: 13px; ">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_oceania" style="top: 440px; left: 510px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
					<label>호주</label>
					<span id="flag_AUD"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 415px; left: 355px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
					<label>태국</label>
					<span id="flag_THB"></span>
				</a>
				<i class="line" style="top: -95px; left: 30px; height: 85px;"></i>
				<i class="circle" style="top: -95px; left: 23px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 70px; left: 400px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
					<label>러시아</label>
					<span id="flag_RUB"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_asia" style="top: 380px; left: 390px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
					<label>베트남</label>
					<span id="flag_VND"></span>
				</a>
				<i class="line" style="top: -40px; left: 20px; height: 30px;"></i>
				<i class="circle" style="top: -45px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag" style="top: 430px; left: 130px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
					<label>남아공</label>
					<span id="flag_ZAR"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_america" style="top: 350px; left: 930px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
					<label>브라질</label>
					<span id="flag_BRL"></span>
				</a>
				<i class="line" style="top: 19px; left: 110px;"></i>
				<i class="circle" style="top: 65px; left: 103px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_america" style="top: 230px; left: 770px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
					<label>멕시코</label>
					<span id="flag_MXN"></span>
				</a>
				<i class="line" style="top: 19px; left: 100px;"></i>
				<i class="circle" style="top: 65px; left: 93px;">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_middle_east" style="top: 180px; left: 169px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
					<label>이스라엘</label>
					<span id="flag_ILS"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px; height: 60px;"></i>
				<i class="circle" style="top: 80px; left: 13px; ">
					<i class="mini-circle"></i>
				</i>
			</div>
			<div class="flag map_oceania" style="top: 485px; left: 580px;">
				<a class="flag-content">
					<img src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
					<label>뉴질랜드</label>
					<span id="flag_NZD"></span>
				</a>
				<i class="line" style="top: 19px; left: 20px;"></i>
				<i class="circle" style="top: 65px; left: 13px;">
					<i class="mini-circle"></i>
				</i>
			</div>
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