package com.exfinder.service;

import java.util.List;

import com.exfinder.dto.CurrencyDto;

public interface CurrencyService {
	
	public CurrencyDto read(String c_code, String rate_date) throws Exception;
	public List<CurrencyDto> selectExchange() throws Exception;

	public CurrencyDto currency_Select(String c_code) throws Exception;
}
