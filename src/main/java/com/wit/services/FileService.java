package com.wit.services;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.wit.dao.BoardDAO;
import com.wit.dao.BoardFilesDAO;
import com.wit.dto.BoardDTO;
import com.wit.dto.BoardFilesDTO;

@Service
public class FileService {
	@Autowired
	private BoardFilesDAO fdao;

	@Autowired
	private BoardDAO bdao;

	@Transactional
	public void upload(BoardDTO dto, String realPath, MultipartFile[] files) throws Exception {
		File realPathFile = new File(realPath);
		if (!realPathFile.exists()) {
			realPathFile.mkdir();
		}

		int parent_seq = bdao.write(dto);

		for (MultipartFile file : files) {

			if (file.getSize() == 0) {
				continue;
			}
			String oriName = file.getOriginalFilename(); // 내 원래 파일
			String sysName = UUID.randomUUID() + "_" + oriName; // 서버 세션에 저장하기 위해 같은 이름인 파일을 구분짓기 위해서 서버에 올라간 파일
			file.transferTo(new File(realPath + "/" + sysName));
			fdao.insert(new BoardFilesDTO(0, parent_seq, oriName, sysName));
		}
	}

}