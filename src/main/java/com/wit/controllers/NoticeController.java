package com.wit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.dto.NoticeDTO;
import com.wit.services.NoticeService;

@Controller
@RequestMapping("/notice/")
public class NoticeController {

	@Autowired
	private HttpSession session;

	@Autowired
	private NoticeService nserv;

	@GetMapping("notice")
	public String notice(Model model) throws Exception {
		List<NoticeDTO> list = nserv.noticeList();
		model.addAttribute("list", list);
		System.out.println("컨트롤러" + list);
		return "Notice/notice";
	}

	@RequestMapping("detailNotice")
	public String detail(int seq, Model model) throws Exception {
		NoticeDTO dto = nserv.detail(seq);
		model.addAttribute("dto", dto);
		return "Notice/detailNotice";
	}

	@RequestMapping("search")
	public String search(String searchNotice, String keyword, String sortOpt, Model model) throws Exception {
		List<NoticeDTO> list = nserv.search(searchNotice, keyword, sortOpt);
		model.addAttribute("list", list);
		model.addAttribute("searchNotice", searchNotice);
		model.addAttribute("keyword", keyword);
		model.addAttribute("sortOpt", sortOpt);
		return "/Notice/notice";
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}

}
