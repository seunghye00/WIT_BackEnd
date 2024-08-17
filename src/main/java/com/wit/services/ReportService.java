package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.ReportDAO;
import com.wit.dto.ReportDTO;

@Service
public class ReportService {
	@Autowired
	private ReportDAO dao;
	
	public void insert(ReportDTO dto, String target) throws Exception{
		if(target.equals("1")) {
			dto.setReport_type("욕설 및 비방");
		} else if(target.equals("2")) {
			dto.setReport_type("스팸 및 광고");
		} else if(target.equals("3")) {
			dto.setReport_type("음란물 및 부적절한 콘텐츠");
		}
		
		dao.insert(dto);
	}
	
	public String check(String empNo, int boardSeq) throws Exception{
		int result = dao.check(empNo, boardSeq);
		if(result > 0) {
			return "false";
		} else {
			
			return "true";
		}
	}
}
