<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<!-- 기준 통화 섹션 -->
			<div class="currency-section baseSection">
				<!-- 기준 통화 SelectBox -->
				<div class="selectBoxWrap">
					<img class="baseImg" src="resources/img/gonfalon/USD.png" /> <select
						id="base-currency-select" class="base-currency-select">
						<option value="KRW" data-rate="1" data-curr="원">대한민국
							(KRW)</option>
						<c:forEach var="exchange" items="${list}">
							<c:set var="base_r" value="${exchange.base_r }" />
							<c:if
								test="${exchange.c_code eq 'JPY' || exchange.c_code eq 'VND'}">
								<c:set var="base_r" value="${base_r / 100}" />
							</c:if>
							<option value="${exchange.c_code}" data-rate="${base_r }"
								data-curr="${exchange.c_name }"
								<c:if test="${exchange.c_code eq 'USD'}">selected</c:if>>
								${exchange.c_country} (${exchange.c_code})</option>
						</c:forEach>
					</select>
				</div>

				<!-- 기준 통화 금액 입력 InputBox -->
				<input type="text" id="base-amount-input" class="base-amount-input"
					placeholder="금액 입력" value="1" />

				<!-- 기준 통화 결과 입력 InputBox -->
				<input type="text" id="base-result-input" class="base-result-input"
					placeholder="변환 결과" readonly />
			</div>

			<!-- '=' 문자 -->
			<img alt="" src="resources/img/equals.png" class="equals-sign">

			<!-- 결과 통화 섹션 -->
			<div class="currency-section resultSection">
				<!-- 결과 통화 SelectBox -->
				<div class="selectBoxWrap">
					<img class="resultImg" src="resources/img/gonfalon/KRW.png" /> <select
						id="result-currency-select" class="result-currency-select">
						<option value="KRW" data-rate="1" data-curr="원" selected>대한민국
							(KRW)</option>
						<c:forEach var="exchange" items="${list }">
							<c:set var="base_r" value="${exchange.base_r }" />
							<c:if
								test="${exchange.c_code eq 'JPY' || exchange.c_code eq 'VND'}">
								<c:set var="base_r" value="${base_r / 100}" />
							</c:if>
							<option value="${exchange.c_code}" data-rate="${base_r }"
								data-curr="${exchange.c_name }">${exchange.c_country}
								(${exchange.c_code})</option>
						</c:forEach>
					</select>
				</div>

				<!-- 결과 통화 금액 입력 InputBox -->
				<input type="text" id="result-amount-input"
					class="result-amount-input" placeholder="금액 입력" />

				<!-- 결과 통화 결과 입력 InputBox -->
				<input type="text" id="result-result-input"
					class="result-result-input" placeholder="변환 결과" readonly />
			</div>