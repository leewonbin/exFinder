package com.exfinder.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.service.ExchangeRateService;

@Controller
public class ExChangeController {
	
	@Autowired
	private ExchangeRateService service;
	
	@RequestMapping(value = "exchange/update", method = RequestMethod.GET)
	public String updatePage() throws Exception {
		return "/admin/exchangeUpdate";
	}
	
	@RequestMapping(value = "exchange/update", method = RequestMethod.POST)
	public ResponseEntity<String> updateExchange() {
		try {
			LocalDate today = LocalDate.now();
			LocalDate oneYearAgo = today.minusYears(1);
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			
			String nowDate = today.format(formatter);
			String oldDate = oneYearAgo.format(formatter);
	        ArrayList<ExchangeRateDto> list = service.checkExchange("USD", oldDate, nowDate);
	        list.addAll(service.checkExchange("JPY", oldDate, nowDate));
	        list.addAll(service.checkExchange("EUR", oldDate, nowDate));
	        list.addAll(service.checkExchange("CNY", oldDate, nowDate));
	        for(ExchangeRateDto dto : list) {
	        	service.exchangeRateInsert(dto);
	        }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<>("SUCCESS",HttpStatus.OK);
	}
	
	// 환율 차트 값 불러오기
	@RequestMapping(value = "exchange/chartInfo", method = RequestMethod.POST)
	public ResponseEntity<Map<String, ArrayList<ExchangeRateDto>>> chartInfo( @RequestParam String start_date,
	        @RequestParam String end_date,
	        @RequestParam String currency) {

	    Map<String, ArrayList<ExchangeRateDto>> groupList = new HashMap<>();
		try {
			ArrayList<ExchangeRateDto> list = service.exchangeRateSelect(currency, start_date, end_date);
			System.out.println(list.size());
			
			for (ExchangeRateDto dto : list) {
				System.out.println("ExchangeRateDto : " + dto.toString());
				String cCode = dto.getC_code();
				if (!groupList.containsKey(cCode)) {
					groupList.put(cCode, new ArrayList<>());
				}
				groupList.get(cCode).add(dto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    return ResponseEntity.ok(groupList);
	}
	
	// 지원 환율 조회
	
	

}
