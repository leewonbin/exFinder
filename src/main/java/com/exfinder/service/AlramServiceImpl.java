package com.exfinder.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.AlramDao;
import com.exfinder.dto.NotificationDto;

@Service
public class AlramServiceImpl implements AlramService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int alramInsert(NotificationDto dto) throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.alramInsert(dto);
	}

}
