package com.wit.dao;

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
}
