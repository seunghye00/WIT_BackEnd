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
	public List<AddressBookDTO> selectByChosung(int cpage, String emp_no, String chosung) {
        Map<String, Object> params = new HashMap<>();
        int startNum = (cpage - 1) * BoardConfig.recordCountPerPage + 1;
        int endNum = cpage * BoardConfig.recordCountPerPage;
        params.put("emp_no", emp_no);
        params.put("chosung", chosung);
        params.put("startNum", startNum);
        params.put("endNum", endNum);

        return dao.selectByChosung(params);
    }

	@Transactional
	public int totalCountPage() {
		return dao.totalCountPage();
	}
}
