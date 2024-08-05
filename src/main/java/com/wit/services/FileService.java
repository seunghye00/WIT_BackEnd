package com.wit.services;

import java.io.File;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.wit.dao.BoardFilesDAO;
import com.wit.dto.BoardFilesDTO;

@Service
public class FileService {
	@Autowired
	private BoardFilesDAO bdao;

	// 파일 등록
	@Transactional
	public void upload(int parentSeq, String realPath, MultipartFile[] files) throws Exception {
		File realPathFile = new File(realPath);
		if (!realPathFile.exists()) {
			realPathFile.mkdirs();
		}

		for (MultipartFile file : files) {
			if (file.getSize() == 0) {
				continue;
			}
			String oriName = file.getOriginalFilename();
			String sysName = UUID.randomUUID() + "_" + oriName;
			file.transferTo(new File(realPath + "/" + sysName));
			bdao.upload(new BoardFilesDTO(0, parentSeq, oriName, sysName));
		}
	}

	// 게시물에 첨부된 파일 목록 조회
	public List<BoardFilesDTO> detailFile(int board_seq) throws Exception {
		return bdao.detailFile(board_seq);
	}
}
