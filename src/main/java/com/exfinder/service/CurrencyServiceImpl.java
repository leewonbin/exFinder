package com.exfinder.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.CurrencyDao;
import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.dto.NoticeExchangeRateDto;

@Service
public class CurrencyServiceImpl implements CurrencyService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public CurrencyDto read(String c_code, String rate_date) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.read(c_code, rate_date);
	}
	
	@Override
	public List<CurrencyDto> selectExchange() throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.selectExchange();
	}

	@Override
	public CurrencyDto currency_Select(String c_code) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);		
		return dao.currency_Select(c_code);
	}

	@Override
	public boolean interestCheck(String c_code, String userid) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.interestCheck(c_code, userid);
	}

	@Override
	public int deleteInsert(String u_id, String c_code) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.deleteInsert(u_id,c_code);	
	}

	@Override
	public int interestInsert(String u_id, String c_code) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.interestInsert(u_id,c_code);
	}

	@Override
	public List<ExchangeRateDto> dailyCurrency(String c_code) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.dailyCurrency(c_code);
	}

	@Override
	public List<NoticeExchangeRateDto> hourCurrency(String c_code) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.hourCurrency(c_code);
	}
	
	public List<CurrencyDto> getFavoriteCurrencies(String userId) throws Exception {
		CurrencyDao dao = sqlSession.getMapper(CurrencyDao.class);
		return dao.getFavoriteCurrencies(userId);
	}

}
