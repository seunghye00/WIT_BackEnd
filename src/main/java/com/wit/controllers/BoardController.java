package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.wit.dto.BoardDTO;
import com.wit.services.BoardService;
import com.wit.services.FileService;

@Controller
@RequestMapping("/board/")
public class BoardController {
	@Autowired
	private HttpSession session;

	@Autowired
	private BoardService bserv;

	@Autowired
	private FileService fserv;

	@RequestMapping("list")
	public String list() throws Exception {
		return "Board/board";
	}

	@RequestMapping("write")
	public String write() throws Exception {

		return "Board/writeBoard";
	}

	@RequestMapping("writeProc")
	public String write(BoardDTO dto, MultipartFile[] files) throws Exception {
		String emp_no = (String) session.getAttribute("loginID");
		String realpath = session.getServletContext().getRealPath("/upload");
		dto.setEmp_no(emp_no);
		fserv.upload(dto, realpath, files);
		return "redirect:/board/list";
	}

}