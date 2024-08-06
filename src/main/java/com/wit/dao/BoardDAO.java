package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.wit.dto.BoardDTO;
import com.wit.dto.EmployeeDTO;

@Repository
public class BoardDAO {
	@Autowired
	private SqlSession mybatis;

	// 게시물 등록
	public int write(BoardDTO dto) {
		mybatis.insert("board.write", dto);
		return dto.getBoard_seq();
	}

	// 게시물 조회
	public List<BoardDTO> list() {
		return mybatis.selectList("board.list");
	}

	// 게시물 상세 조회
	public BoardDTO detailBoard(int board_seq) {
		return mybatis.selectOne("board.detailBoard", board_seq);
	}

	// 게시물 삭제
	public void deleteBoard(int board_seq) {
		mybatis.delete("board.delete", board_seq);
	}

	// 조회수
	public int viewcount(int board_seq) {
		return mybatis.update("board.viewcount", board_seq);
	}

	// 닉네임 조회
	public String selectNickname(String emp_no) {
		return mybatis.selectOne("board.selectNickname", emp_no);
	}

	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String emp_no) {
		return mybatis.selectOne("board.employeeInfo", emp_no);
	}
}
