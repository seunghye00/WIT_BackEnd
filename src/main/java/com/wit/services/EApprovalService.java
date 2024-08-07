package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.EApprovalDAO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.DocuInfoListDTO;
import com.wit.dto.workPropDTO;

@Service
public class EApprovalService {

	@Autowired
	private EApprovalDAO dao;
	
	// 문서 상태에 따라 해당 사원이 작성한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectByStatus(String status, String empNo) {
		return dao.selectByStatus(status, empNo);
	}
	
	// 문서 양식 목록을 넘겨주기 위한 메서드 
	public List<DocuListDTO> getDocuList() {
		return dao.getDocuList();
	}

	// 문서 작성 전 임시데이터 삽입과 함께 SEQ를 먼저 받아오기 위한 메서드 
	public int insert(String empNo, String docuCode) {
		return dao.insert(empNo, docuCode);
	}

	// 결재 라인에 대한 정보를 문서 작성 전 미리 저장하기 위한 메서드
	public void createApprLine(int docuSeq, String empNo, int i) {
		dao.createApprLine(docuSeq, empNo, i);
	}

	// 참조 라인에 대한 정보를 문서 작성 전 미리 저장하기 위한 메서드
	public void createRefeLine(int docuSeq, String empNo) {
		dao.createRefeLine(docuSeq, empNo);
	}

	// 문서 임시 저장 시 해당 문서의 정보를 업데이트하기 위한 메서드
	public void updateBySave(int docuSeq, String title, String emerYN) {
		dao.updateBySave(docuSeq, title, emerYN);
	}

	// 업무 기안 문서 임시 저장 시 데이터를 입력하기 위한 메서드 
	public void insertPropDocu(workPropDTO workPropDTO) {
		dao.insertPropDocu(workPropDTO);
	}
	
	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectListByType(String empNo, String status) {
		return dao.selectListByType(empNo, status);
	}
	
	// 해당 사원이 기안한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectWriteList(String empNo) {
		return dao.selectWriteList(empNo);
	}

	// 해당 사원이 임시 저장한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selecSavetList(String empNo) {
		return dao.selectSaveList(empNo);
	}
	
	// 해당 사원이 결재한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectApprovedList(String empNo) {
		return dao.selectApprovedList(empNo);
	}

	// 해당 사원이 반려한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectReturnList(String empNo) {
		return dao.selectReturnList(empNo);
	}

	// 해당 사원이 참조자인 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectViewList(String empNo) {
		return dao.selectViewList(empNo);
	}
}
