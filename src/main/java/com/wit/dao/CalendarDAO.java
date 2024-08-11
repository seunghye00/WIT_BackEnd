package com.wit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.DepartmentCalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.PersonalCalendarDTO;

@Repository
public class CalendarDAO {

	@Autowired
	private SqlSession mybatis;
	
	
	// 개인 캘린더 출력
	public List<PersonalCalendarDTO> perCalendarList() {
		return mybatis.selectList("calendar.perCalendarList");
	}
	
	
	// 개인 캘린더 추가
	public int insertPerCalendar(PersonalCalendarDTO dto) {
		return mybatis.insert("calendar.insertPerCalendar", dto);
	}
	
	// 개인 캘린더 삭제
	public int deletePerCalendar(int calendarSeq) {
		return mybatis.delete("calendar.deletePerCalendar", calendarSeq);
	}
	
	// 부서 캘린더 출력
		public List<DepartmentCalendarDTO> depCalendarList() {
			return mybatis.selectList("calendar.depCalendarList");
		}
	
	// 부서 캘린더 추가
	public int insertDepCalendar(DepartmentCalendarDTO dto) {
		return mybatis.insert("calendar.insertDepCalendar", dto);
	}
	
	// 부서 캘린더 삭제
	public int deleteDepCalendar(int calendarSeq) {
		return mybatis.delete("calendar.deleteDepCalendar", calendarSeq);
	}

	// 직원 정보 조회 메소드 추가
	public EmployeeDTO employeeInfo(String emp_no) {
		return mybatis.selectOne("calendar.employeeInfo", emp_no);
	}

}
