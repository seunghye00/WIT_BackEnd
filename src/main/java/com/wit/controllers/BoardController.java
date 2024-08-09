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
import com.wit.dto.ReplyDTO;
import com.wit.services.BoardService;
import com.wit.services.BookMarkService;
import com.wit.services.FileService;
import com.wit.services.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private HttpSession session;

	@Autowired
	private BoardService bserv;

	@Autowired
	private FileService fserv;
	
	@Autowired
	private BookMarkService bmserv; 

	@Autowired
	private ReplyService rs;
	
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

	// 글 작성으로 이동
	@RequestMapping("write")
	public String write(Model model) throws Exception {
		String empNo = (String) session.getAttribute("loginID");

		EmployeeDTO employee = bserv.employeeInfo(empNo);

		model.addAttribute("employee", employee);

		return "Board/writeBoard";
	}

	// 게시물 등록
	@RequestMapping("writeProc")
	public String writeProc(BoardDTO dto, MultipartFile[] files) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		
		// 파일 등록
		String realPath = session.getServletContext().getRealPath("/uploads");
		fserv.upload(dto,realPath, files);
		return "redirect:/board/list";
	}

	// 게시물 상세 조회
	@RequestMapping("detail")
	public String detail(int board_seq, HttpSession session, Model model) throws Exception {

		BoardDTO board = bserv.detailBoard(board_seq);
		List<BoardFilesDTO> files = fserv.detailFile(board_seq);
		
		// emp_no 닉네임으로 뽑기
		String empNo = (String) session.getAttribute("loginID");
		String Nickname = bserv.selectNickname(empNo);
		
		EmployeeDTO employee = bserv.employeeInfo(empNo);
		
		// 댓글 리스트 
		List<ReplyDTO> replyList = rs.replyList(board_seq);
		
		model.addAttribute("board", board);
		model.addAttribute("files", files);
		model.addAttribute("empNo", empNo);
		model.addAttribute("Nickname", Nickname);
		model.addAttribute("employee", employee);
		// 여기에다 북마크로 쿼리문을 보내서 사원번호랑, 보드 시퀀스 맞는 항목이 있으면 true,false 해서
		// model 에 추가
		model.addAttribute("bookmark",bmserv.isBookmarked(board_seq, empNo));
		
		// 댓글 리스트 model에 추가
		model.addAttribute("replyList",replyList);
		
		return "Board/detailBoard";
	}

	// 게시물 삭제
	@RequestMapping("/delete")
	public String delete(int board_seq) throws Exception {
		// 게시물과 첨부 파일 삭제
		bserv.delete(board_seq);
		return "redirect:/board/list";
	}
	
	// 게시물 수정
	@RequestMapping("/update")
	public String update(BoardDTO dto, MultipartFile[] files) throws Exception{
		// 파일 수정
		String realPath = session.getServletContext().getRealPath("/uploads");
		bserv.update(dto, files, realPath);
		
		return "redirect:/board/detail?board_seq="+ dto.getBoard_seq();
	}
	
	
	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String execptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}

}
