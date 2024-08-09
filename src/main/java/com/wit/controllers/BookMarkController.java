package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.services.BookMarkService;

@Controller
@RequestMapping("/bookmark")
public class BookMarkController {
	@Autowired
	private HttpSession session;
	
	@Autowired
	private BookMarkService bmServ;
	
	@RequestMapping("/toggle")
	@ResponseBody // json 또는 xml 반환: ajax 요청 처리시 json 이나 xml 등의 형식으로 응답반환 할 떄 사용
	public String toggleBookMark(@RequestParam("board_seq") int boardSeq) {
		try {
			String empNo = (String) session.getAttribute("loginID");
			
			// BookMarkService를 통해 북마크 상태를 토글
			boolean isBookmarked = bmServ.toggleBookmark(boardSeq, empNo);
			// 북마크가 추가되면 bookmarked, 제거되면 unbookmarked반환
			return isBookmarked ? "bookmarked" : "unbookmarked";
		} catch(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
