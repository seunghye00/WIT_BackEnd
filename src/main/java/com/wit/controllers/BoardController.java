package com.wit.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.wit.commons.BoardConfig;
import com.wit.dto.BoardDTO;
import com.wit.dto.BoardFilesDTO;
import com.wit.dto.BoardReportDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.ReplyDTO;
import com.wit.services.BoardService;
import com.wit.services.BookMarkService;
import com.wit.services.FileService;
import com.wit.services.ReplyService;

import oracle.sql.TIMESTAMP;

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
	
	// RequestBody는 객체 받을 때 쓰는 거고 
	// RequesetParam(defaultValue = ""):값이 없을 때 기본값 설정.
	@RequestMapping("/list")
	public String list(Model model,@RequestParam(defaultValue = "") String searchTarget,
			@RequestParam(defaultValue = "") String sortTarget,
			@RequestParam(defaultValue = "") String searchTxt,
			@RequestParam(defaultValue = "1") int cpage,
			@RequestParam(defaultValue = "false") String bookmark,
			@RequestParam(defaultValue = "1") int boardCode,
			@RequestParam(defaultValue = "false") String report,
			@RequestParam(defaultValue = "false") String adminReport) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		List<BoardReportDTO> boardList = bserv.list(searchTxt, searchTarget, sortTarget, cpage,empNo,bookmark,boardCode,report,adminReport);

		EmployeeDTO employee = bserv.employeeInfo(empNo);
		model.addAttribute("board_code",boardCode);
		model.addAttribute("report",report);
		model.addAttribute("searchTarget",searchTarget);
		model.addAttribute("sortTarget",sortTarget);
		model.addAttribute("searchTxt",searchTxt);
		model.addAttribute("bookmark",bookmark); 
		model.addAttribute("adminReport",adminReport); 
		model.addAttribute("cpage",cpage);
		model.addAttribute("list", boardList);
		model.addAttribute("employee", employee);
		
		// 검색포함 전체 게시글 개수
		model.addAttribute("record_total_count",bserv.boardCount(searchTxt, searchTarget, empNo,bookmark,boardCode,report,adminReport) );
		// 한 페이지에 보여줄 게시글 개수
		model.addAttribute("record_count_per_page",BoardConfig.recordCountPerPage);
		// navi 개수
		model.addAttribute("navi_count_per_page",BoardConfig.naviCountPerPage);
		return "Board/board";
	}

	// 글 작성으로 이동
	@RequestMapping("write")
	public String write(Model model,@RequestParam(defaultValue = "1") int boardCode) throws Exception {
		String empNo = (String) session.getAttribute("loginID");

		EmployeeDTO employee = bserv.employeeInfo(empNo);

		model.addAttribute("employee", employee);
		// 처음 작성할 때는 파일 사이즈가 0으로 설정
		model.addAttribute("filesSize", 0);
		model.addAttribute("board_code",boardCode);

		return "Board/writeBoard";
	}
	
	// 신고 모달창
	@RequestMapping(value = "/reportList", produces = "application/json; charset=UTF-8")
	@ResponseBody 
	public Map<String, Object> reportList(Model model, @RequestParam(defaultValue = "0") int board_seq) throws Exception{
		// 신고된 게시물 목록 조회
		System.out.println(board_seq);
		List<Map<String, Object>> reportList = bserv.reportList(board_seq);
		 
		// 날짜 형식을 지정
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        for (Map<String, Object> item : reportList) {
			TIMESTAMP reportTimestamp = (TIMESTAMP) item.get("REPORT_DATE");

			if (reportTimestamp != null) {
				Timestamp ReportDate = reportTimestamp.timestampValue();
				item.put("REPORT_DATE", sdf.format(ReportDate));
			}
		}
        Map<String, Object> response = new HashMap<>();
        response.put("reportList", reportList);
		return response;
	}
	
	
	// 게시물 등록
	@RequestMapping("writeProc")
	public String writeProc(BoardDTO dto, MultipartFile[] files,@RequestParam(defaultValue = "1") int boardCode) throws Exception {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		dto.setBoard_code(boardCode);
		// 파일 등록
		String realPath = session.getServletContext().getRealPath("/uploads");
		fserv.upload(dto,realPath, files);
//		return "redirect:/board/list";
		
		// 게시판 코드에 따라 다른 페이지로 리다이렉트
		if(boardCode == 2) {
			return "redirect:/board/list?&boardCode="+boardCode;
		} else {
			return "redirect:/board/list";
		}
	}

	// 게시물 상세 조회
	@RequestMapping("detail")
	public String detail(int board_seq, Model model,
			@RequestParam(defaultValue = "1") int boardCode) throws Exception {

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
		model.addAttribute("filesSize", files.size());
		model.addAttribute("empNo", empNo);
		model.addAttribute("Nickname", Nickname);
		model.addAttribute("employee", employee);
		model.addAttribute("board_code",boardCode);
		// 여기에다 북마크로 쿼리문을 보내서 사원번호랑, 보드 시퀀스 맞는 항목이 있으면 true,false 해서
		// model 에 추가
		model.addAttribute("bookmark",bmserv.isBookmarked(board_seq, empNo));
		
		// 댓글 리스트 model에 추가
		model.addAttribute("replyList",replyList);
		
		return "Board/detailBoard";
	}

	// 게시물 삭제
	@RequestMapping("/delete")
	public String delete(int board_seq, int board_code) throws Exception {
		// 게시물과 첨부 파일 삭제
		bserv.delete(board_seq);
		return "redirect:/board/list?boardCode="+board_code;
	}
	
	// 게시물 삭제
		@RequestMapping("/deleteReport")
		public String deleteReport(int board_seq) throws Exception {
			// 게시물과 첨부 파일 삭제
			bserv.delete(board_seq);
			return "redirect:/board/list?adminReport=true";
		}

		
	// 게시물 클릭하면 조회수 올리는 것
	@RequestMapping("/views")
	@ResponseBody
	public String views(int board_seq) throws Exception{
		bserv.detailView(board_seq);
		return "";
	}
	// 게시물 수정
	@RequestMapping("/update")
	public String update(BoardDTO dto, MultipartFile[] files) throws Exception{
		// 파일 수정
        String realPath = "C:/Users/82104/Desktop/uploadFile/"; 
		bserv.update(dto, files, realPath);
		
		return "redirect:/board/detail?board_seq="+ dto.getBoard_seq();
	}
	
	@RequestMapping("/download")
	public void download(String oriName, String sysname, HttpServletResponse response) throws Exception{
		System.out.println(oriName+":"+sysname);
		String realPath = "C:/Users/Administrator/Desktop/UploadServerFile/"; 
		File target = new File(realPath + "/" + sysname);
		
		oriName = new String(oriName.getBytes(),"ISO-8859-1");
		response.setHeader("content-disposition","attachment;filename=\""+oriName+"\"");
		//
		try(DataInputStream dis = new DataInputStream(new FileInputStream(target));// 파일에서 내용 뽑아오기
				DataOutputStream dos = new DataOutputStream(response.getOutputStream());){ // 네트워크 방향으로 출력하기
			byte[] fileContents = new byte[(int)target.length()];
			dis.readFully(fileContents);
			dos.write(fileContents);
			dos.flush();
		}
	}
	
	
	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String execptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}

}
