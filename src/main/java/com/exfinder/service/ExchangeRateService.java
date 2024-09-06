package com.exfinder.service;

import java.util.ArrayList;

import com.exfinder.dto.ExchangeRateDto;

public interface ExchangeRateService {
	public ArrayList<ExchangeRateDto> exchangeRateSelect(String c_code,String start_date,String end_date) throws Exception;
	public int exchangeRateInsert(ExchangeRateDto dto) throws Exception;
	public ArrayList<ExchangeRateDto> checkExchange(String[] curreny,String startDate,String endDate) throws Exception;
	public double exchangeRateSelect_base_r(String c_code, String rate_date);
	public String[] currSelect() throws Exception;
	public ArrayList<ExchangeRateDto> todaySelect(String today) throws Exception;
	
}
