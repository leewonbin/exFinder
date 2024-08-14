package com.exfinder.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.UserDao;
import com.exfinder.dto.UserDto;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<UserDto> getUserList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserDto getUser(String u_id) {
		UserDao dao = sqlSession.getMapper(UserDao.class);
		return dao.getUser(u_id);
	}
	
	@Override
	public int insertUser(UserDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateUser(UserDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteUser(String u_id) {
		// TODO Auto-generated method stub
		return 0;
	}


}
