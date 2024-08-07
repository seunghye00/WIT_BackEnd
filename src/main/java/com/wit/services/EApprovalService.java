package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.EApprovalDAO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.RecentDocuListDTO;
import com.wit.dto.workPropDTO;

@Service
public class EApprovalService {

	@Autowired
	private EApprovalDAO dao;
	
	// 문서 상태에 따라 해당 사원이 작성한 문서 목록을 넘겨주기 위한 메서드
	public List<RecentDocuListDTO> selectByStatus(String status, String emp_no) {
		return dao.selectByStatus(status, emp_no);
	}
	
	// 문서 양식 목록을 넘겨주기 위한 메서드 
	public List<DocuListDTO> getDocuList() {
		return dao.getDocuList();
	}

	// 문서 작성 전 임시데이터 삽입과 함께 SEQ를 먼저 받아오기 위한 메서드 
	public int insert(String emp_no, String docuCode) {
		return dao.insert(emp_no, docuCode);
	}

	// 결재 라인에 대한 정보를 문서 작성 전 미리 저장하기 위한 메서드
	public void createApprLine(int docuSeq, String emp_no, int i) {
		dao.createApprLine(docuSeq, emp_no, i);
	}

	// 참조 라인에 대한 정보를 문서 작성 전 미리 저장하기 위한 메서드
	public void createRefeLine(int docuSeq, String emp_no) {
		dao.createRefeLine(docuSeq, emp_no);
	}

	// 문서 임시 저장 시 해당 문서의 정보를 업데이트하기 위한 메서드
	public void updateBySave(int document_seq, String title, String emer_yn) {
		dao.updateBySave(document_seq, title, emer_yn);
	}

	// 업무 기안 문서 임시 저장 시 데이터를 입력하기 위한 메서드 
	public void insertPropDocu(workPropDTO workPropDTO) {
		dao.insertPropDocu(workPropDTO);
	}
}
