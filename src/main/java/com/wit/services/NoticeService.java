package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.NoticeDAO;
import com.wit.dto.NoticeDTO;

@Service
public class NoticeService {
	@Autowired
	private NoticeDAO ndao;
	
	public List<NoticeDTO> noticeList() throws Exception{
		return ndao.noticeList();
	}
}
