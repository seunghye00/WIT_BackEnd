package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

    @Autowired
    private SqlSession sqlSession;

    public String getUserNameByLoginID(String loginID) {
        return sqlSession.selectOne("user.getUserNameByLoginID", loginID);
    }
}