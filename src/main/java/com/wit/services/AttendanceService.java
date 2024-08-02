package com.wit.services;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wit.dao.AttendanceDAO;
import com.wit.dto.AttendanceDTO;
import com.wit.dto.EmployeeDTO;

@Service
public class AttendanceService {

	@Autowired
	private AttendanceDAO dao;

	// 시간을 HH:mm 형식으로 포맷하기 위한 객체
	private final DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

	public void startAtd(String emp_no) throws Exception {
		// 현재 날짜 및 시간 가져오기
		LocalDateTime now = LocalDateTime.now();
		// 현재 날짜를 java.sql.date 방식으로 변환하기
		java.sql.Date workDate = java.sql.Date.valueOf(now.toLocalDate());

		// 해당 날짜에 이미 출근 기록이 있는지 확인
		AttendanceDTO existingRecord = dao.select(emp_no, workDate);
		if (existingRecord != null) {
			throw new Exception("이미 출근 기록이 있습니다.");
		}

		// 현재 시간을 HH:mm 형식으로 포맷하기
		String startTime = now.toLocalTime().format(timeFormatter);
		// 9시 이전 출근했는지 여부 체크
		String status = now.toLocalTime().isBefore(LocalTime.of(9, 0)) ? "정상출근" : "지각";

		// 출근 기록 DTO 생성
		AttendanceDTO dto = new AttendanceDTO(0, workDate, startTime, " ", " ", status, " ", emp_no);
		// 출근 기록 저장
		dao.startAtd(dto);
	}

	public void endAtd(String emp_no) throws Exception {
		// 현재 날짜 및 시간 가져오기
		LocalDateTime now = LocalDateTime.now();
		// 현재 날짜를 java.sql.date 방식으로 변환하기
		java.sql.Date workDate = java.sql.Date.valueOf(now.toLocalDate());

		// 해당 날짜에 출근 기록이 있는지 확인
		AttendanceDTO existingRecord = dao.select(emp_no, workDate);
		if (existingRecord == null) {
			throw new Exception("출근 버튼을 누르지 않았습니다. 퇴근 버튼을 클릭할 수 없습니다.");
		}

		// 해당 날짜에 이미 퇴근 기록이 있는지 확인
		if (existingRecord.getEnd_time() != null && !existingRecord.getEnd_time().trim().isEmpty()) {
			throw new Exception("이미 퇴근 기록이 있습니다.");
		}

		// 현재 시간을 HH:mm 형식으로 포맷하기
		String endTime = now.toLocalTime().format(timeFormatter);
		// 18시 이후에 퇴근 했는지 여부 체크
		String status = now.toLocalTime().isAfter(LocalTime.of(18, 0)) ? "정상퇴근" : "조퇴";

		// 퇴근 시간 및 상태 설정
		existingRecord.setEnd_time(endTime);
		existingRecord.setEnd_status(status);

		// 출퇴근 시간 계산
		LocalTime start = LocalTime.parse(existingRecord.getStart_time(), timeFormatter);
		LocalTime end = LocalTime.parse(endTime, timeFormatter);
		Duration duration = Duration.between(start, end);

		// 근무 시간 계산
		long hoursWorked = duration.toHours();
		long minutesWorked = duration.toMinutes() % 60;

		// 점심시간 1시간 빼기
		if (start.isBefore(LocalTime.NOON) && end.isAfter(LocalTime.NOON.plusHours(1))) {
			hoursWorked -= 1;
		}
		// 근무시간 설정
		existingRecord.setWork_hours(hoursWorked + "H " + minutesWorked + "M");

		// 퇴근 기록 저장
		dao.endAtd(existingRecord);
	}

	// 월간 근태현황 조회
	public Map<String, Integer> getMonthlyStatus(String empNo) {
		Map<String, Integer> monthlyStatus = dao.getMonthlyStatus(empNo);
		System.out.println("서비스: " + monthlyStatus);
		return monthlyStatus;
	}

	// 월간 근무시간 조회
	public Map<String, Object> getMonthlyWorkHours(String empNo) {
		Map<String, Object> result = dao.getMonthlyWorkHours(empNo);

		// 총 근무시간을 시간과 분으로 변환
		BigDecimal totalHours = (BigDecimal) result.get("TOTALWORKINGHOURS");
		int hours = totalHours.intValue();
		int minutes = totalHours.subtract(new BigDecimal(hours)).multiply(new BigDecimal(60)).intValue();
		result.put("totalWorkingHours", hours + "시간 " + minutes + "분");
		return result;
	}

	// 주간 근무현황 조회
	public List<Map<String, Object>> getWeeklyStatus(String emp_no) {
		return dao.getWeeklyStatus(emp_no);
	}

	// 월간 근무현황 조회
	public List<Map<String, Object>> getMonthlyWorkStatus(String emp_no, String month) {
		return dao.getMonthlyWorkStatus(emp_no, month);
	}

	// 결근
	public void markAbsence(String emp_no, java.sql.Date work_date) {
		System.out.println("결근 체크 시작: " + emp_no + ", 날짜: " + work_date);
		dao.markAbsence(emp_no, work_date);
		System.out.println("결근 체크 완료: " + emp_no + ", 날짜: " + work_date);
	}

	// 직원 정보 조회 메소드 추가
    public EmployeeDTO getEmployeeInfo(String emp_no) {
        return dao.getEmployeeInfo(emp_no);
    }
}
