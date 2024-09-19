package com.exfinder.scheduler;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.exfinder.service.ExchangeRateService;

@Component
public class Scheduler {

	@Autowired
	private ExchangeRateService service;

	@Scheduled(cron = "0 10 0 * * ?")
	public void schedul() throws Exception {
		try {
			System.out.println("Scheduler triggered at: " + LocalDateTime.now());
			String[] curr = service.currSelect();
			service.todayExchangeRate(curr);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 출력
		}
	}
}
