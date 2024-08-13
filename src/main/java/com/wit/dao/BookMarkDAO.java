package com.wit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.BookMarkDTO;

@Repository
public class BookMarkDAO {
	
	@Autowired
	private SqlSession mybatis;
	 
	// 북마크가 존재하는지 확인
	public boolean isBookmarked(int boardSeq, String empNo) throws Exception{
		// BookMaroDTO 객체 생성
		BookMarkDTO bookmarkDTO = new BookMarkDTO();
		bookmarkDTO.setBoard_seq(boardSeq);
		bookmarkDTO.setEmp_no(empNo);
		
		// MyBatis 쿼리 호출
		Integer count = mybatis.selectOne("bookMark.isBookmarked",bookmarkDTO);
		
		// count가 0보다 크면 북마크가 존재한다고 판단
		return count != null && count > 0;
		
	}
	
	// 북마크 추가
	public void addBookmark(int boardSeq, String empNo) throws Exception{
		// BookMaroDTO 객체 생성
		BookMarkDTO bookmarkDTO = new BookMarkDTO();
		bookmarkDTO.setBoard_seq(boardSeq);
		bookmarkDTO.setEmp_no(empNo);
		
		mybatis.insert("bookMark.addBookmark", bookmarkDTO);
	}
	
	// 북마크 제거 
	public void removeBookmark(int boardSeq, String empNo) throws Exception{
		// BookMaroDTO 객체 생성
		BookMarkDTO bookmarkDTO = new BookMarkDTO();
		bookmarkDTO.setBoard_seq(boardSeq);
		bookmarkDTO.setEmp_no(empNo);
		
		mybatis.delete("bookMark.removeBookmark", bookmarkDTO);
	}
}
