package com.exfinder.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.CurrencyInfoDto;
import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.dto.NoticeExchangeRateDto;

public interface CurrencyService {
	
	public CurrencyDto read(String c_code, String rate_date) throws Exception;
	public List<CurrencyDto> selectExchange() throws Exception;

	public CurrencyDto currency_Select(String c_code) throws Exception;

	public boolean interestCheck(String c_code, String userid) throws Exception;
	public int deleteInsert(String u_id, String c_code) throws Exception;
	public int interestInsert(String u_id, String c_code) throws Exception;
	
	public List<ExchangeRateDto> dailyCurrency(@Param("c_code")String c_code) throws Exception;
	public List<NoticeExchangeRateDto> hourCurrency(@Param("c_code")String c_code) throws Exception;

	public List<CurrencyDto> getFavoriteCurrencies(String userId) throws Exception;
	public List<CurrencyInfoDto> currencyInfoSelect() throws Exception;
	public void deleteSelectedBookmarks(List<String> c_code)throws Exception;
	
}










