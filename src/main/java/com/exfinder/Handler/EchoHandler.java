package com.exfinder.Handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.exfinder.dto.AlramDto;
import com.exfinder.service.AlramService;
import com.exfinder.service.CertifiedService;
import com.exfinder.service.NotificationService;

@Component
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
	
	@Autowired
	private AlramService a_service;
	
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	//클라이언트가 웹 소켓 생성 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String userid= (String) session.getAttributes().get("userId");
		System.out.println("socket 연결"+userid);
		sessions.add(session);
		notifyClients();
	}
	
	// 메시지 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("socket 끊음");
		sessions.remove(session);
	}
	
	public void notifyClients() throws Exception {
	    ArrayList<AlramDto> alramList = a_service.alramSelect(); // 알람 목록을 가져옴
	    System.out.println("alramList.size() : " + alramList.size());

	    for (AlramDto alram : alramList) {
	        String userId = alram.getU_id();
	        System.out.println("userId : " + userId);
	        TextMessage textMessage = new TextMessage("새로운 알람이 있습니다: " + alram.getTarget_exchange());
	        System.out.println("sessions.size() : " + sessions.size());
	        for (WebSocketSession session : sessions) {
	            String sessionUserId = (String) session.getAttributes().get("userId");
	            System.out.println("sessionUserId : " + sessionUserId);
	            System.out.println("session.getId() :" + session.getId());
	            if (userId.equals(sessionUserId)) {
	                session.sendMessage(textMessage); // 해당 사용자에게만 메시지 전송
	            }
	        }
	    }
	}
	
}
