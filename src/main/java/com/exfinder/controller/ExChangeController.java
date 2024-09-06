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
		
		
		double today_base_r = service.exchangeRateSelect_base_r(c_code, rate_date);
		System.out.println("최신값 : " + today_base_r);
		rate_date = "2024/03/25";
		double yesterday_base_r = service.exchangeRateSelect_base_r(c_code, rate_date);
		System.out.println("최신값-1 : " + yesterday_base_r);
		// model.addAttribute("ExchangeRateDto", dto);
		
		// 두 값 중 큰 값을 선택
		double largerValue = Math.max(today_base_r, yesterday_base_r);
		double smallerValue = Math.min(today_base_r, yesterday_base_r);

		// 큰 값에서 작은 값을 빼기
		double difference = largerValue - smallerValue;
		System.out.println("두 값의 차이 : " + String.format("%.2f", difference));
		
		double percent = 0;
		if (yesterday_base_r != 0) {
		    if (difference < 0) { // 감소한 경우
		        percent = ((yesterday_base_r - today_base_r) / yesterday_base_r) * 100;
		        System.out.println("전날 대비 감소율 : " + String.format("%.2f", percent) + "%");
		    } else { // 증가한 경우
		        percent = ((today_base_r - yesterday_base_r) / yesterday_base_r) * 100;
		        System.out.println("전날 대비 증가율 : " + String.format("%.2f", percent) + "%");
		    }
		} else {
			percent = 0;
		    System.out.println("증가하지도 감소하지도 않았습니다.");
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

// 브라질 관련 오류,
/*
 * java.lang.NumberFormatException: For input string: "-" 오류는 Double.parseDouble() 메서드를 사용할 때 발생하며, 
 * 문자열 "-"을 숫자로 변환할 수 없어서 발생한 문제입니다. 이 문제는 주로 입력 데이터에 숫자 대신 잘못된 값이 들어갔을 때 발생합니다.
 * 라는데 쳇gpt에게 물어본 대로 수정해서 해봤는데 안되어서. 원래대로 되돌렸어요..
 */
/*
 * java.lang.NumberFormatException: For input string: "-"
	at java.base/jdk.internal.math.FloatingDecimal.readJavaFormatString(FloatingDecimal.java:2054)
	at java.base/jdk.internal.math.FloatingDecimal.parseDouble(FloatingDecimal.java:110)
	at java.base/java.lang.Double.parseDouble(Double.java:543)
	at com.exfinder.service.ExchangeRateServiceImpl.checkExchange(ExchangeRateServiceImpl.java:123)
	at com.exfinder.controller.ExChangeController.updateExchange(ExChangeController.java:56)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:209)
	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:136)
	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:891)
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797)
	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:991)
	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:925)
	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:981)
	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:884)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:555)
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:858)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:623)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:199)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:144)
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:51)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:168)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:144)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)
	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)
	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)
	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)
	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)
	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)
	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)
	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:168)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:144)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:168)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:144)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:168)
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:90)
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:481)
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:130)
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:93)
	at org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:660)
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:346)
	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:388)
	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:63)
	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:936)
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1791)
	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:52)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1190)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:63)
	at java.base/java.lang.Thread.run(Thread.java:834)
 */
