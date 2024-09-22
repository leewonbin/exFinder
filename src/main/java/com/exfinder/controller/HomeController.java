package com.exfinder.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.CurrencyService;
import com.exfinder.service.ExchangeRateService;
import com.exfinder.service.NoticeExchangeRateService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private CurrencyService service;
	
	@Autowired
	private NoticeExchangeRateService noticeExchangeRateService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
	    List<CurrencyDto> list = new ArrayList<>();
	    try {
	        // 통화 목록을 가져옴
	        list = service.selectExchange();
	        
	        // 환율 차이 가져오기
	        ArrayList<Map<String, Object>> differences = noticeExchangeRateService.getBaseRDifference();
	        Map<String, Double> resultMap = new HashMap<>();
	        String currentCCode = null;
	        for (Map<String, Object> result : differences) {
	        	  if (result.containsKey("C_CODE")) {
	                  currentCCode = (String) result.get("C_CODE");
	              }

	              if (result.containsKey("BASERDIFFERENCE") && currentCCode != null) {
	                  Double baseRDifference = ((Number) result.get("BASERDIFFERENCE")).doubleValue();
	                  resultMap.put(currentCCode, baseRDifference);
	              }
	        }
	        
	        // 모델에 데이터 추가
	        model.addAttribute("list", list);
	        model.addAttribute("resultMap", resultMap);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return "main/exFinder_main";
	}
	
	// 접근 방식 : exFinder_Currency?c_code=USD

}
