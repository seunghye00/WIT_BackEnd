package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.BookMarkDAO;

@Service
public class BookMarkService {
	
	@Autowired
	private BookMarkDAO bmdao;
	
	// 북마크 상태 확인
	public boolean toggleBookmark(int boardSeq, String empNo) throws Exception{
		if(bmdao.isBookmarked(boardSeq, empNo)) {
			// 북마크가 이미 존재하면 제거
			bmdao.removeBookmark(boardSeq, empNo);
			// 북마크가 제거되었음을 반환
			return false; 
		} else {
			// 북마크가 존재하지 않으면 추가
			bmdao.addBookmark(boardSeq,empNo);
			// 북마크가 추가되었음을 반환
			return true;
		}
	}
	public boolean isBookmarked(int boardSeq, String empNo) throws Exception{
		return bmdao.isBookmarked(boardSeq, empNo);
	}
}
