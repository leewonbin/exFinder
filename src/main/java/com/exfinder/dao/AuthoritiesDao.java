package com.exfinder.dao;

import com.exfinder.dto.AuthoritiesDto;

public interface AuthoritiesDao {
	public void insert(AuthoritiesDto dto) throws Exception;

	public void update(String uId, String authority) throws Exception;
	
}



