package com.exfinder.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exfinder.dto.BoardDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.AdminService;
import com.exfinder.service.BoardService;
import com.exfinder.service.UserService;
import com.exfinder.vo.BoardVo;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private AdminService adminService;

	@RequestMapping(value = "/admin/admin", method = RequestMethod.GET)
	public String admin(Model model) throws Exception {
		ArrayList<UserDto> userList = adminService.selectAll(); // DB에서 데이터 가져오기
		model.addAttribute("userList", userList); // 모델에 추가하여 JSP로 전달
		return "/admin/admin";
	}
	
	@RequestMapping(value = "/admin/updateAuthority", method = RequestMethod.POST)
	public String updateAuthority(@RequestParam("u_id") String uId, @RequestParam("authority") String authority) throws Exception {
	    adminService.updateAuthority(uId, authority); // 권한 업데이트 메서드 호출
	    return "redirect:/admin"; // 업데이트 후 관리자 페이지로 리디렉션
	}


}