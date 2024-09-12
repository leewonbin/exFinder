package com.exfinder.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.exfinder.dto.CommentDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.CommentService;

@RestController
@RequestMapping("/comments")
public class CommentController {

	@Autowired
	private CommentService cs;

	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

	@RequestMapping(value = "/create", method = RequestMethod.POST)
    public ResponseEntity<String> commentCreate(@RequestBody CommentDto dto,HttpSession session) {
        ResponseEntity<String> entity = null;
        try {
        	UserDto userDto = (UserDto) session.getAttribute("dto");
        	if(userDto ==null) {
        		return new ResponseEntity<>("LOGIN_REQUIRED", HttpStatus.UNAUTHORIZED);
        	}
        	dto.setU_id(userDto.getU_id());
        	cs.commentCreate(dto);
        	entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
        } catch (Exception e) {
        	logger.error("Error creating comment", e);
        	entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
	}
			
//		ResponseEntity<String> entity = null;
//        System.out.println(dto.toString());
//        try {
//        	System.out.println("==============생성 댓글 정보=============");
//        	System.out.println(dto.toString());
//        	UserDto userDto = (UserDto)session.getAttribute("dto");
//        	dto.setU_id(userDto.getU_id());
//            cs.commentCreate(dto);
//            entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
//        }
//        return entity;
	

	@RequestMapping(value = "/reCreate", method = RequestMethod.POST)
	public ResponseEntity<String> reCommentCreate(@RequestBody CommentDto dto,HttpSession session) {
		ResponseEntity<String> entity = null;
		try {
			UserDto userDto = (UserDto) session.getAttribute("dto");
			if (userDto == null) {
				return new ResponseEntity<>("LOGIN_REQUIRED", HttpStatus.UNAUTHORIZED);
			}
			dto.setU_id(userDto.getU_id());
			cs.reCommentCreate(dto);
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			logger.error("Error creating reply comment", e);
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
			
//		System.out.println("답글 dto : " + dto.toString());
//	    ResponseEntity<String> entity = null;
//	    try {
//	    	UserDto userDto = (UserDto)session.getAttribute("dto");
//        	dto.setU_id(userDto.getU_id());
//	        cs.reCommentCreate(dto); 
//	        entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//	    }
//	    return entity;
//	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ResponseEntity<String> commentUpdate(@RequestBody CommentDto dto,HttpSession session) {	//@RequestBody vs RequestParam
		ResponseEntity<String> entity = null;
		try {
			UserDto userDto = (UserDto) session.getAttribute("dto");
			if (userDto == null) {
				return new ResponseEntity<>("LOGIN_REQUIRED", HttpStatus.UNAUTHORIZED);
			}
			
			CommentDto existingComment = cs.getCommentById(dto.getComm_id());
			if (existingComment == null) {
				return new ResponseEntity<>("COMMENT_NOT_FOUND", HttpStatus.NOT_FOUND);
			}
			if (!userDto.getU_id().equals(existingComment.getU_id())) {
				return new ResponseEntity<>("NOT_AUTHORIZED", HttpStatus.FORBIDDEN);
			}
			
			dto.setU_id(userDto.getU_id());
			cs.commentUpdate(dto);
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			logger.error("Error updating comment", e);
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
		
		//	//public ResponseEntity<String> commentUpdate(@RequestParam("comm_id") int comm_id, @RequestBody CommentDto dto) {
//	    ResponseEntity<String> entity = null;
//	    try {
//	        // DTO에 comm_id 설정
//	        //dto.setComm_id(comm_id);
//	    	System.out.println("commentDTO : " + dto.toString());
//	    	UserDto userDto = (UserDto)session.getAttribute("dto");
//        	dto.setU_id(userDto.getU_id());
//	        cs.commentUpdate(dto);
//	        entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
//	    }
//	    return entity;
//	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> commentDelete(@RequestParam("comm_id") int comm_id, HttpSession session) {
		ResponseEntity<String> entity = null;
        try {
            UserDto userDto = (UserDto) session.getAttribute("dto");
            if (userDto == null) {
                return new ResponseEntity<>("LOGIN_REQUIRED", HttpStatus.UNAUTHORIZED);
            }

            CommentDto existingComment = cs.getCommentById(comm_id);
            if (existingComment == null) {
                return new ResponseEntity<>("COMMENT_NOT_FOUND", HttpStatus.NOT_FOUND);
            }
            if (!userDto.getU_id().equals(existingComment.getU_id())) {
                return new ResponseEntity<>("NOT_AUTHORIZED", HttpStatus.FORBIDDEN);
            }

            cs.commentDelete(comm_id);
            List<CommentDto> replies = cs.selectReply(comm_id);
            if (replies != null) {
                for (CommentDto reply : replies) {
                    cs.commentDelete(reply.getComm_id());
                }
            }
            entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error deleting comment", e);
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }
		
		//	    ResponseEntity<String> entity = null;
//	    try {
//	        cs.commentDelete(comm_id);
//	        List<CommentDto> list = cs.selectReply(comm_id);
//	        if(list != null) {
//	        	for(CommentDto dto : list) {
//	        		cs.commentDelete(dto.getComm_id());
//	        	}
//	        }
//	        entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
//	    }
//	    return entity;
//	}
	
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public ResponseEntity<List<CommentDto>> commentList(@RequestParam("b_id") int b_id) {
		System.out.println("b_id" + b_id);
		ResponseEntity<List<CommentDto>> entity = null;
		try {
			List<CommentDto> list = cs.commentList(b_id);
			entity = new ResponseEntity<>(list, HttpStatus.OK);	//통신상태
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}