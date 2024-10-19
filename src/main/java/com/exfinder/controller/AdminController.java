package com.exfinder.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.exfinder.dto.AuthoritiesDto;
import com.exfinder.dto.BoardDto;
import com.exfinder.dto.CsDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.AdminService;
import com.exfinder.service.BoardService;
import com.exfinder.service.CsService;
import com.exfinder.service.UserService;


@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CsService service;

	@Autowired
	private BoardService boardService;


	@RequestMapping(value = "/admin/admin", method = RequestMethod.GET)
	public String admin(Model model,HttpSession session) throws Exception {
		String userid = (String)session.getAttribute("userId");
		session.setAttribute("dto", userService.selectUser(userid));
		
		ArrayList<UserDto> userList = adminService.selectAll(); // DB에서 데이터 가져오기
		model.addAttribute("userList", userList); // 모델에 추가하여 JSP로 전달
		
		ArrayList<AuthoritiesDto> authorityList = adminService.selectAllAuthorities(); // DB에서 권한 데이터 가져오기
	    model.addAttribute("authorityList", authorityList); // 모델에 추가하여 JSP로 전달
	    
	    List<CsDto> list = service.listAll(); 
	    model.addAttribute("list", list);
	    
	    // 게시판 목록을 가져오는 서비스 호출 (BoardService 사용)
        List<BoardDto> boardList = boardService.adminBoardList();
        
        // 가져온 목록을 모델에 추가하여 뷰로 전달
        model.addAttribute("boardList", boardList);
        
		return "/admin/admin";
	}
	
	// 권한 업데이트를 처리하는 POST 요청
    @RequestMapping(value = "/admin/updateAuthority", method = RequestMethod.POST)
    public String updateAuthority(@RequestParam String u_id, @RequestParam String authority, RedirectAttributes redirectAttributes) {
        try {
            AuthoritiesDto authoritiesDto = new AuthoritiesDto(u_id, authority);
            adminService.updateAuthority(authoritiesDto);
            redirectAttributes.addFlashAttribute("message", "권한을 변경하였습니다.!");
        } catch (Exception e) {
            logger.error("Error updating authority", e);
            redirectAttributes.addFlashAttribute("error", "권한변경 실패.");
        }
        return "redirect:/admin/admin"; // 권한 업데이트 후 다시 관리자 페이지로 리다이렉트
    }
    // 계정상태 업데이트를 처리하는 POST 요청
    @RequestMapping(value = "/admin/updateStatus", method = RequestMethod.POST)
    public String updateStatus(@RequestParam String u_id, @RequestParam int enabled, RedirectAttributes redirectAttributes) {
        try {
            adminService.updateStatus(u_id, enabled);
            redirectAttributes.addFlashAttribute("message", "상태를 변경하였습니다.");
        } catch (Exception e) {
            logger.error("Error updating status", e);	
            redirectAttributes.addFlashAttribute("error", "상태변경 실패.");
        }
        return "redirect:/admin/admin"; // 상태 업데이트 후 다시 관리자 페이지로 리다이렉트
    }
    
    @RequestMapping(value = "/admin/updateUser", method = RequestMethod.POST)
    public String updateUser(@ModelAttribute UserDto userDto, RedirectAttributes redirectAttributes) {
        try {
            adminService.updateUser(userDto);
            redirectAttributes.addFlashAttribute("message", "정보가 수정되었습니다.");
        } catch (Exception e) {
            logger.error("Error updating user", e);
            redirectAttributes.addFlashAttribute("error", "정보 수정에 실패했습니다.");
        }
        return "redirect:/admin/admin";
    }
    @RequestMapping(value = "/admin/updateBoardStatus", method = RequestMethod.POST)
    public String updateBoardStatus(@RequestParam("b_id") int b_id,@RequestParam String b_del,RedirectAttributes redirectAttributes) throws Exception {
    	try {
            adminService.updateBoardStatus(b_id,b_del);
            redirectAttributes.addFlashAttribute("message", "상태를 변경하였습니다.");
        } catch (Exception e) {
            logger.error("Error updating status", e);	
            redirectAttributes.addFlashAttribute("error", "상태변경 실패.");
        }
        
        // 관리자 게시판 목록을 보여줄 뷰 이름 리턴 (예: adminBoardList.jsp)
        return "redirect:/admin/admin";
    }
    @RequestMapping(value = "/admin/deleteBoardAdmin", method = RequestMethod.POST)
    public String deleteBoardAdmin(@RequestParam("b_id") int b_id,RedirectAttributes redirectAttributes) throws Exception  {
    	try {
            // 게시물 삭제 서비스 호출
            adminService.deleteBoardAdmin(b_id);
            redirectAttributes.addFlashAttribute("message", "게시물을 삭제하였습니다.");
        } catch (Exception e) {
            logger.error("게시물 삭제 실패", e);
            redirectAttributes.addFlashAttribute("error", "게시물 삭제 실패.");
        }
        return "redirect:/admin/admin";  // 게시판 목록으로 리다이렉트
    }
}
    

    
   


