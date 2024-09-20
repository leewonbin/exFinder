package com.exfinder.dto;

import java.time.LocalDate;

public class CurrencyDto {

	private LocalDate rate_date; // 날짜
	private String annotime;	// 시간
	private String c_code; // 통화 코드
	private String c_name; // 통화 이름
	private String c_country; // 국가명
	private double ttb; // 송금 보낼 때
	private double tts; // 송금 받을 때
	private double cash_buy; // 현찰 살 때
	private double cash_sell; // 현찰 팔 때
	private double deal_bas_r; // 매매 기준율
	private double base_r; // 기준 환율

	public CurrencyDto() {
	}
	
	public CurrencyDto(LocalDate rate_date, String annotime, String c_code, String c_name, String c_country, double ttb,
			double tts, double cash_buy, double cash_sell, double deal_bas_r, double base_r) {
		super();
		this.rate_date = rate_date;
		this.annotime = annotime;
		this.c_code = c_code;
		this.c_name = c_name;
		this.c_country = c_country;
		this.ttb = ttb;
		this.tts = tts;
		this.cash_buy = cash_buy;
		this.cash_sell = cash_sell;
		this.deal_bas_r = deal_bas_r;
		this.base_r = base_r;
	}

	public String getAnnotime() {
		return annotime;
	}

	public void setAnnotime(String annotime) {
		this.annotime = annotime;
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

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public String getC_country() {
		return c_country;
	}

	public void setC_country(String c_country) {
		this.c_country = c_country;
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

	@Override
	public String toString() {
		return "CurrencyDto [rate_date=" + rate_date + ", c_code=" + c_code + ", c_name=" + c_name + ", c_country="
				+ c_country + ", ttb=" + ttb + ", tts=" + tts + ", cash_buy=" + cash_buy + ", cash_sell=" + cash_sell
				+ ", deal_bas_r=" + deal_bas_r + ", base_r=" + base_r + "]";
	}
}