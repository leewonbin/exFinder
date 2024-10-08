package com.exfinder.Handler;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        String errorMessage;

        // 예외의 종류에 따라 다르게 처리
        if (exception instanceof DisabledException) {
            // 사용자 계정이 비활성화 상태일 때
            errorMessage = "enabled";
        } else if (exception instanceof BadCredentialsException) {
            // 아이디 또는 비밀번호가 불일치할 때
            errorMessage = "error";
        } else {
            // 기타 다른 오류 처리
            errorMessage = "wrong";
        }
        
        String encodedMessage = URLEncoder.encode(errorMessage, StandardCharsets.UTF_8.toString());

        // 오류 메시지를 request에 저장
        response.sendRedirect(request.getContextPath() + "/user/login?msg="+encodedMessage); 

    }
}
