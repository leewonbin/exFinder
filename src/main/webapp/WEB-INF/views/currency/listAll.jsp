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
	<div class="currency-container">
		<select name="currency">
			<option value="USD">미국USD</option>
			<option value="JPY">일본JPY</option>
			<option value="CNY">중국CNY</option>
			<option value="EUR">유로EUR</option>
			<option value="GBP">영국GBP</option>
			<option value="AUD">호주AUD</option>
			<option value="THB">태국THB</option>
		</select>
	</div>

	<h1>환율조회</h1>

	<div class="box-contents">
		<div>
			<table class="exchange">
				<thead>
					<tr class="leftL">
						<th rowspan="2" class="lAlign"></th>
						<th rowspan="2">국가명</th>
						<th rowspan="2">통화</th>
						<th rowspan="2">매매기준율</th>
						<th rowspan="2">전일비</th>
						<th colspan="2">현찰</th>
						<th colspan="2">송금(전신환)</th>
						<th rowspan="2">"환가"<br>"료율"
						</th>
						<th rowspan="2">"미화"<br>"환산율"
						</th>
					</tr>
					<tr class="leftL">
						<th class="leftL">사실때</th>
						<th>파실때</th>
						<th>보내실때</th>
						<th>받으실때</th>
					</tr>
				</thead>
				<tbody>
					<tr class="first">
						<td></td>
						<td class="first">달러</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr class>
						<td></td>
						<td class="first">위안</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr class>
						<td></td>
						<td class="first">엔</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>








</body>
</html>

