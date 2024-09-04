package com.exfinder.dao;

import java.util.ArrayList;
import java.util.Map;

import com.exfinder.dto.AuthoritiesDto;
import com.exfinder.dto.UserDto;

public interface AdminDao {
	public ArrayList<UserDto> selectAll() throws Exception;
	public ArrayList<AuthoritiesDto> selectAllAuthorities() throws Exception;
	public void updateAuthority(AuthoritiesDto authoritiesDto)  throws Exception;
	public void updateStatus(Map<String, Object> params) throws Exception;
	

	
	
}
