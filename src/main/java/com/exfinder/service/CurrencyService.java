package com.exfinder.service;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.CurrencyDto;

public interface CurrencyService {
	
	public CurrencyDto read(String c_code, String rate_date) throws Exception;
	public List<CurrencyDto> selectExchange() throws Exception;

	public CurrencyDto currency_Select(String c_code) throws Exception;
	
	public List<CurrencyDto> selectDailyExchangeRates(@Param("c_code") String c_code) throws Exception;
}










