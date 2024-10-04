package com.exfinder.service;

import java.util.ArrayList;

import com.exfinder.dto.NotificationDto;

public interface NotificationService {
	public ArrayList<NotificationDto> alramCheck(String u_id) throws Exception;
	public int notificationInsert(NotificationDto dto) throws Exception;
	public ArrayList<NotificationDto> exchangeEqulasCheck() throws Exception;

}
