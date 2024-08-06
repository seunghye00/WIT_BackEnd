package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.wit.dto.DocuListDTO;
import com.wit.dto.RecentDocuListDTO;
import com.wit.dto.workPropDTO;

@Repository
public class EApprovalDAO {
	
	@Autowired
	private SqlSession mybatis;

	// 문서 상태에 따라 해당 사원이 작성한 문서 목록을 5개까지 받아오기 위한 메서드
	public List<RecentDocuListDTO> selectByStatus(String status, String emp_no) {
		// 두 개의 변수( 문서 상태 & 사번 )를 넘겨주기 위해 HashMap 생성
		Map<String, String> params = new HashMap<>();
		params.put("status", status);
		params.put("emp_no", emp_no);
		return mybatis.selectList("eApproval.selectByStatus", params);
	}

	// 문서 양식 목록을 받아오기 위한 메서드
	public List<DocuListDTO> getDocuList() {
		return mybatis.selectList("eApproval.getDocuList");
	}

	// 문서에 대한 임시 데이터를 입력하고 SEQ 값을 받아오기 위한 메서드
	public int insert(String emp_no, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuCode", docuCode);
		params.put("emp_no", emp_no);
		mybatis.insert("eApproval.insertDocu", params);
		return (int) params.get("seq");
	}

	// 문서에 대한 결재 라인을 입력하기 위한 메서드
	public void createApprLine(int docuSeq, String emp_no, int i) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("emp_no", emp_no);
		params.put("index", i);
		mybatis.insert("eApproval.createApprLine", params);
	}

	// 문서에 대한 참조 라인을 입력하기 위한 메서드
	public void createRefeLine(int docuSeq, String emp_no) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("emp_no", emp_no);
		mybatis.insert("eApproval.createRefeLine", params);
	}
	
	// 임시 저장 시 해당 문서의 정보를 업데이트하기 위한 메서드
	public void updateBySave(int document_seq, String title, String emer_yn) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", document_seq);
		params.put("title", title);
		if(emer_yn == null) {
			emer_yn = "N";
		}
		params.put("emer_yn", emer_yn);
		mybatis.update("eApproval.updateBySave", params);
	}

	// 업무 기안 문서 임시 저장 시 해당 문서의 정보를 입력하기 위한 메서드
	public void insertPropDocu(workPropDTO workPropDTO) {
		mybatis.insert("eApproval.insertProp", workPropDTO);
	}
}
