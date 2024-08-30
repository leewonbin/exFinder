package com.exfinder.dao;

import java.util.ArrayList;

import com.exfinder.dto.ExchangeRateDto;

public interface ExchangeRateDao {
	public ArrayList<ExchangeRateDto> exchangeRateSelect(String currency,String start_date,String end_date) throws Exception;
	public int exchangeRateInsert(ExchangeRateDto dto) throws Exception;
}
