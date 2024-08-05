package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.wit.dto.BoardFilesDTO;

@Repository
public class BoardFilesDAO {

    @Autowired
    private SqlSession mybatis;

    // 파일 등록
    public int upload(BoardFilesDTO dto) throws Exception {
        return mybatis.insert("file.upload", dto);
    }
}
