package com.exfinder.service;

import java.util.List;

import com.exfinder.dao.CsDao;
import com.exfinder.dto.CsDto;

public interface CsService {
	
	public void create(CsDto cs) throws Exception;
	public CsDto read(int cs_id) throws Exception;
	public void update(CsDto cs) throws Exception;
	public void delete(int cs_id) throws Exception;
	public List<CsDto> listAll() throws Exception;
	public void updateStatus(int cs_id, int cs_state) throws Exception;
	public List<CsDto> listActive() throws Exception;

}
