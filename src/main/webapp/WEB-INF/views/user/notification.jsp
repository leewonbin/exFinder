<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>환율 차트</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notification.css">
   
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <!-- JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/charts2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/notification.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
    <!-- 헤더 Include -->
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

    <p class="country-chart">환율 차트</p>
    <hr class="divider">

    <div class="charts_view">
        <div class="charts_container">
            <div id="chart-container">
                <!-- 각 통화의 그래프와 정보 표시 -->
                <div class="chart_graph_box_container" id="USD-chart" style="display: none;">
                    <div class="chart_graph_box">
                        <div class="chart_graph_box_top">
                            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
                            	미국 USD
                            <div id="value_USD"></div>
                        </div>
                        <div id="chart_USD" class="chart_graph"></div>
                    </div>
                </div>
                <div class="chart_graph_box_container" id="JPY-chart" style="display: none;">
                    <div class="chart_graph_box">
                        <div class="chart_graph_box_top">
                            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY.png">
                            	일본 JPY
                            <div id="value_JPY"></div>
                        </div>
                        <div id="chart_JPY" class="chart_graph"></div>
                    </div>
                </div>
                <div class="chart_graph_box_container" id="EUR-chart" style="display: none;">
                    <div class="chart_graph_box">
                        <div class="chart_graph_box_top">
                            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
                            	유럽연합 EU
                            <div id="value_EUR"></div>
                        </div>
                        <div id="chart_EUR" class="chart_graph"></div>
                    </div>
                </div>
                <div class="chart_graph_box_container" id="CNY-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
				            위안 CNY
				            <div id="value_CNY"></div>
				        </div>
				        <div id="chart_CNY" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="GBP-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
				            파운드 GBP
				            <div id="value_GBP"></div>
				        </div>
				        <div id="chart_GBP" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="CHF-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
				            프랑 CHF
				            <div id="value_CHF"></div>
				        </div>
				        <div id="chart_CHF" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="CAD-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
				            달러 CAD
				            <div id="value_CAD"></div>
				        </div>
				        <div id="chart_CAD" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="INR-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
				            루피 INR
				            <div id="value_INR"></div>
				        </div>
				        <div id="chart_INR" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="HKD-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
				            달러 HKD
				            <div id="value_HKD"></div>
				        </div>
				        <div id="chart_HKD" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="EGP-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
				            파운드 EGP
				            <div id="value_EGP"></div>
				        </div>
				        <div id="chart_EGP" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="SAR-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
				            리얄 SAR
				            <div id="value_SAR"></div>
				        </div>
				        <div id="chart_SAR" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="AUD-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
				            달러 AUD
				            <div id="value_AUD"></div>
				        </div>
				        <div id="chart_AUD" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="THB-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
				            바트 THB
				            <div id="value_THB"></div>
				        </div>
				        <div id="chart_THB" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="RUB-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
				            루블 RUB
				            <div id="value_RUB"></div>
				        </div>
				        <div id="chart_RUB" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="VND-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
				            동 VND
				            <div id="value_VND"></div>
				        </div>
				        <div id="chart_VND" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="ZAR-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
				            랜드 ZAR
				            <div id="value_ZAR"></div>
				        </div>
				        <div id="chart_ZAR" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="MXN-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
				            페소 MXN
				            <div id="value_MXN"></div>
				        </div>
				        <div id="chart_MXN" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="BRL-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
				            레알 BRL
				            <div id="value_BRL"></div>
				        </div>
				        <div id="chart_BRL" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="ILS-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
				            쉐캐림 ILS
				            <div id="value_ILS"></div>
				        </div>
				        <div id="chart_ILS" class="chart_graph"></div>
				    </div>
				</div>
				
				<div class="chart_graph_box_container" id="NZD-chart" style="display: none;">
				    <div class="chart_graph_box">
				        <div class="chart_graph_box_top">
				            <img src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
				            달러 NZD
				            <div id="value_NZD"></div>
				        </div>
				        <div id="chart_NZD" class="chart_graph"></div>
				    </div>
				</div>

            </div>
        </div>
    </div>

    <div id="alert-settings">
        <h1>환율 알림 설정</h1>
        <form action="/setExchangeAlert" method="post">
            <div class="form-group">
                <label for="currency">통화 선택 (원화 기준)</label>
                <select id="currency" name="currency" required>
                    <option value="">-- 통화를 선택하세요 --</option>
                    <option value="USD">미국 달러 (USD)</option>
                    <option value="EUR">유럽연합 유로 (EUR)</option>
                    <option value="JPY">일본 엔 (JPY)</option>
                    <option value="CNY">중국 위안 (CNY)</option>
					<option value="GBP">영국 파운드 (GBP)</option>
					<option value="CHF">스위스 프랑 (CHF)</option>
					<option value="CAD">캐나다 달러 (CAD)</option>
					<option value="INR">인도 루피 (INR)</option>
					<option value="HKD">홍콩 달러 (HKD)</option>
					<option value="EGP">이집트 파운드 (EGP)</option>
					<option value="SAR">사우디아라비아 리얄 (SAR)</option>
					<option value="AUD">호주 달러 (AUD)</option>
					<option value="THB">태국 바트 (THB)</option>
					<option value="RUB">러시아 루블 (RUB)</option>
					<option value="VND">베트남 동 (VND)</option>
					<option value="ZAR">남아프리카 랜드 (ZAR)</option>
					<option value="MXN">멕시코 페소 (MXN)</option>
					<option value="BRL">브라질 레알 (BRL)</option>
					<option value="ILS">이스라엘 쉐캐림 (ILS)</option>
					<option value="NZD">뉴질랜드 달러 (NZD)</option>
                    	
                    <!-- 다른 통화 추가 -->
                </select>
            </div>
            <!-- 목표 환율 입력 -->
            <div class="form-group">
                <label for="targetRate">목표 환율 (원화 기준)</label>
                <input type="text" id="targetRate" name="targetRate" placeholder="예: 1100.00" required oninput="calculateTolerance()">
            </div>

            <!-- 오차 범위 (%) 정보 -->
            <div class="form-group">
                <p id="toleranceInfo" style="color: green;"></p>
            </div>
            
            <!-- 전화번호 수신동의 -->
            <div class="checkbox-phone">
                <input type="checkbox" value="">전화번호로 알림을 수신하는 데 동의합니다.
            </div>

            <!-- 제출 버튼 -->
            <div class="form-group">
                <button type="submit" class="submit-btn">알림 설정</button>
            </div>

        </form>
    </div>

    <!-- JavaScript 선택한 통화 차트 -->
    <script>
        $(document).ready(function() {
            $('#currency').change(function() {
                // 선택된 통화의 차트 ID
                var selectedCurrency = $(this).val();
                
                // 모든 차트 숨기기
                $('.chart_graph_box_container').hide();

                // 선택한 통화의 차트 보이기
                if (selectedCurrency) {
                    $('#' + selectedCurrency + '-chart').show();
                }
            });
        });
    </script>
</body>
</html>
