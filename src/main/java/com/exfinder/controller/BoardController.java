package com.exfinder.controller;

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
import com.exfinder.service.BoardService;
import com.exfinder.vo.BoardVo;

@Controller
@RequestMapping("/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService service;

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String createGET(BoardDto board, Model model) throws Exception {
		logger.info("create get..........");
		return "/board/create";
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createPOST(BoardDto board, Model model, RedirectAttributes rttr) throws Exception {
		logger.info("create post..........");
		
		System.out.println(board);
		service.create(board);
		rttr.addFlashAttribute("msg", "생성 완료 되었습니다.");
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("b_id") int b_id, Model model) throws Exception {
		logger.info("read.........." + b_id);
		
		service.b_viewUpdate(b_id);				//조회수
		model.addAttribute(service.read(b_id));	//model.addAttribute("board", board); 명확한 키 사용
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateGET(int b_id, Model model) throws Exception {
		model.addAttribute(service.read(b_id));
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(BoardDto board, RedirectAttributes rttr) throws Exception {
		logger.info("mod post..........");
		service.update(board);
		rttr.addFlashAttribute("msg", "수정 완료 되었습니다.");
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("b_id") int b_id, RedirectAttributes rttr) throws Exception {
		service.delete(b_id);
		rttr.addFlashAttribute("msg", "삭제 완료 되었습니다.");
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(@RequestParam(value = "b_category", required = false) String b_category,
	                    @RequestParam(value = "searchType", required = false) String searchType,
	                    @RequestParam(value = "keyword", required = false) String keyword,
	                    @ModelAttribute("boardVo") BoardVo vo, Model model) throws Exception {
		
		System.out.println("현재페이지: " + vo.getPage());
		
		logger.info("show all list..........");
		System.out.println("--list pm " + vo);
		
		if(b_category != null && !b_category.isEmpty()) {
			vo.setbCategory(b_category);
		}
		
		if(searchType != null && !searchType.isEmpty()) {
			vo.setSearchType(searchType);
		}
		
		if(keyword != null && !keyword.isEmpty()) {
			vo.setKeyword(keyword);
		}else {
			vo.setKeyword(null);		//검색창 비어있을 때 관련 카테고리 전부 나오게
		}
		
		int totalCnt = service.listAll().size();
	    List<BoardDto> boardList = service.listSearch(vo); 
	    vo.setTotalCount(totalCnt);
	    model.addAttribute("list", boardList);
	    model.addAttribute("boardVo", vo);
		
	    System.out.println("확인용~~~~" + boardList);
	    
		model.addAttribute("page", vo.getPage());
		model.addAttribute("perPageNum", vo.getPerPageNum());
		model.addAttribute("searchType", vo.getSearchType());
		model.addAttribute("keyword", vo.getKeyword());
		
	}
}
