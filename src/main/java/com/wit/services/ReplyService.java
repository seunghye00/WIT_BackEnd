package com.wit.services;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.ReplyDAO;
import com.wit.dto.ReplyDTO;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyDAO dao;
	
	// 댓글 입력
	public int input(ReplyDTO dto) throws Exception{
		return dao.insert(dto);
	}
	
	// 댓글 삭제
	public int delete(int replySeq) throws Exception{
		return dao.delete(replySeq);
	}
	
	// 댓글 수정
	public String update(ReplyDTO dto) throws Exception{
		Timestamp result = dao.update(dto);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String format = sdf.format(result);
		return format;
		
	}
	// 댓글 리스트
	public List<ReplyDTO> replyList(int boardSeq) throws Exception{
		return dao.selectAll(boardSeq);
	}
}
