package com.wit.dao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.ReplyDTO;

@Repository
public class ReplyDAO {

	@Autowired
	private SqlSession mybatis;
	
	// 댓글 입력
	public int insert(ReplyDTO dto) throws Exception{
		return mybatis.insert("Reply.insert",dto);
	}
	
	// 댓글 리스트 출력
	public List<ReplyDTO> selectAll(int boardSeq) throws Exception{
		return mybatis.selectList("Reply.selectAll", boardSeq);
	}
	
	// 댓글 삭제
	public int delete(int replySeq) throws Exception{
		return mybatis.delete("Reply.delete", replySeq);
	}
	
	// 댓글 수정
	public Timestamp update(ReplyDTO dto) throws Exception{
		if(mybatis.update("Reply.update",dto)>0) {
			return mybatis.selectOne("Reply.writeDate",dto.getReply_seq());
		}
		return null;
	}
}
