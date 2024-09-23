package com.exfinder.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.exfinder.dto.NotificationDto;

public interface NotificationDao {
	public ArrayList<NotificationDto> alramCheck(@Param("u_id")String u_id) throws Exception;
	public int alramInsert(NotificationDto dto) throws Exception;
	// 알림에 들어가야 할 요소 체크
	public ArrayList<NotificationDto> exchangeEqulasCheck() throws Exception;

}
