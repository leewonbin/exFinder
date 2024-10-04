package com.exfinder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.exfinder.dto.AuthoritiesDto;
import com.exfinder.dto.BoardDto;
import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.CurrencyInfoDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.AuthoritiesService;
import com.exfinder.service.BoardService;
import com.exfinder.service.CurrencyService;
import com.exfinder.service.UserService;
import com.exfinder.util.FileUtil;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AuthoritiesService authoritiesService; 
	
	@Autowired
    PasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private CurrencyService currencyService;

	// 유저 로그인
	@RequestMapping(value = "/user/login", method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest request) throws Exception{
	
	    // 쿠키에서 저장된 아이디를 가져옴
	    String savedId = null;
	    String idSaveChecked = null;
	    Cookie[] cookies = request.getCookies(); // 클라이언트의 쿠키를 가져옴

	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("id_save")) {
	                savedId = cookie.getValue(); // 저장된 아이디를 가져옴        
	            }
	            if (cookie.getName().equals("id_save_Checked")) {
	                idSaveChecked = cookie.getValue(); // 저장된 체크박스 상태를 가져옴
	            }
	        }
	    }

	    // 쿠키에 저장된 아이디가 있을 경우 세션에 저장
	    if (savedId != null) {
	    	model.addAttribute("id_save", savedId);
	        model.addAttribute("id_save_Checked", idSaveChecked);
	    }

	    return "/user/login"; // 로그인 페이지로 이동
	}



	// 로그인 상태 확인 메서드
	@RequestMapping(value = "/checkLogin", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Boolean> checkLoginStatus(HttpSession session) {
	    Map<String, Boolean> response = new HashMap<>();
	    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
	    
	    // 로그인 상태를 Map에 추가
	    response.put("isLoggedIn", isLoggedIn != null && isLoggedIn);
	    
	    // JSON 형식으로 응답
	    return response;
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
		
		
		AuthoritiesDto authDto = new AuthoritiesDto();
		String join_id = dto.getU_id();
		authDto.setU_id(join_id);
		
		// *
		if (join_id.equals("admin1234")) {
			authDto.setAuthority("ROLE_ADMIN");
			authoritiesService.insert(authDto);
		}else {
			authDto.setAuthority("ROLE_MEMBER");
			authoritiesService.insert(authDto);
		}
		
		return "redirect:/";
	}
	
	//유저 탈퇴 처리, 비활성화
	@RequestMapping(value = "/user/deactivateDB", method = RequestMethod.GET)
	public String deactivateDB(HttpServletRequest request, HttpSession session) throws Exception{
		System.out.println("유저 계정이 비활성화 되었습니다.");
		
		String u_id = (String) session.getAttribute("userId");
		userService.deactivate(u_id);
		
		return "/";
	}
	
	@RequestMapping(value = "/user/Logincomplete", method = RequestMethod.GET)
	public String Logincomplete(HttpSession session) throws Exception{
		String userid = (String)session.getAttribute("userId");
		
		session.setAttribute("dto", userService.selectUser(userid));
		UserDto dto = (UserDto)session.getAttribute("dto");
		System.out.println(dto);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/user/myPage", method = RequestMethod.GET)
	public void myPage() throws Exception{
		
	}
	@RequestMapping(value = "/user/myInfo", method = RequestMethod.GET)
	public void myInfo(UserDto dto, Model model, HttpSession session) throws Exception{
		String userid = (String)session.getAttribute("userId");
		dto = userService.selectUser(userid);
		session.setAttribute("dto", dto);
		System.out.println("/user/myInfo : " + dto);
		
		String u_email = dto.getU_email();
        String[] u_emailArr = u_email.split("@");
        session.setAttribute("u_emailArr", u_emailArr);
            
        String u_phoneNumber = dto.getU_phoneNumber();
        String[] u_phoneNumberArr = u_phoneNumber.split("-");
        session.setAttribute("u_phoneNumberArr", u_phoneNumberArr);
		
	}
	
	@RequestMapping(value = "/user/myInfo/menber_upDB", method = RequestMethod.POST)
	public String menber_upDB(UserDto dto, String u_pw, Model model, HttpServletRequest request) throws Exception{
		
		String u_email = request.getParameter("email") + "@" + request.getParameter("select");
	    System.out.println("u_email : " + u_email);
	    dto.setU_email(u_email);
	    	
		String u_phoneNumber = request.getParameter("phoneNumber1") + "-" + request.getParameter("phoneNumber2") + "-" + request.getParameter("phoneNumber3");
	    System.out.println("u_phoneNumber : " + u_phoneNumber );
	    dto.setU_phoneNumber(u_phoneNumber);
		
	    userService.update(dto);
		System.out.println(dto);
		
		return "redirect:/user/myInfo";
	}
	
	@RequestMapping(value = "/user/myInfo/pw_upDB", method = RequestMethod.POST)
	public String pw_upDB(UserDto dto, String u_pw, Model model, HttpSession session) throws Exception{
		String u_id = (String) session.getAttribute("userId");
	    
		String encPassword = bcryptPasswordEncoder.encode(u_pw);

		userService.pw_update(u_id, encPassword);
		
		System.out.println("u_id : " + u_id);
		System.out.println("u_pw : " + encPassword);
		return "/user/myPage";
	}
	
	
	
	@RequestMapping(value="/user/myInfo/updateImg", method=RequestMethod.POST)
	public String updateImg(UserDto dto, MultipartHttpServletRequest mpRequest, Model model, HttpSession session)throws Exception {
		String u_id = (String) session.getAttribute("userId");
		System.out.println("u_id : " + u_id);
		dto.setU_id(u_id);
		
		// 현재 사용자의 기존 프로필 이미지 경로를 가져옴
        UserDto currentUser = userService.selectUser(u_id);
        String oldImgPath = currentUser.getU_profile_img();
        
	    
		String user_Img = FileUtil.updateImg(mpRequest, oldImgPath); 
		dto.setU_profile_img(user_Img);
		userService.updateImg(user_Img, u_id);
		
		// 세션 정보 갱신
	    session.setAttribute("dto", userService.selectUser(u_id));
	    
		System.out.println("/user/myInfo/updateImg : " + dto);
				
		return "redirect:/user/myInfo";
	}
	@RequestMapping(value = "/user/myBoard", method = RequestMethod.GET)
	public String myBoard(Model model, HttpSession session) throws Exception {
	    // 세션에서 UserDto 객체를 가져옴
	    UserDto dto = (UserDto) session.getAttribute("dto");

	    // 사용자가 로그인하지 않은 경우 처리 (로그인 페이지로 리다이렉트)
	    if (dto == null) {
	        return "redirect:/login";
	    }

	    // 사용자 ID를 가져옴
	    String userId = dto.getU_id();

	    // 게시글 조회 서비스 호출
	    try {
	        // 사용자가 작성한 게시글을 서비스에서 가져오기
	        List<BoardDto> userPosts = service.getUserPosts(userId);

	        // 게시글이 없을 경우 처리
	        if (userPosts == null || userPosts.isEmpty()) {
	            model.addAttribute("message", "작성된 게시글이 없습니다.");
	        } else {
	            // 모델에 게시글 추가하여 JSP에 전달
	            model.addAttribute("userPosts", userPosts);
	        }
	    } catch (Exception e) {
	        // 에러 발생 시 로그 출력
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "게시글 조회 중 오류가 발생했습니다.");
	    }

	    return "/user/myBoard";  // myBoard.jsp로 이동
	}
	
	@RequestMapping(value = "/user/bookMark", method = RequestMethod.GET)
	public String getFavoriteCurrencies(HttpSession session, Model model) throws Exception{
		 String userId = (String) session.getAttribute("userId"); // 세션에서 사용자 ID 가져오기
	        List<CurrencyDto> favoriteCurrencies = currencyService.getFavoriteCurrencies(userId);
	        model.addAttribute("userCurrencies", favoriteCurrencies);
	        return "/user/bookMark"; // JSP 파일 이름
	}
	
	@RequestMapping(value = "/user/notification", method = RequestMethod.GET)
	public void notification(Model model) throws Exception{
		List<CurrencyInfoDto> list = currencyService.currencyInfoSelect();
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value="/user/setExchangeAlert", method = RequestMethod.POST)
	public String notificationDB(@Param("currency")String currency, @Param("targetRate")int targetRate) {
		return "redirect:/user/notification";
	}
	
	
}
