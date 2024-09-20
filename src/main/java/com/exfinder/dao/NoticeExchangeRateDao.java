package com.exfinder.dao;

import java.util.ArrayList;
import java.util.Map;

import com.exfinder.dto.NoticeExchangeRateDto;

public interface NoticeExchangeRateDao {
	public ArrayList<NoticeExchangeRateDto> selectList() throws Exception;
	public int insert(NoticeExchangeRateDto dto) throws Exception;
	public ArrayList<NoticeExchangeRateDto> nowSelect() throws Exception;
	public ArrayList<Map<String, Object>> getBaseRDifference() throws Exception; // 추가
}
