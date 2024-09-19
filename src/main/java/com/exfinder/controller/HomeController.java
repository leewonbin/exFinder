package com.exfinder.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.service.CurrencyService;
import com.exfinder.service.ExchangeRateService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private CurrencyService service;
	
	@Autowired
	private ExchangeRateService exchangerateservice;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
	    LocalDate localDate = LocalDate.now().plusDays(1);
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    List<CurrencyDto> list = new ArrayList<CurrencyDto>();
	    int maxDaysToCheck = 30; // 최대 확인할 날짜 수
	    int daysChecked = 0;

	    try {
	        int size = 0;
	        while (size == 0 && daysChecked < maxDaysToCheck) {
	            localDate = localDate.minusDays(1);
	            String today = localDate.format(formatter);

	            list = service.selectExchange(today);
	            size = list.size();
	            daysChecked++; // 체크한 날짜 수 증가
	            System.out.println("Checked date: " + today + ", size: " + size);
	        }

	        if (size == 0) {
	            System.out.println("No exchange data found in the last " + maxDaysToCheck + " days.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    model.addAttribute("list", list);
	    return "main/exFinder_main";
	}
	
	// 접근 방식 : exFinder_Currency?c_code=USD
	@RequestMapping(value = "/exFinder_Currency", method = RequestMethod.GET)
	public String exFinder_Currency(Model model, @RequestParam("c_code") String  c_code) throws Exception {
		CurrencyDto currency = new CurrencyDto();
		currency.setC_code(c_code);
		currency = service.currency_Select(c_code);
		System.out.println(currency);
		model.addAttribute("currencyDto", currency); 
		
		ExchangeRateDto exchangeRate = new ExchangeRateDto();
		exchangeRate.setC_code(c_code);
		
		LocalDate today = LocalDate.now();  // 오늘 날짜를 가져옴
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");

		// 오늘 날짜를 지정한 형식으로 포맷팅 (문자열로 변환)
		String currentDate = today.format(formatter);
		exchangeRate = exchangerateservice.exchangeRateSelect_today(c_code, currentDate);
		
	    // 환율이 null일 경우, 하루씩 빼가며 값을 찾음
	    while (exchangeRate == null) {
	        today = today.minusDays(1);  // 1일 빼기
	        currentDate = today.format(formatter);  // 새로운 날짜 포맷팅
	        exchangeRate = exchangerateservice.exchangeRateSelect_today(c_code, currentDate);
	    }
	    System.out.println(exchangeRate);
	    model.addAttribute("exchangeRateDto", exchangeRate);  // 조회된 환율 정보 추가
	    
		return "main/exFinder_Currency";
	}
}
