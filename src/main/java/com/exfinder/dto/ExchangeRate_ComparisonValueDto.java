package com.exfinder.dto;

import java.math.BigDecimal; // BigDecimal은 주로 정밀한 소수점 연산을 다루기 위해 사용됩니다. 특히, 금융 및 화폐 관련 계산에서 매우 유용합니다.


public class ExchangeRate_ComparisonValueDto {
	
    private String c_code;        // 통화 코드
    private BigDecimal deal_bas_r; // 기준 환율 (notice)
    private BigDecimal diff;       // 차이
    private BigDecimal diff_percent; // 차이 백분율

    // 기본 생성자
    public ExchangeRate_ComparisonValueDto() {}

    // 매개변수가 있는 생성자 (필요한 경우)
    public ExchangeRate_ComparisonValueDto(String c_code, BigDecimal deal_bas_r, BigDecimal diff, BigDecimal diff_percent) {
        this.c_code = c_code;
        this.deal_bas_r = deal_bas_r;
        this.diff = diff;
        this.diff_percent = diff_percent;
    }

    // Getter and Setter methods
    public String getC_code() {
        return c_code;
    }

    public void setC_code(String c_code) {
        this.c_code = c_code;
    }

    public BigDecimal getDeal_bas_r() {
        return deal_bas_r;
    }

    public void setDeal_bas_r(BigDecimal deal_bas_r) {
        this.deal_bas_r = deal_bas_r;
    }

    public BigDecimal getDiff() {
        return diff;
    }

    public void setDiff(BigDecimal diff) {
        this.diff = diff;
    }

    public BigDecimal getDiff_percent() {
        return diff_percent;
    }

    public void setDiff_percent(BigDecimal diff_percent) {
        this.diff_percent = diff_percent;
    }

    // toString() method (for debugging or logging)
    @Override
    public String toString() {
        return "ExchangeRate_ComparisonValueDto{" +
                "c_code='" + c_code + '\'' +
                ", deal_bas_r=" + deal_bas_r +
                ", diff=" + diff +
                ", diff_percent=" + diff_percent +
                '}';
    }
}
