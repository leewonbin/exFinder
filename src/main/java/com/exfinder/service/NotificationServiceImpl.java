package com.exfinder.service;

import java.util.ArrayList;
import java.util.List;

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
	public int notificationInsert(NotificationDto dto) throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		return dao.notificationInsert(dto);
	}

	@Override
	public ArrayList<NotificationDto> exchangeEqulasCheck() throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		return dao.exchangeEqulasCheck();
	}

	@Override
	public List<NotificationDto> getNotificationLists(String userId) throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		return dao.getNotificationLists(userId);
	}

	@Override
    public int deleteNotification(int n_id) throws Exception {
        NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
        return dao.deleteNotification(n_id);
    }

	@Override
	public void updateNotification(NotificationDto notificationDto) throws Exception {
		NotificationDao dao = sqlSession.getMapper(NotificationDao.class);
		dao.updateNotification(notificationDto);
		
	}

	
		
}


