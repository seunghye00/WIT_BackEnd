package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.wit.dto.DocuListDTO;
import com.wit.dto.LatenessDTO;
import com.wit.dto.LeaveRequestDTO;
import com.wit.dto.RefeLineDTO;
import com.wit.commons.BoardConfig;
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

	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록의 총 갯수를 조회하기 위한 메서드
	public int getCountListByType(String empNo, String status, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("status", status);
		params.put("docuCode", docuCode);
		return mybatis.selectOne("eApproval.getCountListByType", params);
	}

	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록을 조회하기 위한 메서드
	public List<DocuInfoListDTO> selectListByType(String empNo, String status, String docuCode, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("status", status);
		params.put("docuCode", docuCode);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.selectListByType", params);
	}

	// 해당 사원이 기안한 문서 목록 총 갯수 조회하기 위한 메서드
	public int getCountWriteList(String empNo, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectOne("eApproval.getCountWriteList", params);
	}

	// 해당 사원이 기안한 문서 목록을 조회하기 위한 메서드
	public List<DocuInfoListDTO> selectWriteList(String empNo, String docuCode, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.selectWriteList", params);
	}

	// 해당 사원이 임시 저장한 문서 목록 총 갯수를 넘겨주기 위한 메서드
	public int getCountSaveList(String empNo, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectOne("eApproval.getCountSaveList", params);
	}

	// 해당 사원이 임시 저장한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectSaveList(String empNo, String docuCode, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.selectSaveList", params);
	}

	// 해당 사원이 결재한 문서 목록 총 갯수를 넘겨주기 위한 메서드
	public int getCountApprovedList(String empNo, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectOne("eApproval.getCountApprovedList", params);
	}

	// 해당 사원이 결재한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectApprovedList(String empNo, String docuCode, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.selectApprovedList", params);
	}

	// 해당 사원이 반려한 문서 목록 총 갯수를 넘겨주기 위한 메서드
	public int getCountReturnList(String empNo, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectOne("eApproval.getCountReturnList", params);
	}

	// 해당 사원이 반려한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectReturnList(String empNo, String docuCode, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.selectReturnList", params);
	}

	// 해당 사원이 참조자인 문서 목록 총 갯수를 넘겨주기 위한 메서드
	public int getCountViewList(String empNo, String docuCode) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		return mybatis.selectOne("eApproval.getCountViewList", params);
	}

	// 해당 사원이 참조자인 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectViewList(String empNo, String docuCode, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.selectViewList", params);
	}

	// 해당 문서의 정보를 넘겨주기 위한 메서드
	public DocuDTO getDocuInfo(int docuSeq) {
		return mybatis.selectOne("eApproval.selectByDocuSeq", docuSeq);
	}

	// 해당 업무 기안 문서의 세부 정보를 넘겨주기 위한 메서드
	public WorkPropDTO getPropDetail(int docuSeq) {
		return mybatis.selectOne("eApproval.selectPropByDocuSeq", docuSeq);
	}

	// 해당 휴가 신청서 문서의 세부 정보를 넘겨주기 위한 메서드
	public LeaveRequestDTO getLeaveDetail(int docuSeq) {
		return mybatis.selectOne("eApproval.selectLeaveByDocuSeq", docuSeq);
	}

	// 해당 지각 사유서 문서의 세부 정보를 넘겨주기 위한 메서드
	public LatenessDTO getLatenessDetail(int docuSeq) {
		return mybatis.selectOne("eApproval.selecLatenesstByDocuSeq", docuSeq);
	}

	// 해당 문서의 결재 라인 정보를 넘겨주기 위한 메서드
	public List<ApprLineDTO> getApprLine(int docuSeq) {
		return mybatis.selectList("eApproval.selectApprByDocuSeq", docuSeq);
	}

	// 해당 문서의 참조 라인 정보를 넘겨주기 위한 메서드
	public List<RefeLineDTO> getRefeLine(int docuSeq) {
		return mybatis.selectList("eApproval.selectRefeByDocuSeq", docuSeq);
	}

	// 해당 문서를 삭제하기 위한 메서드
	public void delDocu(int docuSeq) {
		mybatis.delete("eApproval.deleteByDocuSeq", docuSeq);
	}

	// 해당 문서의 정보를 업데이트 하기 위한 메서드
	public int updateDocu(DocuDTO dto) {
		return mybatis.update("eApproval.updateByDocuSeq", dto);
	}

	// 지각 사유서 문서의 정보를 업데이트 하기 위한 메서드
	public void updateLatenessDocu(LatenessDTO dto) {
		mybatis.update("eApproval.updateLatenessByDocuSeq", dto);
	}

	// 휴가 신청서 문서의 정보를 업데이트 하기 위한 메서드
	public void updateLeaveDocu(LeaveRequestDTO dto) {
		mybatis.update("eApproval.updateLeaveByDocuSeq", dto);
	}

	// 업무 기안 문서의 정보를 업데이트 하기 위한 메서드
	public void updatePropDocu(WorkPropDTO dto) {
		mybatis.update("eApproval.updatePropByDocuSeq", dto);
	}

	// 해당 문서의 결재 라인 상태를 전부 변경하기 위한 메서드
	public void updateApprLineAll(int docuSeq, int i) {
		Map<String, Integer> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("order", i);
		mybatis.update("eApproval.updateApprLineAll", params);
	}

	// 해당 문서에 대한 코멘트를 입력하기 위한 메서드
	public void inserComments(ApprLineDTO dto) {
		mybatis.update("eApproval.insertComments", dto);
	}

	// 해당 문서 상태를 업데이트하기 위한 메서드
	public void updateDocuStatus(int docuSeq, String status) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("status", status);
		mybatis.update("eApproval.updateDocuStatus", params);
	}

	// 해당 문서의 결재 라인 상태를 변경하기 위한 메서드
	public void updateApprLine(int docuSeq, int i, String status) {
		Map<String, Object> params = new HashMap<>();
		params.put("docuSeq", docuSeq);
		params.put("order", i);
		params.put("status", status);
		mybatis.update("eApproval.updateApprLine", params);
	}

	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록의 총 갯수를 검색 후 조회하기 위한 메서드
	public int getCountSearchListByType(String empNo, String status, String docuCode, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("status", status);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		return mybatis.selectOne("eApproval.getCountSearchListByType", params);
	}

	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록을 검색 후 조회하기 위한 메서드
	public List<DocuInfoListDTO> searchListByType(String empNo, String status, String docuCode, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("status", status);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.searchListByType", params);
	}

	// 해당 사원이 기안한 문서 목록 총 갯수 검색 후 조회하기 위한 메서드
	public int getCountSearchWriteList(String empNo, String docuCode, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		return mybatis.selectOne("eApproval.getCountSearchWriteList", params);
	}

	// 해당 사원이 기안한 문서 목록을 검색 후 조회하기 위한 메서드
	public List<DocuInfoListDTO> searchWriteList(String empNo, String docuCode, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.searchWriteList", params);
	}

	// 해당 사원이 임시 저장한 문서 목록 총 갯수를 검색 후 넘겨주기 위한 메서드
	public int getCountSearchSaveList(String empNo, String docuCode, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		return mybatis.selectOne("eApproval.getCountSearchSaveList", params);
	}

	// 해당 사원이 임시 저장한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchSaveList(String empNo, String docuCode, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.searchSaveList", params);
	}

	// 해당 사원이 결재한 문서 목록 총 갯수를 검색 후 넘겨주기 위한 메서드
	public int getCountSearchApprovedList(String empNo, String docuCode, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		return mybatis.selectOne("eApproval.getCountSearchApprovedList", params);
	}

	// 해당 사원이 결재한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchApprovedList(String empNo, String docuCode, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.searchApprovedList", params);
	}

	// 해당 사원이 반려한 문서 목록 총 갯수를 검색 후 넘겨주기 위한 메서드
	public int getCountSearchReturnList(String empNo, String docuCode, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		return mybatis.selectOne("eApproval.getCountSearchReturnList", params);
	}

	// 해당 사원이 반려한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchReturnList(String empNo, String docuCode, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.searchReturnList", params);
	}

	// 해당 사원이 참조자인 문서 목록 총 갯수를 검색 후 넘겨주기 위한 메서드
	public int getCountSearchViewList(String empNo, String docuCode, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		return mybatis.selectOne("eApproval.getCountSearchViewList", params);
	}

	// 해당 사원이 참조자인 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchViewList(String empNo, String docuCode, String keyword, int cPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuCode", docuCode);
		params.put("keyword", keyword);
		params.put("cPage", cPage);
		params.put("recordCountPerPage", BoardConfig.recordCountPerPage);
		return mybatis.selectList("eApproval.searchViewList", params);
	}

	// 해당 문서의 참조자인 해당 사원의 읽음 여부와 읽은 시간을 업데이트 하기 위한 메서드
	public void updateReadYN(int docuSeq, String empNo, String readYN) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("docuSeq", docuSeq);
		params.put("readYN", readYN);
		mybatis.update("eApproval.updateReadYN", params);
	}

	// 관리자가 결재 대기 or 결재 예정인 목록을 5개까지만 조회하기 위한 메서드
	public List<DocuInfoListDTO> selectApprList(String empNo, String status) {
		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("status", status);
		return mybatis.selectList("eApproval.selectApprList", params);
	}
}
