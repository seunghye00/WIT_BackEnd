package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.wit.dto.BoardDTO;

@Repository
public class BoardDAO {
    @Autowired
    private SqlSession mybatis;

    // 게시물 등록
    public int write(BoardDTO dto) {
        mybatis.insert("board.write", dto);
        return dto.getBoard_seq();
    }
}
