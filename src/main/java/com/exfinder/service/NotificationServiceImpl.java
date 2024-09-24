package com.exfinder.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.NotificationDao;
import com.exfinder.dto.NotificationDto;

@Service
public class NotificationServiceImpl implements NotificationService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<NotificationDto> alramCheck(String u_id) throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		return dao.alramCheck(u_id);
	}

	@Override
	public int alramInsert(NotificationDto dto) throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		return dao.alramInsert(dto);
	}

	@Override
	public ArrayList<NotificationDto> exchangeEqulasCheck() throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		return dao.exchangeEqulasCheck();
	}

}
