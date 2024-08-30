package com.exfinder.service;

import java.util.List;

import com.exfinder.dto.CommentDto;

public interface CommentService {
	
	public void commentCreate(CommentDto dto) throws Exception;	//댓글 생성
	
	public void reCommentCreate(CommentDto dto) throws Exception;	//대댓글 생성

	public void commentUpdate(CommentDto dto) throws Exception;	//댓글 수정
	
	public void commentDelete(int comm_id) throws Exception;	//댓글 삭제

	public List<CommentDto> commentList(int comm_id) throws Exception;	//댓글 조회
	
	public int commentCount(int comm_id) throws Exception;	//댓글 수
	
//	public CommentDto readParent(int comm_id) throws Exception;	//부모 댓글
	
	public List<CommentDto> selectReply(int comm_id) throws Exception;
	
}