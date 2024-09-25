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
import com.exfinder.dto.NoticeExchangeRateDto;
import com.exfinder.service.ExchangeRateService;
import com.exfinder.service.NoticeExchangeRateService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class ExChangeController {
	
	@Autowired
	private ExchangeRateService service;
	
	@Autowired
	private NoticeExchangeRateService n_service;
	
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
			String[] curr = service.currSelect();
	        ArrayList<ExchangeRateDto> list = service.checkExchange(curr, oldDate, nowDate);
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
	
	@ResponseBody
	@RequestMapping(value = "charts/value", method = RequestMethod.POST)
	public void charts_value(HttpServletResponse response, @RequestParam("c_code") String  c_code, @RequestParam("rate_date") String rate_date) throws Exception {
	    int checkValue = service.exchangeRate_column_checkValue(c_code);
	    if (checkValue == 0) {
	        // 값이 0인 경우, 즉시 종료
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        System.out.println("해당 통화 코드"+ c_code + " 에 대한 데이터가 없으니 중지합니다.");
	        return;
	    }
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		LocalDate currentDate = LocalDate.parse(rate_date, formatter);
		
		double today_base_r = 0;
		
		while (today_base_r == 0) { // 0을 null에 해당하는 값으로 가정
			today_base_r = service.exchangeRateSelect_base_r(c_code, currentDate.format(formatter));
            // System.out.println(c_code + "- today_base_r : " +  today_base_r);
            
            if (today_base_r == 0) {
                currentDate = currentDate.minusDays(1); // 날짜에서 1일을 뺌
            }
        }
		//System.out.println("-" + c_code + " 최신 날짜: " + currentDate.format(formatter) + ", 기준 환율: " + today_base_r);
		
		currentDate = currentDate.minusDays(1); // 미리 1일을 뺀다.
        
        double yesterday_base_r = 0;

        // null이 아닐 때까지 반복
        while (yesterday_base_r == 0) { // 0을 null에 해당하는 값으로 가정
            yesterday_base_r = service.exchangeRateSelect_base_r(c_code, currentDate.format(formatter));
            // System.out.println(c_code + "- yesterday_base_r : " + yesterday_base_r);
            
            if (yesterday_base_r == 0) {
                currentDate = currentDate.minusDays(1); // 날짜에서 1일을 뺌
            }
        }

		//System.out.println("-" + c_code + " 최종 날짜: " + currentDate.format(formatter) + ", 기준 환율: " + yesterday_base_r);
		
		// 두 값 중 큰 값을 선택
		double largerValue = Math.max(today_base_r, yesterday_base_r);
		double smallerValue = Math.min(today_base_r, yesterday_base_r);

		// 큰 값에서 작은 값을 빼기
		double difference = largerValue - smallerValue;
		//System.out.println("--" + c_code + " 두 값의 차이 : " + String.format("%.2f", difference));
		
		double percent = 0;
		if (yesterday_base_r != 0) {
		    if (difference < 0) { // 감소한 경우
		        percent = ((yesterday_base_r - today_base_r) / yesterday_base_r) * 100;
		        //System.out.println("---" + c_code + " 전날 대비 감소율 : " + String.format("%.2f", percent) + "%");
		    } else { // 증가한 경우
		        percent = ((today_base_r - yesterday_base_r) / yesterday_base_r) * 100;
		        //System.out.println("---" + c_code + " 전날 대비 증가율 : " + String.format("%.2f", percent) + "%");
		    }
		} else {
			percent = 0;
		    //System.out.println("---" + c_code + " 증가하지도 감소하지도 않았습니다.");
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
	public void charts_graph(HttpServletResponse response, @RequestParam("c_codes") List<String> c_codes, @RequestParam("rate_date") String rate_date) throws Exception {
		// HttpServletResponse response, @RequestParam("c_code") String  c_code, @RequestParam("start_date") String start_date, @RequestParam("end_date") String end_date
	    Gson gson = new Gson();
	    JsonArray jsonArray = new JsonArray();

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	    
	    for (String c_code : c_codes) {
		    int checkValue = service.exchangeRate_column_checkValue(c_code);
		    if (checkValue == 0) {
		        // 값이 0인 경우, 즉시 종료
		        response.setContentType("application/json");
		        response.setCharacterEncoding("UTF-8");
		        System.out.println("해당 통화 코드"+ c_code + " 에 대한 데이터가 없으니 중지합니다.");
		        continue; // 데이터가 없는 경우에도 다음 통화 코드를 처리
		    }
		    
		    // 날짜 포맷 설정    
		    LocalDate date = LocalDate.parse(rate_date, formatter); // 문자열을 LocalDate로 변환
		    ArrayList<NoticeExchangeRateDto> dto = null;

		    // 하루씩 빼면서 데이터 조회
		    while (dto == null || dto.isEmpty()) {
		        dto = n_service.charts_selectList(c_code, date.format(formatter)); // 데이터 조회
		        if (dto == null || dto.isEmpty()) {
		            date = date.minusDays(1); // 하루 빼기
		        }
		    }
		    
	        // 차트 데이터가 있으면 JSON 형식으로 변환
	        if (dto != null && !dto.isEmpty()) {
	            JsonObject jsonObject = new JsonObject();
	            jsonObject.addProperty("c_code", c_code); // 통화 코드 추가

	            JsonArray dataArray = new JsonArray(); // 차트 데이터 배열

	            // dto에 있는 데이터를 차트에 맞게 변환
	            for (NoticeExchangeRateDto item : dto) {
	                JsonObject dataObject = new JsonObject();
	                
	                // 시간 및 값을 JSON으로 변환하여 추가
	                dataObject.addProperty("annoTime", item.getAnnoTime());
	                dataObject.addProperty("deal_bas_r", item.getDeal_bas_r());

	                dataArray.add(dataObject);
	            }

	            // 차트 데이터를 JSON에 추가
	            jsonObject.add("data", dataArray);
	            jsonArray.add(jsonObject); // 최종적으로 jsonArray에 추가
	        }
	    }

	    //응답으로 JSON 배열 전송
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(gson.toJson(jsonArray));
	}
	
	@ResponseBody
	@RequestMapping(value = "currency/chart", method = RequestMethod.POST)
	public void Currency_chart_graph(HttpServletResponse response, @RequestParam("c_code") String  c_code, 
			@RequestParam("start_date") String start_date, @RequestParam("end_date") String end_date, 
			@RequestParam("cart_day") String  cart_day) throws Exception {
	
	    int checkValue = service.exchangeRate_column_checkValue(c_code);
	    if (checkValue == 0) {
	        // 값이 0인 경우, 즉시 종료
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        System.out.println("해당 통화 코드"+ c_code + " 에 대한 데이터가 없으니 중지합니다.");
	        return;
	    }

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	    LocalDate endDate = LocalDate.parse(end_date, formatter);

	    double today_base_r = 0;
	    LocalDate validDate = endDate;

	    while (today_base_r == 0) {
	        today_base_r = service.exchangeRateSelect_base_r(c_code, validDate.format(formatter));
	        if (today_base_r == 0) {
	            validDate = validDate.minusDays(1); // 종료 날짜에서 1일을 뺌
	        }
	    }
	    
	    LocalDate startDate = null;

	    // 'cart_day' 파라미터에 따라 기간을 설정
	    switch (cart_day) {
	        case "seven-day":
	            startDate = validDate.minusDays(6); // 7일 전 날짜
	            //System.out.println("seven-day의 시작 날짜 : "+ startDate);
	            break;
	        case "one-month":
	            startDate = validDate.minusMonths(1); // 1개월 전 날짜
	            //System.out.println("one-month의 시작 날짜  : "+ startDate);
	            break;
	        case "three-month":
	            startDate = validDate.minusMonths(3); // 3개월 전 날짜
	            //System.out.println("three-month의 시작 날짜  : "+ startDate);
	            break;
	        case "one-year":
	            startDate = LocalDate.of(validDate.getYear(), 1, 1); // 올해 1월 1일
	            //System.out.println("one-year의 시작 날짜  : "+ startDate);
	            break;
	        default:
	            // 기본값 설정
	            startDate = LocalDate.now().minusMonths(1); // 기본적으로 1개월 전
	            break;
	    }
	    //System.out.println(cart_day + "의 종료 날짜 : "+ validDate);
	    // 날짜 포맷 조정
	    String adjusted_StartDate = startDate.format(formatter);
	    String adjusted_EndDate = validDate.format(formatter);
	    
	    
	    List<ExchangeRateDto> dto = service.exchangeRateSelect(c_code, adjusted_StartDate, adjusted_EndDate);
	    
	    Gson gson = new Gson();
	    String json = gson.toJson(dto);
	    
	    response.setContentType("application/json");
	    response.setCharacterEncoding("utf-8");
	    try {
	        response.getWriter().print(json);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}

}
