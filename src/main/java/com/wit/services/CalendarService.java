package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CalendarDAO;
import com.wit.dao.EventsDAO;
import com.wit.dto.CompanyCalendarDTO;
import com.wit.dto.DepartmentCalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.ExecutiveCalendarDTO;
import com.wit.dto.PersonalCalendarDTO;

@Service
public class CalendarService {

	@Autowired
	private CalendarDAO dao;
	
	@Autowired
	private EventsDAO eDao;

	// 개인캘린더 목록 출력
	public List<PersonalCalendarDTO> perCalendarList(String empNo) {
		return dao.perCalendarList(empNo);
	}

	// 부서캘린더 목록 출력
	public List<DepartmentCalendarDTO> depCalendarList(String empNo, String roleCode) {
		return dao.depCalendarList(empNo, roleCode);
	}
	
	// 전사 일정 목록 출력
	public List<CompanyCalendarDTO> comCalendarList(){
		return dao.comCalendarList();
	}
	
	// 임원 일정 목록 출력
	public List<ExecutiveCalendarDTO> exCalendarList(){
		return dao.exCalendarList();
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
	public boolean deletePerCalendar(int calendarSeq) {
		int eventsDeleted = eDao.deleteEventsByCalendarSeq(calendarSeq);
		int calendarDeleted = dao.deletePerCalendar(calendarSeq);
		return calendarDeleted > 0 && eventsDeleted >= 0;
	}

	// 부서캘린더 삭제 (각 부서 부장만 가능)
	public boolean deleteDepCalendar(int calendarSeq) {
		int eventsDeleted = eDao.deleteEventsByCalendarSeq(calendarSeq);
		int calendarDeleted = dao.deleteDepCalendar(calendarSeq);
		return calendarDeleted > 0 && eventsDeleted >= 0;
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
