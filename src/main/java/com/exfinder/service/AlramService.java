package com.exfinder.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.AlramDto;
import com.exfinder.dto.NotificationDto;

public interface AlramService {
	public ArrayList<AlramDto> alramSelect() throws Exception;
	public int alramInsert(NotificationDto dto) throws Exception;
	public int alramCheck(String u_id) throws Exception;
	public int noCheckAlramDelete() throws Exception;
	public ArrayList<AlramDto> userAlramSelect(@Param("u_id")String u_id) throws Exception;
	public int alramDelete(@Param("a_id")int a_id) throws Exception;
	public int alramDeleteAll(String userid) throws Exception;
	public int userAlramCheck(String userid) throws Exception;
}
