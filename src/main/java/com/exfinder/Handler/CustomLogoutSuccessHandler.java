package com.exfinder.Handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) 
            throws IOException, ServletException {
        // 로그아웃 성공 시 특정 쿠키 초기화
        Cookie cookie = new Cookie("auto_login", null);
        cookie.setPath("/");  // 쿠키의 경로 설정
        cookie.setMaxAge(0);  // 쿠키의 만료 시간을 0으로 설정 (즉시 삭제)
        response.addCookie(cookie);
        
        // 추가로 초기화할 쿠키
        Cookie autoLoginCookie = new Cookie("auto_login_Checked", null);
        autoLoginCookie.setPath("/");
        autoLoginCookie.setMaxAge(0);
        response.addCookie(autoLoginCookie);

        response.sendRedirect(request.getContextPath() + "/user/login?logout=true"); 
    }

}
