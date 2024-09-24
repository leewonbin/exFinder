<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>환율 알림 설정</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/alarm.css">
</head>
<body>
    <%@include file="/WEB-INF/views/header/exFinder_header.jsp"%>

    <div id="alert-settings">
        <h1>환율 알림 설정</h1>

        <form action="/setExchangeAlert" method="post">
            <!-- 통화 선택 -->
            <div class="form-group">
                <label for="currency">통화 선택 (원화 기준)</label>
                <select id="currency" name="currency" required>
                    <option value="">-- 통화를 선택하세요 --</option>
                    <option value="USD">미국 달러 (USD)</option>
                    <option value="EUR">유로 (EUR)</option>
                    <option value="JPY">일본 엔 (JPY)</option>
                    <!-- 필요에 따라 다른 통화 추가 -->
                </select>
            </div>

            <!-- 목표 환율 입력 -->
            <div class="form-group">
                <label for="targetRate">목표 환율 (원화 기준)</label>
                <input type="text" id="targetRate" name="targetRate" placeholder="예: 1100.00" required>
            </div>

            <!-- 오차 범위 (%) 입력 -->
            <div class="form-group">
                <label for="tolerance">오차 범위 (%)</label>
                <input type="number" id="tolerance" name="tolerance" placeholder="예: 5" required min="0">
            </div>

            <!-- 제출 버튼 -->
            <div class="form-group">
                <button type="submit" class="submit-btn">알림 설정</button>
            </div>
        </form>
    </div>

</body>
</html>
