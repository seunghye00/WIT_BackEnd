package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wit.dao.BoardDAO;
import com.wit.dto.BoardDTO;

@Service
public class BoardService {

    @Autowired
    private BoardDAO dao;

    // 게시물 등록
    public int write(BoardDTO dto) {
        dao.write(dto);
        return dto.getBoard_seq();
    }
}
