package com.exfinder.dao;

import java.util.ArrayList;

import com.exfinder.dto.UserDto;

public interface UserDao {
	public ArrayList<UserDto> getUserList();
	public UserDto getUser(String u_id);
	public int insertUser(UserDto dto);
	public int updateUser(UserDto dto);
	public int deleteUser(String u_id);
}
