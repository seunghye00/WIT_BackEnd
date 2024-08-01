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
    public List<AddressBookDTO> selectByChosung(Map<String, Object> params) {
        return mybatis.selectList("addressbook.selectByChosung", params);
    }

	// 게시글 페이지네이션 총 카운트
	public int totalCountPage() {
		return mybatis.selectOne("addressbook.totalCountPage");
	}

}
