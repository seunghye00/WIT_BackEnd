package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.NoticeDTO;

@Repository
public class NoticeDAO {
	@Autowired
	private SqlSession mybatis;
	
	public List<NoticeDTO> noticeList() throws Exception{
		return mybatis.selectList("notice.noticeList");
	}
	
	public NoticeDTO detailPage(int seq) throws Exception{
		return mybatis.selectOne("notice.detailPage",seq);
	}
	
	public List<NoticeDTO> search(String searchNotice, String keyword, String sortOpt) throws Exception{
		// params 라는 이름의 새로운 HashMap 인스턴스 생성
		Map<String, String> params = new HashMap<>();
		params.put("searchNotice", searchNotice);
		params.put("keyword", keyword);
		params.put("sortOpt",sortOpt);
		
		List<NoticeDTO> list = mybatis.selectList("notice.search",params);
		
		for(NoticeDTO dto : list) {
			System.out.println(dto.getNotice_seq() + ":" + dto.getTitle() + ":" +dto.getContents() + ":" + dto.getEmp_no() + ":" + dto.getWrite_date() + ":" +dto.getViews());
		}
		return list;
	}
}
