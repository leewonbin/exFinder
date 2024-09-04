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
	
	@RequestMapping(value = "charts", method = RequestMethod.GET)
	public void charts() throws Exception {
		
	}
	
	@ResponseBody
	@RequestMapping(value = "charts/graph", method = RequestMethod.POST)
	public void charts_graph(HttpServletResponse response, Model model, @RequestParam("c_code") String  c_code, @RequestParam("start_date") String start_date, @RequestParam("end_date") String end_date) throws Exception {
		// ((ExchangeRateDto) dto).setC_code("USD");
		// , @RequestParam String  c_code, @RequestParam String start_date, @RequestParam String end_date
		//String c_code = "USD";
		//String start_date = "2024/01/01";
		//String end_date = "2024/08/31";
		List<ExchangeRateDto> dto = service.exchangeRateSelect(c_code, start_date, end_date);
		
		System.out.println(dto);
		model.addAttribute("ExchangeRateDto_list", dto);
		
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
