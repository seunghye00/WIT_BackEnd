package com.wit.dao; 
 
import org.apache.ibatis.session.SqlSession; 
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Repository; 
 
import com.wit.dto.BoardFilesDTO; 
 
@Repository 
public class BoardFilesDAO { 
	 
	@Autowired 
	private SqlSession mybatis; 
	 
	public void insert(BoardFilesDTO dto) throws Exception{ 
		mybatis.insert("file.write",dto); 
	} 
} 