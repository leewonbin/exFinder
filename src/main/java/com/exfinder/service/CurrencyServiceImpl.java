package com.exfinder.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.CurrencyDao;
import com.exfinder.dto.CurrencyDto;

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
}
