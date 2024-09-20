package com.exfinder.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;


import com.exfinder.dto.NoticeExchangeRateDto;

public interface NoticeExchangeRateDao {
	public ArrayList<NoticeExchangeRateDto> selectList() throws Exception;
	public int insert(NoticeExchangeRateDto dto) throws Exception;
	
	public ArrayList<NoticeExchangeRateDto> charts_selectList(@Param("c_code") String  c_code, @Param("rate_date") String rate_date) throws Exception;
}
