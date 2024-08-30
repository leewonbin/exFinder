package com.exfinder.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

public class ExchangeRateDto {
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate rate_date;
	private String c_code;
	private double ttb;
	private double tts;
	private double cash_buy;
	private double cash_sell;
	private double deal_bas_r;
	private double base_r;
	
	public ExchangeRateDto() {}
	
	public ExchangeRateDto(LocalDate rate_date, String c_code, double ttb, double tts, double cash_buy,
			double cash_sell, double deal_bas_r, double base_r) {
		super();
		this.rate_date = rate_date;
		this.c_code = c_code;
		this.ttb = ttb;
		this.tts = tts;
		this.cash_buy = cash_buy;
		this.cash_sell = cash_sell;
		this.deal_bas_r = deal_bas_r;
		this.base_r = base_r;
	}
	
	@Override
	public String toString() {
		return "ExchangeRateDto [rate_date=" + rate_date + ", c_code=" + c_code + ", ttb=" + ttb + ", tts=" + tts
				+ ", cash_buy=" + cash_buy + ", cash_sell=" + cash_sell + ", deal_bas_r=" + deal_bas_r + ", base_r="
				+ base_r + "]";
	}

	public LocalDate getRate_date() {
		return rate_date;
	}
	public void setRate_date(LocalDate rate_date) {
		this.rate_date = rate_date;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public double getTtb() {
		return ttb;
	}
	public void setTtb(double ttb) {
		this.ttb = ttb;
	}
	public double getTts() {
		return tts;
	}
	public void setTts(double tts) {
		this.tts = tts;
	}
	public double getCash_buy() {
		return cash_buy;
	}
	public void setCash_buy(double cash_buy) {
		this.cash_buy = cash_buy;
	}
	public double getCash_sell() {
		return cash_sell;
	}
	public void setCash_sell(double cash_sell) {
		this.cash_sell = cash_sell;
	}
	public double getDeal_bas_r() {
		return deal_bas_r;
	}
	public void setDeal_bas_r(double deal_bas_r) {
		this.deal_bas_r = deal_bas_r;
	}
	public double getBase_r() {
		return base_r;
	}
	public void setBase_r(double base_r) {
		this.base_r = base_r;
	}
	
	

}
