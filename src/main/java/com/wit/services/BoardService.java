package com.wit.services; 
 
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service; 
 
import com.wit.dao.BoardDAO; 
import com.wit.dto.BoardDTO; 
 
@Service 
public class BoardService { 
	 
	@Autowired 
	private BoardDAO dao; 
	 
	public int write(BoardDTO dto) { 
		return dao.write(dto); 
	} 
} 