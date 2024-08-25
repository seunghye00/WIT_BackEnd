package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.ReplyDTO;
import com.wit.services.ReplyService;

@Controller
@RequestMapping("/reply/")
public class ReplyController {
	
	@Autowired
	private ReplyService rs;
	
	@Autowired
	private HttpSession session;
	
	// 댓글 등록
	@RequestMapping("registProc")
	public String input(ReplyDTO dto, @RequestParam(defaultValue = "1") int boardCode,
			@RequestParam(defaultValue = "false") String bookmark,
			@RequestParam(defaultValue = "false") String report) throws Exception{
		String writer = (String) session.getAttribute("loginID");
		System.out.println(writer);
		dto.setEmp_no(writer);
		rs.input(dto);
		return "redirect:/board/detail?board_seq="+dto.getBoard_seq()+"&boardCode="+boardCode+"&bookmark="+bookmark+"&report="+report;
	}
	
	// 댓글 삭제
	@RequestMapping("delete")
	public String delete(int replySeq, int boardSeq) throws Exception{
		rs.delete(replySeq);
		return "redirect:/board/detail?board_seq="+ boardSeq;
	}
	// 댓글 수정
	@RequestMapping("update")
	@ResponseBody
	public String update(ReplyDTO dto) throws Exception{
		return rs.update(dto);
		
	}
	// ExceptionHandler : 예외 발생했을때 이 핸들러가 처리
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
