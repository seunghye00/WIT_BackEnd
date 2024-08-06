package com.wit.services;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
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

    // 출근 기록 처리
    public Map<String, String> startAtd(String emp_no) {
        Map<String, String> response = new HashMap<>();

        // 전날 결근 처리
        LocalDate previousDay = LocalDate.now().minusDays(1);
        java.sql.Date previousDate = java.sql.Date.valueOf(previousDay);
        markAbsence(emp_no, previousDate);

        // 현재 날짜 및 시간 가져오기
        LocalDateTime now = LocalDateTime.now();
        java.sql.Date workDate = java.sql.Date.valueOf(now.toLocalDate());

        // 오늘 날짜에 이미 출근 기록이 있는지 확인
        AttendanceDTO existingRecord = dao.selectAtd(emp_no, workDate);
        if (existingRecord != null && existingRecord.getStart_time() != null) {
            response.put("message", "이미 출근 기록이 있습니다.");
            response.put("startTime", existingRecord.getStart_time());
            return response;
        }

        // 현재 시간을 HH:mm 형식으로 포맷
        String startTime = now.toLocalTime().format(timeFormatter);
        String status = now.toLocalTime().isBefore(LocalTime.of(9, 0)) ? "정상출근" : "지각";

        // 출근 기록 DTO 생성 및 저장
        AttendanceDTO dto = new AttendanceDTO(0, workDate, startTime, " ", " ", status, " ", emp_no);
        dao.startAtd(dto);

        response.put("message", "출근 완료!!");
        response.put("startTime", startTime);

        return response;
    }

    // 퇴근 기록 처리
    public Map<String, String> endAtd(String emp_no) {
        Map<String, String> response = new HashMap<>();

        // 현재 날짜 및 시간 가져오기
        LocalDateTime now = LocalDateTime.now();
        java.sql.Date workDate = java.sql.Date.valueOf(now.toLocalDate());

        // 출근 기록 확인
        AttendanceDTO existingRecord = dao.selectAtd(emp_no, workDate);
        if (existingRecord == null || existingRecord.getStart_time() == null) {
            response.put("message", "출근 기록이 없습니다. 퇴근할 수 없습니다.");
            return response;
        }

        // 이미 퇴근 기록이 있는지 확인
        if (existingRecord.getEnd_time() != null && !existingRecord.getEnd_time().trim().isEmpty()) {
            response.put("message", "이미 퇴근 기록이 있습니다.");
            response.put("endTime", existingRecord.getEnd_time());
            return response;
        }

        // 현재 시간을 HH:mm 형식으로 포맷
        String endTime = now.toLocalTime().format(timeFormatter);
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

        // 점심시간 1시간 제외
        if (start.isBefore(LocalTime.NOON) && end.isAfter(LocalTime.NOON.plusHours(1))) {
            hoursWorked -= 1;
        }
        existingRecord.setWork_hours(hoursWorked + "H " + minutesWorked + "M");

        // 퇴근 기록 저장
        dao.endAtd(existingRecord);

        response.put("message", "퇴근 완료!!");
        response.put("endTime", endTime);

        return response;
    }

    // 월간 근태현황 조회
    public Map<String, Integer> monthlyStatus(String empNo) {
        return dao.monthlyStatus(empNo);
    }

    // 월간 근무시간 조회
    public Map<String, Object> monthlyWorkHours(String empNo) {
        Map<String, Object> result = dao.monthlyWorkHours(empNo);
        BigDecimal totalHours = (BigDecimal) result.get("TOTALWORKINGHOURS");
        int hours = totalHours.intValue();
        int minutes = totalHours.subtract(new BigDecimal(hours)).multiply(new BigDecimal(60)).intValue();
        result.put("totalWorkingHours", hours + "시간 " + minutes + "분");
        return result;
    }

    // 주간 근무현황 조회
    public List<Map<String, Object>> weeklyStatus(String emp_no) {
        return dao.weeklyStatus(emp_no);
    }

    // 월간 근무현황 조회
    public List<Map<String, Object>> monthlyWorkStatus(String emp_no, String month) {
        return dao.monthlyWorkStatus(emp_no, month);
    }

    // 결근 처리
    public void markAbsence(String emp_no, java.sql.Date work_date) {
        dao.markAbsence(emp_no, work_date);
    }

    // 직원 정보 조회
    public EmployeeDTO employeeInfo(String emp_no) {
        return dao.employeeInfo(emp_no);
    }

    // 오늘 출근 기록 조회
    public AttendanceDTO getTodayAttendance(String emp_no) {
        java.sql.Date today = java.sql.Date.valueOf(LocalDate.now());
        return dao.selectAtd(emp_no, today);
    }
}
