package com.exfinder.dao;

import java.util.List;

import com.exfinder.dto.CsDto;

public interface CsDao {
	
	public void create(CsDto cs) throws Exception;
	public CsDto read(int cs_id) throws Exception;
	public void update(CsDto cs) throws Exception;
	public void delete(int cs_id) throws Exception;
	public List<CsDto> listAll() throws Exception;

}
