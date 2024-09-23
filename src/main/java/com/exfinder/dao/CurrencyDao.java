package com.exfinder.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.CurrencyDto;

public interface CurrencyDao {
	
	public CurrencyDto read(String c_code, String rate_date) throws Exception;
	public List<CurrencyDto> listAll() throws Exception;
	
	public CurrencyDto currency_Select(@Param("c_code")String c_code) throws Exception;
	public List<CurrencyDto> selectExchange() throws Exception;
	public boolean interestCheck(@Param("c_code") String c_code, @Param("userid") String userid) throws Exception;
	public int interestInsert(@Param("u_id") String u_id, @Param("c_code") String c_code);
	public int deleteInsert(@Param("u_id") String u_id, @Param("c_code") String c_code);
	public List<CurrencyDto> getFavoriteCurrencies(String userId) throws Exception;

}
