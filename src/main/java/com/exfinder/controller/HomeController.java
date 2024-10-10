package com.exfinder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.CurrencyService;
import com.exfinder.service.NoticeExchangeRateService;
import com.exfinder.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CurrencyService service;
	
	@Autowired
	private NoticeExchangeRateService noticeExchangeRateService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request, HttpSession session) throws Exception {
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
	    
	    // 쿠키에서 저장된 아이디를 가져옴
	    String auto_login = null;
	    Cookie[] cookies = request.getCookies(); // 클라이언트의 쿠키를 가져옴

	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("auto_login")) {
	            	auto_login = cookie.getValue(); // 저장된 오토 로그인의 아이디를 가져옴        
	            	
	            }
	        }
	    }
	    // 쿠키에 저장된 오토 아이디가 있을 경우 세션에 저장
	    if (auto_login != null) {
	    	session.setAttribute("dto", userService.selectUser(auto_login));
			UserDto dto = (UserDto)session.getAttribute("dto");	    	
	    }
	    

	    return "main/exFinder_main";
	}
}
