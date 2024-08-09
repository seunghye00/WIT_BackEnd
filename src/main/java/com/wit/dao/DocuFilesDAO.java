package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.DocuFilesDTO;

@Repository
public class DocuFilesDAO {

	@Autowired
	private SqlSession mybatis;

	// 파일 등록
	public int upload(DocuFilesDTO dto) throws Exception {
		return mybatis.insert("docuFile.upload", dto);
	}

	// 게시물에 첨부된 파일 조회
	public List<DocuFilesDTO> getList(int docuSeq) throws Exception {
		return mybatis.selectList("docuFile.selectByDocuSeq", docuSeq);
	}
}
