package com.exfinder.dao;

import java.util.List;

import com.exfinder.dto.CurrencyDto;

public interface CurrencyDao {
	
	public CurrencyDto read(String c_code, String rate_date) throws Exception;
	public List<CurrencyDto> selectExchange(String today) throws Exception;

}
