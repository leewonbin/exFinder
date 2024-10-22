package com.exfinder.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.UserActivityDao;
import com.exfinder.dto.UserActivityDto;

@Service
public class UserActivityServiceImpl implements UserActivityService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void create(UserActivityDto userActivity) throws Exception {
        UserActivityDao dao = sqlSession.getMapper(UserActivityDao.class);
        dao.create(userActivity);
    }

    @Override
    public List<UserActivityDto> getFrequentCurrencies(String userId) throws Exception {
        UserActivityDao dao = sqlSession.getMapper(UserActivityDao.class);
        return dao.getFrequentCurrencies(userId);
    }

    @Override
    public void updateViewCount(UserActivityDto userActivity) {
        UserActivityDao dao = sqlSession.getMapper(UserActivityDao.class);
        dao.updateViewCount(userActivity);
    }


}
