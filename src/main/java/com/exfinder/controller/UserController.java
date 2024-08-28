package com.exfinder.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exfinder.dto.AuthoritiesDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.AuthoritiesService;
import com.exfinder.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AuthoritiesService authoritiesService; 
	
	@Autowired
    PasswordEncoder bcryptPasswordEncoder;

	// 유저 로그인
	@RequestMapping(value = "/user/login", method = RequestMethod.GET)
	public String login(HttpSession session) throws Exception{
		
		String auto_login_Checked = (String) session.getAttribute("auto_login_Checked");
		
		if (auto_login_Checked != null && auto_login_Checked.equals("checked")) {
			System.out.println("자동 로그인이 체크되어있어서, 자동 로그인이 되었습니다.");
			return "/user/index";
		}
		return "/user/login";
	}
	
	@RequestMapping(value = "/user/index", method = RequestMethod.GET)
	public void index() throws Exception{
		
	}
	
	// 회원가입 이동
	@RequestMapping(value = "/user/join", method = RequestMethod.GET)
	public void join() throws Exception{
		
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/user/id_duplicate_check", method = RequestMethod.POST)
	public String id_duplicate_check(@RequestParam("u_id") String u_id) throws Exception {
		System.out.println("u_id" + u_id);
	    boolean isDuplicate = userService.selectUser(u_id) != null;
	    System.out.println(isDuplicate);
	    // boolean 값을 "true" 또는 "false" 문자열로 반환
	    return Boolean.toString(isDuplicate);
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/user/joinDB", method = RequestMethod.POST)
	public String joinDB(UserDto dto, HttpServletRequest request, Model model) throws Exception{
		System.out.println("User insertDB");
		
		String encPassword = bcryptPasswordEncoder.encode(dto.getU_pw());
		dto.setU_pw(encPassword);
		
		String u_email = request.getParameter("email") + "@" + request.getParameter("select");
    	System.out.println("u_email : " + u_email);
    	dto.setU_email(u_email);
    	
		String u_phoneNumber = request.getParameter("phoneNumber1") + "-" + request.getParameter("phoneNumber2") + "-" + request.getParameter("phoneNumber3");
        System.out.println("u_phoneNumber : " + u_phoneNumber);
        dto.setU_phoneNumber(u_phoneNumber);
        
		userService.insert(dto);
		System.out.println(dto);
		
		model.addAttribute("action", "join");
		
		AuthoritiesDto authDto = new AuthoritiesDto();
		String join_id = dto.getU_id();
		authDto.setU_id(join_id);
		
		// *
		if (join_id.equals("admin")) {
			authDto.setAuthority("ROLE_ADMIN");
			authoritiesService.insert(authDto);
		}else {
			authDto.setAuthority("ROLE_MEMBER");
			authoritiesService.insert(authDto);
		}
		
		System.out.println(authDto);
		
		return "/user/complete";
	}
	
	@RequestMapping(value = "/user/update_pw", method = RequestMethod.GET)
	public void update_pw() throws Exception{
	}
	
	// 마이 페이지 진입 전 비밀번호 체크 
	@RequestMapping(value = "/user/update_Check", method = RequestMethod.GET)
	public String update_Check(Model model, HttpServletRequest request, HttpSession session) throws Exception{
		String userId = (String) session.getAttribute("userId");
		System.out.println("userId : " + userId);
		
		// 데이터베이스에서 암호화된 비밀번호를 가져옴
	    String storedEncPassword = userService.getU_pwByU_id(userId);
	    System.out.println("storedEncPassword : " + storedEncPassword);
	    
	    String pw_Check = request.getParameter("pw_Check");
	    
	    // 비밀번호 비교
	    boolean Pw_Check = bcryptPasswordEncoder.matches(pw_Check, storedEncPassword);
		
		if (Pw_Check) {
			System.out.println("비밀번호가 일치합니다. 회원정보 수정 페이지로 이동합니다. ");
            
			return "redirect:/user/update";
	    } else {
	    	System.out.println("회원정보 확인에 실패했습니다. 비밀번호가 일치하지 않습니다. ");
	    	return "/user/update_pw";
	    }
	}
	
	// 유저 정보 수정 페이지 이동
	@RequestMapping(value = "/user/update", method = RequestMethod.GET)
	public void update(Model model, HttpSession session) throws Exception{
		String userId = (String) session.getAttribute("userId");
		
		UserDto dto = userService.selectUser(userId);
		model.addAttribute("UserDto",dto);
		System.out.println(dto);
			
		LocalDate u_birthday = dto.getU_birthday();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String u_birthdayStr = sdf.format(u_birthday);
	    String[] u_birthdayArr = u_birthdayStr.split("-");
	    model.addAttribute("u_birthdayArr", u_birthdayArr);
	        
	    String u_email = dto.getU_email();
        String[] u_emailArr = u_email.split("@");
        model.addAttribute("u_emailArr", u_emailArr);
            
        String u_phoneNumber = dto.getU_phoneNumber();
        String[] u_phoneNumberArr = u_phoneNumber.split("-");
        model.addAttribute("u_phoneNumberArr", u_phoneNumberArr);
        
	}
	
	// 유저 정보 수정 처리
	@RequestMapping(value = "/user/updateDB", method = RequestMethod.POST)
	public String updateDB(UserDto dto, HttpServletRequest request, HttpSession session) throws Exception{
		System.out.println("User updateDB");
		
		String encPassword = bcryptPasswordEncoder.encode(dto.getU_pw());
		dto.setU_pw(encPassword);
		
		// 요청 파라미터를 가져와서 LocalDate로 변환
		int year = Integer.parseInt(request.getParameter("year"));
		int month = Integer.parseInt(request.getParameter("month"));
		int day = Integer.parseInt(request.getParameter("day"));

		// LocalDate를 java.util.Date로 변환
		LocalDate u_birthday = LocalDate.of(year, month, day);
			
		dto.setU_birthday(u_birthday);
		System.out.println("u_birthday : " + u_birthday);
			
		String u_email = request.getParameter("email") + "@" + request.getParameter("select");
	    System.out.println("u_email : " + u_email);
	    dto.setU_email(u_email);
	    	
		String u_phoneNumber = request.getParameter("phoneNumber1") + "-" + request.getParameter("phoneNumber2") + "-" + request.getParameter("phoneNumber3");
	    System.out.println("u_phoneNumber : " + u_phoneNumber );
	    dto.setU_phoneNumber(u_phoneNumber);
	        
	    userService.update(dto);
		System.out.println(dto);
			
		session.setAttribute("action", "update");
	    return "/user/complete";
	}
	
	//유저 탈퇴 처리
	@RequestMapping(value = "/user/deleteDB", method = RequestMethod.GET)
	public String deleteDB(HttpServletRequest request, HttpSession session) throws Exception{
		System.out.println("User deleteDB");
		
		String u_id = (String) session.getAttribute("userId");
		userService.delete(u_id);
		session.setAttribute("action", "delete");
		return "/user/complete";
	}
	
	@RequestMapping(value = "/user/Logincomplete", method = RequestMethod.GET)
	public String Logincomplete(HttpSession session) throws Exception{
		String userid = (String)session.getAttribute("userId");
		session.setAttribute("dto", userService.selectUser(userid));
		return "/main/exFinder_main";
	}
	
	@RequestMapping(value = "/user/myPage", method = RequestMethod.GET)
	public void myPage() throws Exception{
		
	}
	@RequestMapping(value = "/user/myInfo", method = RequestMethod.GET)
	public void myInfo(Model model, HttpSession session) throws Exception{
		String userid = (String)session.getAttribute("userId");
		model.addAttribute("dto", userService.selectUser(userid));
		
	}

	
	@RequestMapping(value = "/user/myBoard", method = RequestMethod.GET)
	public void myBoard() throws Exception{
		
	}
}
