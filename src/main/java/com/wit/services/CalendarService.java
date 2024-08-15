package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CalendarDAO;
import com.wit.dao.EmployeeDAO;
import com.wit.dto.DepartmentCalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.PersonalCalendarDTO;

@Service
public class CalendarService {

	@Autowired
	private CalendarDAO dao;

	// 개인캘린더 목록 출력
	public List<PersonalCalendarDTO> perCalendarList(String empNo) {
		return dao.perCalendarList(empNo);
	}

	// 부서캘린더 목록 출력
	public List<DepartmentCalendarDTO> depCalendarList(String empNo) {
		return dao.depCalendarList(empNo);
	}

	// 개인캘린더 추가
	public int insertPerCalendar(PersonalCalendarDTO dto) {
		return dao.insertPerCalendar(dto);
	}

	// 부서캘린더 추가 (각 부서 부장만 가능)
	public int insertDepCalendar(DepartmentCalendarDTO dto) {
		return dao.insertDepCalendar(dto);
	}

	// 개인캘린더 삭제 
	public int deletePerCalendar(int calendarSeq) {
		return dao.deletePerCalendar(calendarSeq);
	}

	// 부서캘린더 삭제 (각 부서 부장만 가능)
	public int deleteDepCalendar(int calendarSeq) {
		return dao.deleteDepCalendar(calendarSeq);
	}

	// 직원 정보 조회
	public EmployeeDTO employeeInfo(String empNo) {
		return dao.employeeInfo(empNo);
	}

	// 개인 기본 캘린더 추가
	public void insertPerDefaultCalendar(String empNo) {
		// 해당 사번으로 사원 개인의 기본 캘린더 등록
		dao.insertPerDefaultCalendar(empNo);
	}

	// 캘린더 타입 조회
	public String getCalendarType(int calendarSeq) {
		System.out.println(dao.selectPersonalByCalendarSeq(calendarSeq));
		if(dao.selectPersonalByCalendarSeq(calendarSeq) > 0) {
			return "personal";
		} else {
			return "dept";
		}
	}
}
