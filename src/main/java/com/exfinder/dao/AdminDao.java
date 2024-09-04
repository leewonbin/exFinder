package com.exfinder.dao;

import java.util.ArrayList;
import java.util.List;

import com.exfinder.dto.UserDto;

public interface AdminDao {
	public ArrayList<UserDto> selectAll() throws Exception;
	
	
	
}
