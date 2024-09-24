package com.exfinder.service;

import java.util.ArrayList;

import com.exfinder.dto.AlramDto;
import com.exfinder.dto.NotificationDto;

public interface AlramService {
	public ArrayList<AlramDto> alramSelect() throws Exception;
	public int alramInsert(NotificationDto dto) throws Exception;
	public int alramCheck(int a_id) throws Exception;
}
