package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.AddressBookDTO;

@Repository
public class AddressBookDAO {
	@Autowired
	private SqlSession mybatis;

	// 전체 주소록 조회
	// 이름의 초성으로 레코드 조회
	public List<Map<String, Object>> selectByChosungAndCategory(Map<String, Object> params) {
	    return mybatis.selectList("addressbook.selectByChosungAndCategory", params);
	}

	public int toolCountPageByCategory(Map<String, Object> params) {
	    return mybatis.selectOne("addressbook.toolCountPageByCategory", params);
	}
	
	// 주소록 검색
	public List<Map<String, Object>> selectByCon(String keyword, int startNum, int endNum) {
		Map<String, Object> params = new HashMap<>();
		params.put("keyword", keyword);
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		List<Map<String, Object>> list = mybatis.selectList("addressbook.selectByCon", params);
		return list;
	}
	
	// 주소록 툴바 페이지네이션 총 카운트
	public int totalCountPageSearch(String keyword) {
		return mybatis.selectOne("addressbook.totalCountPageSearch", keyword);
	}
	
	// 카테고리 목록 가져오기
    public List<String> getCategories(String emp_no) {
        return mybatis.selectList("addressbook.getCategories", emp_no);
    }

    // 카테고리 추가
    public int addCategory(Map<String, Object> params) {
        return mybatis.insert("addressbook.addCategory", params);
    }

    // 카테고리 수정
    public int editCategory(Map<String, Object> params) {
        return mybatis.update("addressbook.editCategory", params);
    }

    // 카테고리 삭제
    public int deleteCategory(Map<String, Object> params) {
        return mybatis.delete("addressbook.deleteCategory", params);
    }
    
}
