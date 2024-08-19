package com.wit.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.ReportDTO;

@Repository
public class ReportDAO {
	
	@Autowired
	private SqlSession mybatis;
	
	public void insert(ReportDTO dto) throws Exception{
		mybatis.insert("report.insert",dto);
	}
	
	public int check(String empNo, int boardSeq) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("boardSeq", boardSeq);
		
		return mybatis.selectOne("report.check",map);
	}
}
