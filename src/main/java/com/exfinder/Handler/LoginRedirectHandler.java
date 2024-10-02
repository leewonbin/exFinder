package com.exfinder.Handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class LoginRedirectHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String user_id = getUsername(authentication);
		//System.out.println("Logged in user ID: " + user_id);

		// HttpSession 객체 가져오기
		HttpSession session = request.getSession();

	    // 아이디 저장 체크박스 값 확인
	    String idSave = request.getParameter("id_save");
	    if (idSave != null && idSave.equals("id_save")) {
	        // 아이디 저장이 선택된 경우 쿠키에 아이디 저장
	        Cookie idSaveCookie = new Cookie("id_save", user_id);
	        idSaveCookie.setMaxAge(60 * 60 * 24 * 30); // 30일 동안 쿠키 유지
	        idSaveCookie.setPath("/"); // 애플리케이션 전체에서 쿠키 사용 가능
	        response.addCookie(idSaveCookie); // 쿠키 추가

	        // 아이디 저장 체크 상태 쿠키 설정
	        Cookie idSaveChecked = new Cookie("id_save_Checked", "checked");
	        idSaveChecked.setMaxAge(60 * 60 * 24 * 30); // 30일 동안 쿠키 유지
	        idSaveChecked.setPath("/");
	        response.addCookie(idSaveChecked); // 쿠키 추가
	    } else {
	        // 아이디 저장이 선택되지 않았을 경우 쿠키 삭제
	        Cookie idSaveCookie = new Cookie("id_save", null);
	        idSaveCookie.setMaxAge(0); // 쿠키 삭제
	        idSaveCookie.setPath("/");
	        response.addCookie(idSaveCookie); // 쿠키 추가

	        // 아이디 저장 체크 상태 쿠키 삭제
	        Cookie idSaveChecked = new Cookie("id_save_Checked", null);
	        idSaveChecked.setMaxAge(0); // 쿠키 삭제
	        idSaveChecked.setPath("/");
	        response.addCookie(idSaveChecked); // 쿠키 추가
	    }

	    // 자동 로그인 체크박스 값 확인
	    String autoLogin = request.getParameter("auto_login");
	    if (autoLogin != null && autoLogin.equals("auto_login")) {
	        // 자동 로그인이 선택된 경우 쿠키에 아이디 저장
	        Cookie autoLoginCookie = new Cookie("auto_login", user_id);
	        autoLoginCookie.setMaxAge(60 * 60 * 24 * 30); // 30일 동안 쿠키 유지
	        autoLoginCookie.setPath("/");
	        response.addCookie(autoLoginCookie); // 쿠키 추가

	        // 자동 로그인 체크 상태 쿠키 설정
	        Cookie autoLoginChecked = new Cookie("auto_login_Checked", "checked");
	        autoLoginChecked.setMaxAge(60 * 60 * 24 * 30);
	        autoLoginChecked.setPath("/");
	        response.addCookie(autoLoginChecked); // 쿠키 추가
	    } else {
	        // 자동 로그인이 선택되지 않았을 경우 쿠키 삭제
	        Cookie autoLoginCookie = new Cookie("auto_login", null);
	        autoLoginCookie.setMaxAge(0); // 쿠키 삭제
	        autoLoginCookie.setPath("/");
	        response.addCookie(autoLoginCookie); // 쿠키 추가

	        // 자동 로그인 체크 상태 쿠키 삭제
	        Cookie autoLoginChecked = new Cookie("auto_login_Checked", null);
	        autoLoginChecked.setMaxAge(0); // 쿠키 삭제
	        autoLoginChecked.setPath("/");
	        response.addCookie(autoLoginChecked); // 쿠키 추가
	    }
	    

		final List<String> roleNames = new ArrayList<String>();
		authentication.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
			//System.out.println("==role.authority==" + authority.getAuthority());
		});

		
		if (roleNames.contains("ROLE_ADMIN")) {
			session.setAttribute("userId", user_id);
			session.setAttribute("action", "login");
			response.sendRedirect("/ex/admin/admin");
			return;
		}
		if (roleNames.contains("ROLE_MEMBER")) {
			session.setAttribute("userId", user_id);
			session.setAttribute("action", "login");
			response.sendRedirect("/ex/user/Logincomplete");
			return;
		}

	}

	private String getUsername(Authentication authentication) {
		if (authentication.getPrincipal() instanceof UserDetails) {
			return ((UserDetails) authentication.getPrincipal()).getUsername();
		} else {
			return authentication.getPrincipal().toString();
		}
	}
}
