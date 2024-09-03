package com.exfinder.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.AdminDao;
import com.exfinder.dao.AuthoritiesDao;
import com.exfinder.dto.UserDto;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private SqlSession sqlSession;
	
	
	
	@Override
	public ArrayList<UserDto> selectAll() throws Exception {
		AdminDao dao=sqlSession.getMapper(AdminDao.class);
		System.out.println(dao.selectAll());
		return dao.selectAll();
	}

	@Override
    public void updateAuthority(String uId, String authority) throws Exception {
        AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
        dao.update(uId, authority); // 권한을 업데이트
    }

}
