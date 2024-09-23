package com.exfinder.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.CurrencyDto;

public interface CurrencyDao {
	
	public CurrencyDto read(String c_code, String rate_date) throws Exception;
	public List<CurrencyDto> listAll() throws Exception;
	
	public CurrencyDto currency_Select(@Param("c_code")String c_code) throws Exception;
	public List<CurrencyDto> selectExchange() throws Exception;
	
	public List<CurrencyDto> selectDailyExchangeRates(@Param("c_code") String c_code) throws Exception;
}
