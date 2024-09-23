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

import com.exfinder.service.NotificationService;

@Component
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
	
	@Autowired
	private NotificationService service;
	
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	//클라이언트가 웹 소켓 생성 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String userid= (String) session.getAttributes().get("userId");
		System.out.println("socket 연결"+userid);
		sessions.add(session);
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
	
	public void sendMessageToUser(String userId, TextMessage message) throws Exception {
	    for (WebSocketSession session : sessions) {
	        String sessionUserId = (String) session.getAttributes().get("userId");
	        if (userId.equals(sessionUserId)) {
	            session.sendMessage(message);
	        }
	    }
	}
}
