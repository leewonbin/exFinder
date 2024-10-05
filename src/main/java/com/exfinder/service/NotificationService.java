package com.exfinder.service;

import java.util.ArrayList;
import java.util.List;

import com.exfinder.dto.NotificationDto;

public interface NotificationService {
	public ArrayList<NotificationDto> alramCheck(String u_id) throws Exception;
	public int notificationInsert(NotificationDto dto) throws Exception;
	public ArrayList<NotificationDto> exchangeEqulasCheck() throws Exception;
	public List<NotificationDto> getNotificationLists(String userId) throws Exception;
	public int deleteNotification(int n_id)throws Exception;
	public void updateNotification(NotificationDto notificationDto) throws Exception;
	
}
