package com.wit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import com.wit.dto.BoardDTO;
import com.wit.dto.BoardFilesDTO;
import com.wit.dto.EmployeeDTO;
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
		String empNo = (String) session.getAttribute("loginID");
		List<BoardDTO> boardList = bserv.list();

		EmployeeDTO employee = bserv.employeeInfo(empNo);

		model.addAttribute("list", boardList);
		model.addAttribute("employee", employee);

		return "Board/board";
	}

	// 글작성
	@RequestMapping("write")
	public String write(Model model) throws Exception {
		String empNo = (String) session.getAttribute("loginID");

		EmployeeDTO employee = bserv.employeeInfo(empNo);

		model.addAttribute("employee", employee);

		return "Board/writeBoard";
	}

	// 게시물 상세 조회
	@RequestMapping("detail")
	public String detail(int board_seq, HttpSession session, Model model) throws Exception {

		BoardDTO board = bserv.detailBoard(board_seq);
		List<BoardFilesDTO> files = fserv.detailFile(board_seq);

		String empNo = (String) session.getAttribute("loginID");
		String Nickname = bserv.selectNickname(empNo);

		EmployeeDTO employee = bserv.employeeInfo(empNo);

		model.addAttribute("board", board);
		model.addAttribute("files", files);
		model.addAttribute("empNo", empNo);
		model.addAttribute("Nickname", Nickname);
		model.addAttribute("employee", employee);

		return "Board/detailBoard";
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

	// 게시물 삭제
	@RequestMapping("/delete")
	public String delete(int board_seq) throws Exception {
		// 게시물과 첨부 파일 삭제
		bserv.delete(board_seq);
		return "redirect:/board/list";
	}

	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String execptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}

}
