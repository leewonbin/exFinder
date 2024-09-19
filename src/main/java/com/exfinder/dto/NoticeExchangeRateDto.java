package com.exfinder.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

public class NoticeExchangeRateDto {
    private String c_code;        // 통화 코드
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate rate_date;
    private String annoTime;      // 시간
    private Double ttb;          // TTB
    private Double tts;          // TTS
	private double cash_buy;
	private double cash_sell;
	private double deal_bas_r;
	private double base_r;
	
	public NoticeExchangeRateDto() {
		// TODO Auto-generated constructor stub
	}
	
	public NoticeExchangeRateDto(String c_code, LocalDate rate_date, String annoTime, Double ttb, Double tts,
			double cash_buy, double cash_sell, double deal_bas_r, double base_r) {
		super();
		this.c_code = c_code;
		this.rate_date = rate_date;
		this.annoTime = annoTime;
		this.ttb = ttb;
		this.tts = tts;
		this.cash_buy = cash_buy;
		this.cash_sell = cash_sell;
		this.deal_bas_r = deal_bas_r;
		this.base_r = base_r;
	}

	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public LocalDate getRate_date() {
		return rate_date;
	}
	public void setRate_date(LocalDate rate_date) {
		this.rate_date = rate_date;
	}
	public String getAnnoTime() {
		return annoTime;
	}
	public void setAnnoTime(String annoTime) {
		this.annoTime = annoTime;
	}
	public Double getTtb() {
		return ttb;
	}
	public void setTtb(Double ttb) {
		this.ttb = ttb;
	}
	public Double getTts() {
		return tts;
	}
	public void setTts(Double tts) {
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
