package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.dao.BoardDAO;
import com.wit.dao.BoardFilesDAO;
import com.wit.dto.BoardDTO;
import com.wit.dto.EmployeeDTO;

@Service
public class BoardService {

	@Autowired
	private BoardDAO bdao;

	@Autowired
	private BoardFilesDAO bfdao;

	// 게시물 등록
	public int write(BoardDTO dto) {
		bdao.write(dto);
		return dto.getBoard_seq();
	}

	// 게시물 조회
	public List<BoardDTO> list() {
		return bdao.list();
	}

	// 게시물 상세 조회
	public BoardDTO detailBoard(int board_seq) throws Exception {
		bdao.viewcount(board_seq);
		return bdao.detailBoard(board_seq);
	}

	// 게시물 삭제
	@Transactional
	public void delete(int board_seq) throws Exception {
		// 첨부 파일 삭제
		bfdao.deleteFile(board_seq);

		// 게시물 삭제
		bdao.deleteBoard(board_seq);
	}

	// 닉네임 조회
	public String selectNickname(String emp_no) throws Exception {
		return bdao.selectNickname(emp_no);
	}

	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String emp_no) {
		return bdao.employeeInfo(emp_no);
	}
}
