package com.exfinder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exfinder.scheduler.Scheduler;

@Controller
@RequestMapping("test")
public class TestController {
	
	@Autowired
	private Scheduler sche;
	
	@RequestMapping(value="/page",method=RequestMethod.GET)
	public String page() {
		return "/alramTest";
	}
	
    // AJAX 요청을 처리하는 메서드
    @GetMapping("/ajaxRequest")
    @ResponseBody
    public ResponseEntity<String> handleAjaxRequest() {
        sche.addAlram();
        String responseMessage = "AJAX 요청 처리 완료"; // 이 부분은 실제 반환할 내용을 설정
        return ResponseEntity.ok(responseMessage);
    }
	
	
		
	

}
