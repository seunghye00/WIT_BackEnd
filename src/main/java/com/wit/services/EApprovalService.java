package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.EApprovalDAO;
import com.wit.dao.EmployeeDAO;
import com.wit.dto.ApprLineDTO;
import com.wit.dto.DocuDTO;
import com.wit.dto.DocuInfoListDTO;
import com.wit.dto.DocuListDTO;
import com.wit.dto.LatenessDTO;
import com.wit.dto.LeaveRequestDTO;
import com.wit.dto.RefeLineDTO;
import com.wit.dto.WorkPropDTO;

@Service
public class EApprovalService {

	@Autowired
	private EApprovalDAO dao;

	@Autowired
	private EmployeeDAO eDao;

	// 문서 상태에 따라 해당 사원이 작성한 문서 목록을 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> selectByStatus(String status, String empNo) {
		return dao.selectByStatus(status, empNo);
	}

	// 문서 양식 목록을 넘겨주기 위한 메서드
	public List<DocuListDTO> getDocuList() {
		return dao.getDocuList();
	}

	// 해당 사원이 결재 문서를 작성 완료 or 임시 저장 했을 때 데이터를 입력 후 SEQ 값을 받아오기 위한 메서드
	public int insertDocu(DocuDTO dto) {
		return dao.insertDocu(dto);
	}

	// 결재 라인에 대한 정보를 저장하기 위한 메서드
	public void setApprLine(ApprLineDTO dto) {
		dao.setApprLine(dto);
	}

	// 참조 라인에 대한 정보를 저장하기 위한 메서드
	public void createRefeLine(int docuSeq, String empNo) {
		dao.createRefeLine(docuSeq, empNo);
	}

	// 업무 기안 문서에 대한 데이터를 입력하기 위한 메서드
	public void insertPropDocu(WorkPropDTO dto) {
		dao.insertPropDocu(dto);
	}

	// 지각 사유서 문서에 대한 데이터를 입력하기 위한 메서드
	public void insertLateDocu(LatenessDTO dto) {
		dao.insertLateDocu(dto);
	}

	// 휴가 신청서 문서에 대한 데이터를 입력하기 위한 메서드
	public void insertLeaveDocu(LeaveRequestDTO dto) {
		dao.insertLeaveDocu(dto);
	}

	// 해당 문서의 정보를 넘겨주기 위한 메서드
	public DocuDTO getDocuInfo(int docuSeq) {
		return dao.getDocuInfo(docuSeq);
	}

	// 해당 업무 기안 문서의 세부 정보를 넘겨주기 위한 메서드
	public WorkPropDTO getPropDetail(int docuSeq) {
		return dao.getPropDetail(docuSeq);
	}

	// 해당 휴가 신청서 문서의 세부 정보를 넘겨주기 위한 메서드
	public LeaveRequestDTO getLeaveDetail(int docuSeq) {
		return dao.getLeaveDetail(docuSeq);
	}

	// 해당 지각 사유서 문서의 세부 정보를 넘겨주기 위한 메서드
	public LatenessDTO getLatenessDetail(int docuSeq) {
		return dao.getLatenessDetail(docuSeq);
	}

	// 해당 문서의 결재 라인 정보를 넘겨주기 위한 메서드
	public List<ApprLineDTO> getApprLine(int docuSeq) {
		return dao.getApprLine(docuSeq);
	}

	// 해당 문서의 참조 라인 정보를 넘겨주기 위한 메서드
	public List<RefeLineDTO> getRefeLine(int docuSeq) {
		List<RefeLineDTO> list = dao.getRefeLine(docuSeq);
		for(RefeLineDTO dto : list) {
			String empNo = dto.getEmp_no();
			dto.setName(eDao.getName(empNo));
			dto.setRole_title(eDao.getRole(empNo));
		}
		return list;
	}

	// 해당 문서를 삭제하기 위한 메서드
	public void delDocu(int docuSeq) {
		dao.delDocu(docuSeq);
	}

	// 해당 문서를 업데이트 하기 위한 메서드
	public int updateDocu(DocuDTO dto) {
		return dao.updateDocu(dto);
	}

	// 업무 기안 문서를 업데이트 하기 위한 메서드
	public void updatePropDocu(WorkPropDTO dto) {
		dao.updatePropDocu(dto);
	}

	// 지각 사유서 문서를 업데이트 하기 위한 메서드
	public void updateLatenessDocu(LatenessDTO dto) {
		dao.updateLatenessDocu(dto);
	}

	// 휴가 신청서 문서를 업데이트 하기 위한 메서드
	public void updateLeaveDocu(LeaveRequestDTO dto) {
		dao.updateLeaveDocu(dto);
	}

	// 해당 문서의 결재 라인 상태를 반려 or 전결 처리에 따라 변경하기 위한 메서드
	public void updateApprLineAll(int docuSeq, int i) {
		dao.updateApprLineAll(docuSeq, i);
	}

	// 해당 문서에 대한 코멘트를 입력하기 위한 메서드
	public void insertComments(ApprLineDTO dto) {
		dao.inserComments(dto);
	}

	// 문서 상태를 업데이트 하기 위한 메서드
	public void updateDocuStatus(int docuSeq, String status) {
		dao.updateDocuStatus(docuSeq, status);
	}

	// 해당 결재 라인의 상태를 변경하기 위한 메서드
	public void updateApprLine(int docuSeq, int i, String status) {
		dao.updateApprLine(docuSeq, i, status);
	}
	
	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록을 검색 후 문서 종류에 따라 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchListByType(String empNo, String status, String docuCode, String keyword, int cPage) {
		return dao.searchListByType(empNo, status, docuCode, keyword, cPage);
	}

	// 해당 사원이 기안한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchWriteList(String empNo, String docuCode, String keyword, int cPage) {
		return dao.searchWriteList(empNo, docuCode, keyword, cPage);
	}

	// 해당 사원이 임시 저장한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchSavetList(String empNo, String docuCode, String keyword, int cPage) {
		return dao.searchSaveList(empNo, docuCode, keyword, cPage);
	}

	// 해당 사원이 결재한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchApprovedList(String empNo, String docuCode, String keyword, int cPage) {
		return dao.searchApprovedList(empNo, docuCode, keyword, cPage);
	}

	// 해당 사원이 반려한 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchReturnList(String empNo, String docuCode, String keyword, int cPage) {
		return dao.searchReturnList(empNo, docuCode, keyword, cPage);
	}

	// 해당 사원이 참조자인 문서 목록을 검색 후 넘겨주기 위한 메서드
	public List<DocuInfoListDTO> searchViewList(String empNo, String docuCode, String keyword, int cPage) {
		return dao.searchViewList(empNo, docuCode, keyword, cPage);
	}

	// 해당 사원의 문서함 중 결재 대기 or 결재 예정 문서 목록 중 검색 후의 총 갯수를 문서 종류에 따라 넘겨주기 위한 메서드
	public int getCountSearchListByType(String empNo, String status, String docuCode, String keyword) {
		return dao.getCountSearchListByType(empNo, status, docuCode, keyword);
	}

	// 해당 사원이 기안한 문서 목록 중 검색 후의 총 갯수를 넘겨주기 위한 메서드
	public int getCountSearchWriteList(String empNo, String docuCode, String keyword) {
		return dao.getCountSearchWriteList(empNo, docuCode, keyword);
	}

	// 해당 사원이 임시 저장한 문서 목록 중 검색 후의 총 갯수를 넘겨주기 위한 메서드
	public int getCountSearchSaveList(String empNo, String docuCode, String keyword) {
		return dao.getCountSearchSaveList(empNo, docuCode, keyword);
	}

	// 해당 사원이 결재한 문서 목록 중 검색 후의 총 갯수를 넘겨주기 위한 메서드
	public int getCountSearchApprovedList(String empNo, String docuCode, String keyword) {
		return dao.getCountSearchApprovedList(empNo, docuCode, keyword);
	}

	// 해당 사원이 반려한 문서 목록 중 검색 후의 총 갯수를 넘겨주기 위한 메서드
	public int getCountSearchReturnList(String empNo, String docuCode, String keyword) {
		return dao.getCountSearchReturnList(empNo, docuCode, keyword);
	}

	// 해당 사원이 참조자인 문서 목록 중 검색 후의 총 갯수를 넘겨주기 위한 메서드
	public int getCountSearchViewList(String empNo, String docuCode, String keyword) {
		return dao.getCountSearchViewList(empNo, docuCode, keyword);
	}

	// 해당 문서의 참조자인 해당 사원의 읽음 여부와 읽은 시간을 업데이트 하기 위한 메서드
	public void updateReadYN(int docuSeq, String empNo, String readYN) {
		dao.updateReadYN(docuSeq, empNo, readYN);
	}

	// 관리자가 결재 대기 or 결재 예정인 목록을 5개까지만 조회하기 위한 메서드
	public List<DocuInfoListDTO> selectApprList(String empNo, String status) {
		return dao.selectApprList(empNo, status);
	}

	// 관리자가 문서 양식 별 데이터를 조회하기 위한 메서드
	public List<DocuInfoListDTO> searchDocuListByDocuCode(String docuCode, String status, String keyword, int cPage) {
		return dao.searchDocuListByDocuCode(docuCode, status, keyword, cPage);
	}

	// 관리자가 조회하는 문서 양식 별 데이터의 총 갯수를 얻기 위한 메서드
	public int getCountSearchDocuList(String docuCode, String status, String keyword) {
		return dao.getCountSearchDocuList(docuCode, status, keyword);
	}
}
