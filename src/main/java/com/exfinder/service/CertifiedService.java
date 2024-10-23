package com.exfinder.service;

import java.util.HashMap;

import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.exfinder.dto.AlramDto;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class CertifiedService {
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private UserService service;

	public void certifiedEmail(String Email, String numStr) {
		// 이메일 보낼 양식
		String setFrom = "zzx5678@naver.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = Email;
		String title = "[ExFinder]의 회원가입 인증 이메일 입니다.";
		String content = "인증 코드는 " + numStr + " 입니다." + "<br>" + "해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void certifiedPhoneNumber(String phoneNumber, String numStr) {

        String api_key = "NCSX7YP20EJOYTZL";
        String api_secret = "LYHZFIJLRUUDIGFPGCXRGZK4EVDPOMW3";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", phoneNumber);    // 수신전화번호
        params.put("from", "01099427028");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "[ExFinder]의 휴대폰 인증 메시지 : 인증번호는 " + "["+numStr+"]" + "입니다.");
        params.put("app_version", "test app 1.2"); // application name and version

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
    }
	
	public void sendPhoneAlram(AlramDto dto) throws Exception {
		String phoneNumber = service.getUserPhoneNumber(dto.getU_id());
        String api_key = "NCSDXWMQBQT55LZH";
        String api_secret = "PRZDVSVYDR6JJW7J90UKOCSKGLEFEWP7";
        Message coolsms = new Message(api_key, api_secret);
        String msg = "[ExFinder] %s 통화가 %.2f에 도달했습니다!\n" +
        		"설정 금액: %.2f\n" +
        		"범위: %.2f ~ %.2f";
        System.out.println("phoneNumber : " + phoneNumber);
        double minValue = dto.getTarget_exchange() * 0.998;
        double maxValue = dto.getTarget_exchange() * 1.002;
        msg = String.format(msg, dto.getC_code(),dto.getDeal_bas_r(),dto.getTarget_exchange(),minValue,maxValue);
        System.out.println("msg : " + msg);
        HashMap<String,String> params = new HashMap<String,String>();
        params.put("to", phoneNumber);
        params.put("from", "010-9031-8546");
        params.put("type", "SMS");
        params.put("text", msg);
        params.put("app_version", "test app 1.2");
        
        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
	}

}
