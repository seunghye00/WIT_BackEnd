package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CalendarDAO;
import com.wit.dto.DepartmentCalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.PersonalCalendarDTO;

@Service
public class CalendarService {


		@Autowired
		private CalendarDAO dao;

		// 개인캘린더 목록 출력
		public List<PersonalCalendarDTO> perCalendarList() {
			return dao.perCalendarList();
		}
		
		// 부서캘린더 목록 출력
		public List<DepartmentCalendarDTO> depCalendarList() {
			return dao.depCalendarList();
		}

		// 개인캘린더 추가
		public int insertPerCalendar(PersonalCalendarDTO dto) {
			return dao.insertPerCalendar(dto);
		}
		
		// 부서캘린더 추가
		public int insertDepCalendar(DepartmentCalendarDTO dto) {
			return dao.insertDepCalendar(dto);
		}

		// 개인캘린더 삭제
		public int deletePerCalendar(int calendarSeq) {
			return dao.deletePerCalendar(calendarSeq);
		}
		
		// 부서캘린더 삭제
			public int deleteDepCalendar(int calendarSeq) {
				return dao.deleteDepCalendar(calendarSeq);
			}

		// 직원 정보 조회
		public EmployeeDTO employeeInfo(String emp_no) {
			return dao.employeeInfo(emp_no);
		}

}
