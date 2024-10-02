<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<img
		src="${pageContext.request.contextPath}/resources/img/gonfalon/world_map3.png"
		class="map-image">
	<div class="flag map_america" style="top: 175px; left: 910px;">
		<a class="flag-content" href="exFinder_Currency?c_code=USD"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/USD.png">
			<label>미국</label> <span id="flag_USD"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 300px; left: 485px;">
		<a class="flag-content" href="exFinder_Currency?c_code=JPY"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/JPY.png">
			<label>일본</label> <span id="flag_JPY"></span>
		</a> <i class="line" style="top: -55px; left: 20px;"></i> <i
			class="circle" style="top: -55px; left: 13px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_europe" style="top: 240px; left: 20px;">
		<a class="flag-content" href="exFinder_Currency?c_code=EUR"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/EUR.png">
			<label>유럽연합</label> <span id="flag_EUR"></span>
		</a> <i class="line" style="top: -40px; left: 80px; height: 30px;"></i> <i
			class="circle"
			style="top: -42px; left: 71px; width: 20px; height: 20px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 200px; left: 420px;">
		<a class="flag-content" href="exFinder_Currency?c_code=CNY"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/CNY.png">
			<label>중국</label> <span id="flag_CNY"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_europe" style="top: 80px; left: 75px;">
		<a class="flag-content" href="exFinder_Currency?c_code=GBP"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/GBP.png">
			<label>영국</label> <span id="flag_GBP"></span>
		</a> <i class="line" style="top: 19px; left: 20px; height: 75px;"></i> <i
			class="circle" style="top: 95px; left: 13px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_europe" style="top: 133px; left: 100px;">
		<a class="flag-content" href="exFinder_Currency?c_code=CHF"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/CHF.png">
			<label>스위스</label> <span id="flag_CHF"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_america" style="top: 110px; left: 810px;">
		<a class="flag-content" href="exFinder_Currency?c_code=CAD"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/CAD.png">
			<label>캐나다</label> <span id="flag_CAD"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 250px; left: 270px;">
		<a class="flag-content" href="exFinder_Currency?c_code=INR"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/INR.png">
			<label>인도</label> <span id="flag_INR"></span>
		</a> <i class="line" style="top: 19px; left: 40px;"></i> <i class="circle"
			style="top: 65px; left: 33px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 340px; left: 420px;">
		<a class="flag-content" href="exFinder_Currency?c_code=HKD"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/HKD.png">
			<label>홍콩</label> <span id="flag_HKD"></span>
		</a> <i class="line" style="top: -50px; left: 10px; height: 40px;"></i> <i
			class="circle" style="top: -50px; left: 3px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_middle_east" style="top: 340px; left: 150px;">
		<a class="flag-content" href="exFinder_Currency?c_code=EGP"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/EGP.png">
			<label>이집트</label> <span id="flag_EGP"></span>
		</a> <i class="line" style="top: -55px; left: 20px;"></i> <i
			class="circle" style="top: -55px; left: 13px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_middle_east" style="top: 215px; left: 200px;">
		<a class="flag-content" href="exFinder_Currency?c_code=SAR"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/SAR.png">
			<label>사우디</label> <span id="flag_SAR"></span>
		</a> <i class="line" style="top: 19px; left: 20px; height: 60px;"></i> <i
			class="circle" style="top: 80px; left: 13px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_oceania" style="top: 440px; left: 510px;">
		<a class="flag-content" href="exFinder_Currency?c_code=AUD"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/AUD.png">
			<label>호주</label> <span id="flag_AUD"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 415px; left: 355px;">
		<a class="flag-content" href="exFinder_Currency?c_code=THB"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/THB.png">
			<label>태국</label> <span id="flag_THB"></span>
		</a> <i class="line" style="top: -95px; left: 30px; height: 85px;"></i> <i
			class="circle" style="top: -95px; left: 23px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 70px; left: 400px;">
		<a class="flag-content" href="exFinder_Currency?c_code=RUB"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/RUB.png">
			<label>러시아</label> <span id="flag_RUB"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_asia" style="top: 380px; left: 390px;">
		<a class="flag-content" href="exFinder_Currency?c_code=VND"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/VND.png">
			<label>베트남</label> <span id="flag_VND"></span>
		</a> <i class="line" style="top: -40px; left: 20px; height: 30px;"></i> <i
			class="circle" style="top: -45px; left: 13px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag" style="top: 430px; left: 130px;">
		<a class="flag-content" href="exFinder_Currency?c_code=ZAR"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/ZAR.png">
			<label>남아공</label> <span id="flag_ZAR"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_america" style="top: 350px; left: 930px;">
		<a class="flag-content" href="exFinder_Currency?c_code=BRL"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/BRL.png">
			<label>브라질</label> <span id="flag_BRL"></span>
		</a> <i class="line" style="top: 19px; left: 110px;"></i> <i
			class="circle" style="top: 65px; left: 103px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_america" style="top: 230px; left: 770px;">
		<a class="flag-content" href="exFinder_Currency?c_code=MXN"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/MXN.png">
			<label>멕시코</label> <span id="flag_MXN"></span>
		</a> <i class="line" style="top: 19px; left: 100px;"></i> <i
			class="circle" style="top: 65px; left: 93px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_middle_east" style="top: 180px; left: 169px;">
		<a class="flag-content" href="exFinder_Currency?c_code=ILS"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/ILS.png">
			<label>이스라엘</label> <span id="flag_ILS"></span>
		</a> <i class="line" style="top: 19px; left: 20px; height: 60px;"></i> <i
			class="circle" style="top: 80px; left: 13px;"> <i
			class="mini-circle"></i>
		</i>
	</div>
	<div class="flag map_oceania" style="top: 485px; left: 580px;">
		<a class="flag-content" href="exFinder_Currency?c_code=NZD"> <img
			src="${pageContext.request.contextPath}/resources/img/gonfalon/NZD.png">
			<label>뉴질랜드</label> <span id="flag_NZD"></span>
		</a> <i class="line" style="top: 19px; left: 20px;"></i> <i class="circle"
			style="top: 65px; left: 13px;"> <i class="mini-circle"></i>
		</i>
	</div>
</div>