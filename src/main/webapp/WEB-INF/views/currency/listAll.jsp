<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="logout-status"
	content="${sessionScope.userId == null ? 'logged-out' : 'logged-in'}">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boardList.css">

<script
	src="${pageContext.request.contextPath}/resources/js/listAllJs.js"></script>
<body>
	<h1>환율조회</h1>

    <div class="box-contents">
        <div>
            <table class="exchange">
                <thead>
                    <tr class="chart">
                        <th rowspan="2">일자</th>
                        <th rowspan="2">국가명</th>
                        <th rowspan="2">통화</th>
                        <th rowspan="2">매매기준율</th>
                        <th rowspan="2">전일비</th>
                        <th colspan="2">현찰</th>
                        <th colspan="2">송금(전신환)</th>
                        <th rowspan="2">기준환율</th>
                    </tr>
                    <tr class="chartB">
                        <th class="leftL">사실때</th>
                        <th>파실때</th>
                        <th>보내실때</th>
                        <th>받으실때</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="currency" items="${list}">
                        <tr>
                            <td>${currency.rate_date}</td>
                            <td>${currency.c_country}</td>
                            <td>${currency.c_name}</td>
                            <td>${currency.deal_bas_r}</td>
                            <td>${currency.cash_buy - currency.deal_bas_r}</td>
                            <td>${currency.cash_buy}</td>
                            <td>${currency.cash_sell}</td>
                            <td>${currency.ttb}</td>
                            <td>${currency.tts}</td>
                            <td>${currency.base_r}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

