package com.exfinder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exfinder.dto.UserDto;
import com.exfinder.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService service;
	
	@RequestMapping(value="/moveMyPage", method = RequestMethod.GET)
	public String movemyPage(String u_id,Model model) {
		UserDto dto = service.getUser(u_id);
		model.addAttribute("dto", dto);
		return "/user/myPage";
	}
	
	@RequestMapping(value="/updateUser", method = RequestMethod.POST)
	public String updateUser(UserDto dto,RedirectAttributes rttr) {
		int result = service.updateUser(dto);
		String msg = result == 1 ? "수정  완료되었습니다." : "수정 실패했습니다. 다시 시도해주세요.";
		rttr.addFlashAttribute("msg", msg);
		return "redirect:/moveMyPage";
	}

}
