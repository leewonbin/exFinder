<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="Cover-box1"></div>
			<div class="charts_container">
				<div class="slide-controls">
					<div class="Cover-button-box">
						<button id="prev-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/arrow.png"
								class="slide-controls-img" style="transform: scaleX(-1);">
						</button>
					</div>
					<div class="chart_graph_box_slide" id="slide-container">
						<c:forEach var="exchange" items="${list}" varStatus="status">
							<c:if test="${status.index % 2 == 0 }">
								<div class="chart_graph_box_container">
							</c:if>
							
							<div class="chart_graph_box">
								<div class="chart_graph_box_top">
									<img
										src="${pageContext.request.contextPath}/resources/img/gonfalon/${exchange.c_code}.png">
									<a href="exFinder_Currency?c_code=${exchange.c_code}">${exchange.c_country}
										${exchange.c_code}</a>
									<div id="value_${exchange.c_code}"></div>
								</div>
								
								<div id="chart_${exchange.c_code}" class="chart_graph"></div>
							</div>
							<c:if test="${status.index % 2 == 1 || status.last}">
					</div>
					</c:if>
					</c:forEach>
				</div>
				<div class="Cover-button-box">
					<button id="next-slide">
						<img
							src="${pageContext.request.contextPath}/resources/img/arrow.png"
							class="slide-controls-img">
					</button>
				</div>
			</div>
			<span id="slide-indicator">1 / 10</span>
		</div>
		<div class="Cover-box2"></div>