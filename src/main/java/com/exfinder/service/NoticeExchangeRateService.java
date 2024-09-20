package com.exfinder.service;

import java.util.ArrayList;
import java.util.Map;


import com.exfinder.dto.NoticeExchangeRateDto;

public interface NoticeExchangeRateService {
	
	public ArrayList<NoticeExchangeRateDto> selectList() throws Exception;
	public ArrayList<NoticeExchangeRateDto> check(String[] curency) throws Exception;
	public int insert(NoticeExchangeRateDto dto) throws Exception;
	public ArrayList<NoticeExchangeRateDto> nowSelect() throws Exception;
	public ArrayList<Map<String, Object>> getBaseRDifference() throws Exception; // 추가

	
	public ArrayList<NoticeExchangeRateDto> charts_selectList(String  c_code, String rate_date) throws Exception;
}
