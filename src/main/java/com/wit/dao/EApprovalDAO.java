package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.DocuListDTO;
import com.wit.dto.LatenessDTO;
import com.wit.dto.LeaveRequestDTO;
import com.wit.dto.ApprLineDTO;
import com.wit.dto.DocuDTO;
import com.wit.dto.DocuInfoListDTO;
import com.wit.dto.WorkPropDTO;

@Repository
public class EApprovalDAO {

	@Autowired
	private SqlSession mybatis;

	// 문서 상태에 따라 해당 사원이 작성한 문서 목록을 5개까지 받아오기 위한 메서드
	public List<DocuInfoListDTO> selectByStatus(String status, String empNo) {
		// 두 개의 변수( 문서 상태 & 사번 )를 넘겨주기 위해 HashMap 생성
		Map<String, String> params = new HashMap<>();
		params.put("status", status);
		params.put("empNo", empNo);
		return mybatis.selectList("eApproval.selectByStatus", params);
	}

	// 문서 양식 목록을 받아오기 위한 메서드
	public List<DocuListDTO> getDocuList() {
		return mybatis.selectList("eApproval.getDocuList");
	}

	// 문서에 대한 데이터를 입력하고 SEQ 값을 받아오기 위한 메서드
	public int insertDocu(DocuDTO dto) {
		mybatis.insert("eApproval.insertDocu", dto);
		return dto.getDocument_seq();
	}

	// 문서에 대한 결재 라인을 입력하기 위한 메서드
	public void setApprLine(ApprLineDTO dto) {
		mybatis.insert("eApproval.setApprLine", dto);
	}

	// 문서에 대한 참조 라인을 입력하기 위한 메서드
	public void createRefeLine(int docuSeq, String empNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("empNo", empNo);
		mybatis.insert("eApproval.createRefeLine", params);
	}
	
	// 업무 기안 문서의 정보를 입력하기 위한 메서드
	public void insertPropDocu(WorkPropDTO dto) {
		mybatis.insert("eApproval.insertProp", dto);
	}

	// 지각 사유서 문서의 정보를 입력하기 위한 메서드
	public void insertLateDocu(LatenessDTO dto) {
		mybatis.insert("eApproval.insertLateness", dto);
	}

	// 휴가 신청서 문서의 정보를 입력하기 위한 메서드
	public void insertLeaveDocu(LeaveRequestDTO dto) {
		mybatis.insert("eApproval.insertLeave", dto);
	}
/*
	// 임시 저장 시 해당 문서의 정보를 업데이트하기 위한 메서드
	public void updateBySave(int docuSeq, String title, String emerYN) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("title", title);
		if (emerYN == null) {
			emerYN = "N";
		}
		params.put("emerYN", emerYN);
		mybatis.update("eApproval.updateBySave", params);
	}
*/
	
	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록을 조회하기 위한 메서드
	public List<DocuInfoListDTO> selectListByType(String empNo, String status, String docuCode) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("status", status);
		params.put("docuCode", docuCode);
		return mybatis.selectList("eApproval.selectListByType", params);
	}

	// 해당 사원이 기안한 문서 목록을 조회하기 위한 메서드
	public List<DocuInfoListDTO> selectWriteList(String empNo, String docuCode) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectList("eApproval.selectWriteList", params);
	}

	// 해당 사원이 임시 저장한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectSaveList(String empNo, String docuCode) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectList("eApproval.selectSaveList", params);
	}

	// 해당 사원이 결재한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectApprovedList(String empNo, String docuCode) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectList("eApproval.selectApprovedList", params);
	}

	// 해당 사원이 반려한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectReturnList(String empNo, String docuCode) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectList("eApproval.selectReturnList", params);
	}

	// 해당 사원이 참조자인 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectViewList(String empNo, String docuCode) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectList("eApproval.selectViewList", params);
	}

}
