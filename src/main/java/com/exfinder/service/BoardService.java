package com.exfinder.service;

import java.util.List;

import com.exfinder.dto.BoardDto;
import com.exfinder.vo.BoardVo;

public interface BoardService {

	public void create(BoardDto board) throws Exception;	//게시판 생성
	public BoardDto read(int b_id) throws Exception;		//특정 게시판 항목 조회
	public void update(BoardDto board) throws Exception;	//게시판 항목 업데이트
	public void delete(int b_id) throws Exception;			//특정 게시판 항목 삭제
	public List<BoardDto> listAll() throws Exception;		//모든 게시판 항목 조회
	
	public void b_viewUpdate(int b_id) throws Exception;				//조회수 업데이트
	public List<BoardDto> listSearch(BoardVo vo) throws Exception;		//검색 조건에 맞는 게시판 항목 조회
	public int categoryCnt(BoardVo vo) throws Exception;
}
