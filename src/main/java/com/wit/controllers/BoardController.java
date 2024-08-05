package com.wit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import com.wit.dto.BoardDTO;
import com.wit.services.BoardService;
import com.wit.services.FileService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private HttpSession session;

	@Autowired
	private BoardService bserv;

	@Autowired
	private FileService fserv;

	// 게시판으로 이동
	@RequestMapping("/list")
	public String list(Model model) throws Exception {
		List<BoardDTO> boardList = bserv.list();
        model.addAttribute("list", boardList);
		return "Board/board";
	}

	// 글작성
	@RequestMapping("write")
	public String write() throws Exception {
		return "Board/writeBoard";
	}

	// 게시물 등록
	@RequestMapping("writeProc")
	public String writeProc(BoardDTO dto, MultipartFile[] files) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		// 게시물 등록
		int parentSeq = bserv.write(dto);
		// 파일 등록
		String realPath = session.getServletContext().getRealPath("/uploads");
		fserv.upload(parentSeq, realPath, files);
		return "redirect:/board/list";
	}
	
}
