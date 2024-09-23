package com.exfinder.scheduler;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.dto.NoticeExchangeRateDto;
import com.exfinder.dto.NotificationDto;
import com.exfinder.service.ExchangeRateService;
import com.exfinder.service.NoticeExchangeRateService;
import com.exfinder.service.NotificationService;

@EnableScheduling
@Component
public class Scheduler {

	@Autowired
	private ExchangeRateService e_service;
	
	@Autowired
	private NoticeExchangeRateService n_service;
	
	@Autowired
	private NotificationService no_service;

//	@Scheduled(cron = "0 * * * * ?")
	@Scheduled(cron = "0 0 9-23 * * ?")
	public void hourScheduled() throws Exception {
		try {
			String[] curr = e_service.currSelect();
			ArrayList<NoticeExchangeRateDto> list = n_service.check(curr);
			for(NoticeExchangeRateDto dto : list) {
				n_service.insert(dto);
			}
		} catch (Exception e) {
			e.printStackTrace(); // 예외 출력
		}
		addAlram();
		
	}
	
	@Scheduled(cron = "0 0 0 * * ?")
	public void midnightScheduled() throws Exception {
		String[] curr = e_service.currSelect();
		ArrayList<ExchangeRateDto> list = e_service.yesterDayRate(curr);
		for(ExchangeRateDto dto : list) {
			e_service.exchangeRateInsert(dto);
		}
	}
	
	public void addAlram() {
		try {
			ArrayList<NotificationDto> list = no_service.exchangeEqulasCheck();
			if(list.size() != 0) {
				for(NotificationDto dto : list) {
					
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
