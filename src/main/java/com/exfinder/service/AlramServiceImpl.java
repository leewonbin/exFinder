package com.exfinder.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.AlramDao;
import com.exfinder.dto.AlramDto;
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

	@Override
	public ArrayList<AlramDto> alramSelect() throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.alramSelect();
	}

	@Override
	public int alramCheck(String u_id) throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.alramCheck(u_id);
	}

	@Override
	public int noCheckAlramDelete() throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.noCheckAlramDelete();
	}

	@Override
	public ArrayList<AlramDto> userAlramSelect(String u_id) throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.userAlramSelect(u_id);
	}

	@Override
	public int alramDelete(int a_id) throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.alramDelete(a_id);
	}

	@Override
	public int alramDeleteAll(String userid) throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.alramDeleteAll(userid);
	}

	@Override
	public int userAlramCheck(String userid) throws Exception {
		AlramDao dao = sqlSession.getMapper(AlramDao.class);
		return dao.userAlramCheck(userid);
	}

}
