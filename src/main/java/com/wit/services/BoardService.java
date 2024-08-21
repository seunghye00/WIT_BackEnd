package com.wit.services;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.wit.commons.BoardConfig;
import com.wit.dao.BoardDAO;
import com.wit.dao.BoardFilesDAO;
import com.wit.dto.BoardDTO;
import com.wit.dto.BoardFilesDTO;
import com.wit.dto.BoardReportDTO;
import com.wit.dto.EmployeeDTO;

@Service
public class BoardService {

	@Autowired
	private BoardDAO bdao;

	@Autowired
	private BoardFilesDAO fdao;

	// 게시물 등록
	public int write(BoardDTO dto) {
		bdao.write(dto);
		return dto.getBoard_seq();
	}

	// 게시물 조회
	public List<BoardReportDTO> list(String searchTxt, String searchTarget, String sortTarget, int cpage, String emp_no,String bookmark,int board_code,String report,String adminReport) {
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("sortTarget", sortTarget); 
		maps.put("searchTarget", searchTarget);
		maps.put("searchTxt", searchTxt);
		maps.put("emp_no", emp_no);
		maps.put("bookmark", bookmark);
		maps.put("board_code", board_code);
		maps.put("report", report);
		maps.put("adminReport", adminReport);
		
		if(cpage==0) {
			maps.put("start", 1);
			maps.put("end", 5);
		}
		else {
			maps.put("start", cpage*BoardConfig.recordCountPerPage-(BoardConfig.recordCountPerPage-1));
			maps.put("end", cpage*BoardConfig.recordCountPerPage);
		}
		
		
		
		return bdao.list(maps);
	}
	// 게시글 개수
	public int boardCount(String searchTxt, String searchTarget, String emp_no,String bookmark,int board_code,String report,String adminReport) {
		Map<String, Object> maps = new HashMap<String, Object>();
	 
		maps.put("bookmark", bookmark);
		maps.put("searchTarget", searchTarget);
		maps.put("searchTxt", searchTxt);
		maps.put("emp_no", emp_no);
		maps.put("board_code", board_code);
		maps.put("report", report);
		maps.put("adminReport", adminReport);
		return bdao.boardCount(maps);
	}

	// 게시물 수정
	@Transactional
	public void update(BoardDTO dto, MultipartFile[] files, String realPath) throws Exception {
		// 1. 게시글 작성
		// 2. 작성된 게시글의 시퀀스번호 가져오기
		// 3. 시퀀스번호 가지고 파일 업로드
		bdao.update(dto);
		
		File realPathFile = new File(realPath);
		if (!realPathFile.exists()) {
			realPathFile.mkdir();
		}

		for (MultipartFile file : files) {
			if (file.getSize() == 0) {
				continue;
			}
			String oriName = file.getOriginalFilename(); // 내 원래 파일
			String sysName = UUID.randomUUID() + "_" + oriName; // 서버 세션에 저장하기 위해 같은 이름인 파일을 구분짓기 위해서 서버에 올라간 파일
			file.transferTo(new File(realPath + "/" + sysName));
			
			fdao.upload(new BoardFilesDTO(0, dto.getBoard_seq(), oriName, sysName));
		}
		
	}
	// 게시물 상세 조회
	public BoardDTO detailBoard(int board_seq) throws Exception {
		return bdao.detailBoard(board_seq);
	}
	// 게시물 조회수 
	public void detailView(int board_seq) throws Exception{
		bdao.viewcount(board_seq);
	}
	// 닉네임 조회(자유게시판 JSTL)
	public String selectNickname(String emp_no) throws Exception {
		return bdao.selectNickname(emp_no);
	}

	// 게시물 삭제
	@Transactional
	// 어노테이션이 왜 여기있는지는 알거라고 믿어 밍쥬
	// 주석 안달게 일부로 ^^?
	public void delete(int board_seq) throws Exception {
		// 첨부 파일 삭제
		fdao.deleteFile(board_seq);

		// 게시물 삭제
		bdao.deleteBoard(board_seq);
	}
	
	// 신고 목록 조회 메서드 
//	public List<BoardReportDTO> getReportedPosts() throws Exception{
//		return bdao.getReportedPosts();
//	}
	
	// 신고 내역 리스트 조회
	public List<BoardReportDTO> reportList(int board_seq) throws Exception{
		return bdao.reportList(board_seq);
	}
	
	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String emp_no) {
		return bdao.employeeInfo(emp_no);
	}
}

