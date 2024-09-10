package com.exfinder.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.AdminDao;
import com.exfinder.dao.CsDao;
import com.exfinder.dto.CsDto;

@Service
public class CsServiceImpl implements CsService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void create(CsDto cs) throws Exception {
		CsDao dao = sqlSession.getMapper(CsDao.class);
		dao.create(cs);
	}
	
	@Override
	public CsDto read(int cs_id) throws Exception {
		CsDao dao = sqlSession.getMapper(CsDao.class);
		return dao.read(cs_id);
	}
	
	@Override
	public void update(CsDto cs) throws Exception {
		CsDao dao = sqlSession.getMapper(CsDao.class);
		dao.update(cs);
	}
	
	@Override
	public void delete(int cs_id) throws Exception {
		CsDao dao = sqlSession.getMapper(CsDao.class);
		dao.delete(cs_id);
	}
	
	@Override
	public List<CsDto> listAll() throws Exception {
		CsDao dao = sqlSession.getMapper(CsDao.class);
		List<CsDto> dtos = dao.listAll();
		return dtos;
	}
	@Override
	public List<CsDto> listActive() throws Exception {
		CsDao dao = sqlSession.getMapper(CsDao.class);
		List<CsDto> dtos = dao.listActive();
		return dtos;
	}
	

	@Override
	public void updateStatus(int cs_id, int cs_state) throws Exception {
		 CsDao dao = sqlSession.getMapper(CsDao.class);
		 Map<String, Object> params = new HashMap<>();
		 params.put("cs_id", cs_id);
		 params.put("cs_state", cs_state);
		 dao.updateStatus(params);
		
	}

	
	
	
	
	
	

}
