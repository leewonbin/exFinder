package com.exfinder.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.BoardDao;
import com.exfinder.dto.BoardDto;
import com.exfinder.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void create(BoardDto board) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.create(board);
	}
	
	@Override
	public BoardDto read(int b_id) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.read(b_id);
	}

	@Override
	public void update(BoardDto board) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.update(board);
	}

	@Override
	public void delete(int b_id) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.delete(b_id);
	}
	
	@Override
	public List<BoardDto> listAll() throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		List<BoardDto> dtos = dao.listAll();
		return dtos;
	}
	
//-------------------------------------------------------------------------

	@Override
	public void b_viewUpdate(int b_id) throws Exception{
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.b_viewUpdate(b_id);
	}
	
	@Override
	public List<BoardDto> listSearch(BoardVo vo) throws Exception{
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		return dao.listSearch(vo);
	}
	

}
