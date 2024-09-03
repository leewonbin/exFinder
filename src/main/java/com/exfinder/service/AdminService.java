package com.exfinder.service;

import java.util.ArrayList;
import java.util.List;

import com.exfinder.dto.UserDto;

public interface AdminService {
	
	public ArrayList<UserDto> selectAll() throws Exception;

	public void updateAuthority(String uId, String authority) throws Exception;
	
	
	
	
}
