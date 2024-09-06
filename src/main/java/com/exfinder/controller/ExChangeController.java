package com.exfinder.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.service.ExchangeRateService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

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
			String[] c_codeArr = service.currSelect();
	        ArrayList<ExchangeRateDto> list = service.checkExchange("USD", oldDate, nowDate);
	        for(String curr : c_codeArr) {
	        	list.addAll(service.checkExchange(curr, oldDate, nowDate));
	        }
	        System.out.println("환율 값 넣기 완료");
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
	
	@RequestMapping(value = "charts", method = RequestMethod.GET)
	public void charts(Model model) throws Exception {
		
	}
	
	@ResponseBody
	@RequestMapping(value = "charts/value", method = RequestMethod.POST)
	public void charts_value(HttpServletResponse response, @RequestParam("c_code") String  c_code, @RequestParam("rate_date") String rate_date) throws Exception {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		LocalDate currentDate = LocalDate.parse(rate_date, formatter);
		
		double today_base_r = 0;
		
		while (today_base_r == 0) { // 0을 null에 해당하는 값으로 가정
			today_base_r = service.exchangeRateSelect_base_r(c_code, currentDate.format(formatter));
            System.out.println(c_code + "- today_base_r : " +  today_base_r);
            
            if (today_base_r == 0) {
                currentDate = currentDate.minusDays(1); // 날짜에서 1일을 뺌
            }
        }
		System.out.println("-" + c_code + " 최신 날짜: " + currentDate.format(formatter) + ", 기준 환율: " + today_base_r);
		
		currentDate = currentDate.minusDays(1); // 미리 1일을 뺀다.
        
        double yesterday_base_r = 0;

        // null이 아닐 때까지 반복
        while (yesterday_base_r == 0) { // 0을 null에 해당하는 값으로 가정
            yesterday_base_r = service.exchangeRateSelect_base_r(c_code, currentDate.format(formatter));
            System.out.println(c_code + "- yesterday_base_r : " + yesterday_base_r);
            
            if (yesterday_base_r == 0) {
                currentDate = currentDate.minusDays(1); // 날짜에서 1일을 뺌
            }
        }

		System.out.println("-" + c_code + " 최종 날짜: " + currentDate.format(formatter) + ", 기준 환율: " + yesterday_base_r);
		//yesterday_base_r
		
		// 두 값 중 큰 값을 선택
		double largerValue = Math.max(today_base_r, yesterday_base_r);
		double smallerValue = Math.min(today_base_r, yesterday_base_r);

		// 큰 값에서 작은 값을 빼기
		double difference = largerValue - smallerValue;
		System.out.println("--" + c_code + " 두 값의 차이 : " + String.format("%.2f", difference));
		
		double percent = 0;
		if (yesterday_base_r != 0) {
		    if (difference < 0) { // 감소한 경우
		        percent = ((yesterday_base_r - today_base_r) / yesterday_base_r) * 100;
		        System.out.println("---" + c_code + " 전날 대비 감소율 : " + String.format("%.2f", percent) + "%");
		    } else { // 증가한 경우
		        percent = ((today_base_r - yesterday_base_r) / yesterday_base_r) * 100;
		        System.out.println("---" + c_code + " 전날 대비 증가율 : " + String.format("%.2f", percent) + "%");
		    }
		} else {
			percent = 0;
		    System.out.println("---" + c_code + " 증가하지도 감소하지도 않았습니다.");
		}
		
	    // Gson 객체 생성
	    Gson gson = new Gson();
	    
	    // JSON 객체 생성 및 데이터 추가
	    JsonObject jsonObject = new JsonObject();
	    jsonObject.addProperty("today_base_r", today_base_r);
	    jsonObject.addProperty("yesterday_base_r", yesterday_base_r);
	    jsonObject.addProperty("difference", difference);
	    jsonObject.addProperty("percent", percent);

	    // JSON 문자열로 변환
	    String json = gson.toJson(jsonObject);
	    
	    // 응답 설정
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	    
	}
	
	@ResponseBody
	@RequestMapping(value = "charts/graph", method = RequestMethod.POST)
	public void charts_graph(HttpServletResponse response, @RequestParam("c_code") String  c_code, @RequestParam("start_date") String start_date, @RequestParam("end_date") String end_date) throws Exception {
		// ((ExchangeRateDto) dto).setC_code("USD");
		// , @RequestParam String  c_code, @RequestParam String start_date, @RequestParam String end_date
		//String c_code = "USD";
		//String start_date = "2024/01/01";
		//String end_date = "2024/08/31";
		
		List<ExchangeRateDto> dto = service.exchangeRateSelect(c_code, start_date, end_date);
		
		// model.addAttribute("ExchangeRateDto_list", dto);
		
		Gson gson = new Gson();
		String json = "";
		json = gson.toJson(dto);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 지원 환율 조회
	

}
