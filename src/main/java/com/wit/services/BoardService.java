package com.wit.services;

import java.util.List;

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
    
    // 게시물 조회
    public List<BoardDTO> list(){
    	return dao.list();
    }
}
