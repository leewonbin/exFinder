package com.exfinder.dao;

import java.util.ArrayList;

import com.exfinder.dto.NoticeExchangeRateDto;

public interface NoticeExchangeRateDao {
	public ArrayList<NoticeExchangeRateDto> selectList() throws Exception;
	public int insert(NoticeExchangeRateDto dto) throws Exception;
}
