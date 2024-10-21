package com.exfinder.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exfinder.dto.CsDto;
import com.exfinder.service.CsService;
import com.exfinder.service.UserService;

@Controller
@RequestMapping("/cs/*")
public class CsController {
	
	private static final Logger logger = LoggerFactory.getLogger(CsController.class);
	
	@Autowired
	private CsService service;
	
	@Autowired
	private CsService csService;
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String createGET(CsDto cs, Model model) throws Exception{
		logger.info("create get..........");
		return "/cs/create";
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createPOST(CsDto cs, Model model, RedirectAttributes rttr,HttpSession session, CsDto csDto) throws Exception{
		// 세션에서 로그인된 사용자 ID 가져오기
        String userId = (String) session.getAttribute("userId");
        csDto.setU_id(userId);  // u_id 세션에서 설정
		/* session.setAttribute("dto", userService.selectUser(userId)); */
		logger.info("create post..........");
		logger.info(cs.toString());
		System.out.println(cs);
		
		service.create(cs);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/admin/adminCs";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("cs_id") int cs_id, Model model) throws Exception {
		logger.info("read.........." + cs_id);
		CsDto cs = service.read(cs_id);
		model.addAttribute("CsDto", cs);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateGET(int cs_id, Model model) throws Exception {
		CsDto cs = service.read(cs_id);
	    model.addAttribute("CsDto", cs);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(CsDto cs, RedirectAttributes rttr, HttpSession session, CsDto csDto) throws Exception {
		// 세션에서 로그인된 사용자 ID 가져오기
        String userId = (String) session.getAttribute("userId");
        csDto.setU_id(userId);  // u_id 세션에서 설정
		System.out.println("--------------------------확인");
		System.out.println(cs.toString());
		logger.info("mod post..........");
		service.update(cs);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/admin/adminCs";
	}
	
	// 글 상태 업데이트를 처리하는 POST 요청
    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
    public String updateStatus(@RequestParam int cs_id, @RequestParam int cs_state, RedirectAttributes redirectAttributes) {
        try {
            csService.updateStatus(cs_id, cs_state);
            redirectAttributes.addFlashAttribute("message", "상태가 변경되었습니다.");
        } catch (Exception e) {
            logger.error("Error updating status", e);	
            redirectAttributes.addFlashAttribute("error", "상태변경 실패.");
        }
        return "redirect:/admin/adminCs"; // 상태 업데이트 후 다시 관리자 페이지로 리다이렉트
    }

	
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("cs_id") int cs_id, RedirectAttributes rttr) throws Exception {
		service.delete(cs_id);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/admin/adminCs";
	}

	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(Model model) throws Exception {
	    logger.info("listAll..........");
	    List<CsDto> list = service.listAll(); 
	    model.addAttribute("list", list);
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) throws Exception{
	    logger.info("main page..........");
	    List<CsDto> qnaList = service.listActive(); // 활성화된 항목만 가져오기
	    model.addAttribute("qnaList", qnaList);
	    return "/cs/main";
	}
}

