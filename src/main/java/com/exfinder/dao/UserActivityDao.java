package com.exfinder.dao;

import java.util.List;
import com.exfinder.dto.UserActivityDto;

public interface UserActivityDao {
    public void create(UserActivityDto userActivity) throws Exception; 						// 사용자 활동 기록 생성
    public List<UserActivityDto> getFrequentCurrencies(String userId) throws Exception; 	// 특정 사용자 자주 조회하는 통화 가져오기
    public void updateViewCount(UserActivityDto userActivity);
}
