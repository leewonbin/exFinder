package com.exfinder.service;

import java.util.ArrayList;

import com.exfinder.dto.UserDto;

public interface UserService {
	public ArrayList<UserDto> getUserList();
	public int insertUser(UserDto dto);
	public int updateUser(UserDto dto);
	public int deleteUser(String u_id);
}
