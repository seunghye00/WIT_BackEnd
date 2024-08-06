package com.wit.dao;

import java.io.File;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.wit.dto.BoardFilesDTO;

@Repository
public class BoardFilesDAO {

	@Autowired
	private SqlSession mybatis;

	// 파일 등록
	public int upload(BoardFilesDTO dto) throws Exception {
		return mybatis.insert("file.upload", dto);
	}

	// 게시물에 첨부된 파일 조회
	public List<BoardFilesDTO> detailFile(int board_seq) throws Exception {
		return mybatis.selectList("file.detailFile", board_seq);
	}

	// 파일 정보 삭제
	public void deleteFile(int board_seq) throws Exception {
		// 파일 삭제를 위한 파일 조회
		List<String> fileNames = mybatis.selectList("file.selectFile", board_seq);

		mybatis.delete("file.deleteFile", board_seq);

		// 실제 파일 삭제
		for (String fileName : fileNames) {
			File file = new File("/uploads/" + fileName);
			if (file.exists()) {
				file.delete();
			}
		}
	}
}
