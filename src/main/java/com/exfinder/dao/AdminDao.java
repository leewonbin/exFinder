package com.exfinder.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.AuthoritiesDto;
import com.exfinder.dto.UserDto;

public interface AdminDao {
	public ArrayList<UserDto> selectAll() throws Exception;
	public ArrayList<AuthoritiesDto> selectAllAuthorities() throws Exception;
	public void updateAuthority(AuthoritiesDto authoritiesDto)  throws Exception;
	public void updateStatus(Map<String, Object> params) throws Exception;
	public void updateUser(UserDto userDto) throws Exception;
	public void updateBoardStatus(@Param("b_id") int b_id, @Param("b_del") String b_del)throws Exception;
	public void deleteBoardAdmin(int b_id)throws Exception;
	

	
	
}
