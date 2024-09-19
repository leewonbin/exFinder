package com.exfinder.service;

import java.util.ArrayList;

import com.exfinder.dto.NoticeExchangeRateDto;

public interface NoticeExchangeRateService {
	
	public ArrayList<NoticeExchangeRateDto> selectList() throws Exception;
	public ArrayList<NoticeExchangeRateDto> check(String[] curency) throws Exception;
	public int insert(NoticeExchangeRateDto dto) throws Exception;

}
