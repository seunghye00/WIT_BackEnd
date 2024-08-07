package com.wit.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wit.commons.BoardConfig;
import com.wit.dao.AddressBookDAO;
import com.wit.dto.AddressBookDTO;

@Service
public class AddressBookService {
	@Autowired
	private AddressBookDAO dao;

	// 이름의 초성으로 레코드 조회
	@Transactional
	public List<Map<String, Object>> selectByChosungAndCategory(int cpage, String emp_no, String chosung, String category) {
	    int startNum = (cpage - 1) * BoardConfig.recordCountPerPage + 1;
	    int endNum = cpage * BoardConfig.recordCountPerPage;

	    Map<String, Object> params = new HashMap<>();
	    params.put("emp_no", emp_no);
	    params.put("chosung", chosung);
	    params.put("category", category);
	    params.put("startNum", startNum);
	    params.put("endNum", endNum);

	    return dao.selectByChosungAndCategory(params);
	}
	
	// 주소록 초성 별 카운트 값 조회
	@Transactional
	public int toolCountPageByCategory(String emp_no, String chosung, String category) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("emp_no", emp_no);
	    params.put("chosung", chosung);
	    params.put("category", category);
	    return dao.toolCountPageByCategory(params);
	}
	
	// 주소록 검색 카운트 값 조회
	@Transactional
	public int totalCountPageSearch(String keyword) {
		return dao.totalCountPageSearch(keyword);
	}
	
	// 주소록 검색값 레코드 조회
	@Transactional
	public List<Map<String, Object>> selectByCon(String keyword, int cpage) {
		return dao.selectByCon(keyword, cpage * BoardConfig.recordCountPerPage - (BoardConfig.recordCountPerPage - 1),
				cpage * BoardConfig.recordCountPerPage);
	}
	
	// 콘텐츠 등록
	public void addContact(AddressBookDTO newContact) {
	    dao.insertContact(newContact);
	}
	
	// 콘텐츠 수정
	public void updateContact(AddressBookDTO contact) throws Exception {
	    dao.updateContact(contact);
	}
	
	// 콘텐츠 삭제
	public void deleteContact(int addr_book_seq) throws Exception {
	    dao.deleteContact(addr_book_seq);
	}
	
	// 주소록 데이터 가져오기
	public AddressBookDTO getContactBySeq(int addr_book_seq) {
	    return dao.getContactBySeq(addr_book_seq);
	}

	public String getCategoryNameById(int category_id) {
	    return dao.getCategoryNameById(category_id);
	}
	
	// 카테고리
    // 카테고리 가져오기
    @Transactional
    public List<Map<String, Object>> getCategories(String emp_no) {
        return dao.getCategories(emp_no);
    }

    @Transactional
    public boolean addCategory(String emp_no, String category) {
        if (category == null) {
            category = "";
        }
        Map<String, Object> params = new HashMap<>();
        params.put("emp_no", emp_no);
        params.put("category", category);
        return dao.addCategory(params) > 0;
    }

    @Transactional
    public boolean editCategory(String emp_no, String originalCategory, String category) {
        if (originalCategory == null) {
            originalCategory = "";
        }
        if (category == null) {
            category = "";
        }
        Map<String, Object> params = new HashMap<>();
        params.put("emp_no", emp_no);
        params.put("oldCategory", originalCategory);
        params.put("newCategory", category);
        return dao.editCategory(params) > 0;
    }

    @Transactional
    public boolean deleteCategory(String emp_no, String category) {
        if (category == null) {
            category = "";
        }
        Map<String, Object> params = new HashMap<>();
        params.put("emp_no", emp_no);
        params.put("category", category);
        return dao.deleteCategory(params) > 0;
    }

}
