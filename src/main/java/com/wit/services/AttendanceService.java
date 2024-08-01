package com.wit.services;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wit.dao.AttendanceDAO;
import com.wit.dto.AttendanceDTO;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceDAO dao;

    // 시간을 HH 형식으로 포맷하기 위한 객체!(DAteTimeFormatter)
    private final DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

    public void startAtd(String emp_no) throws Exception {
    	// 현재 날짜 및 시간 가져오기
        LocalDateTime now = LocalDateTime.now();
        // 현재 날짜를 java.sql.date 방식으로 변환하기!
        java.sql.Date workDate = java.sql.Date.valueOf(now.toLocalDate());
        
        // 해당 날짜에 이미 출근 기록이 있는지 확인
        AttendanceDTO existingRecord = dao.select(emp_no, workDate);
        if (existingRecord != null) {
            throw new Exception("이미 출근 기록이 있습니다.");
        }
        
        // 현재시간을 HH 형식으로 포맷하기
        String startTime = now.toLocalTime().format(timeFormatter);
        // 9시 이전 출근했는지 여부 체크
        String status = now.toLocalTime().isBefore(LocalTime.of(9, 0)) ? "정상출근" : "지각";

        System.out.println("Start Attendance - Now: " + now);
        System.out.println("Start Attendance - StartTime: " + startTime);
        System.out.println("Start Attendance - Status: " + status);

        AttendanceDTO dto = new AttendanceDTO(
            0, workDate, startTime, " ", " ", status, " ", emp_no
        );

        dao.startAtd(dto);
    }

    public void endAtd(String emp_no) throws Exception {
        LocalDateTime now = LocalDateTime.now();
        java.sql.Date workDate = java.sql.Date.valueOf(now.toLocalDate());
        
        // 해당 날짜에 이미 출근 기록이 있는지 확인
        AttendanceDTO existingRecord = dao.select(emp_no, workDate);
        if (existingRecord == null) {
            throw new Exception("출근 버튼을 누르지 않았습니다. 퇴근 버튼을 클릭할 수 없습니다.");
        }
        
        // 해당 날짜에 이미 퇴근 기록이 있는지 확인
        if (existingRecord.getEnd_time() != null && !existingRecord.getEnd_time().trim().isEmpty()) {
            throw new Exception("이미 퇴근 기록이 있습니다.");
        }

        String endTime = now.toLocalTime().format(timeFormatter);
        // 18시 이후에 퇴근 했는지 체크
        String status = now.toLocalTime().isAfter(LocalTime.of(18, 0)) ? "정상퇴근" : "조퇴";

        // 기존 기록의 퇴근 시간 및 상태 설정
        existingRecord.setEnd_time(endTime);
        existingRecord.setEnd_status(status);

        LocalTime start = LocalTime.parse(existingRecord.getStart_time(), timeFormatter);
        LocalTime end = LocalTime.parse(endTime, timeFormatter);
        // 출퇴근 시간 계산
        Duration duration = Duration.between(start, end);

        // 근무한 시간 계산
        long hoursWorked = duration.toHours();
        // 근무한 분 계산
        long minutesWorked = duration.toMinutes() % 60;

        // 점심시간 1시간 빼기
        if (start.isBefore(LocalTime.NOON) && end.isAfter(LocalTime.NOON.plusHours(1))) {
            hoursWorked -= 1;
        }
        // 근무시간 설정
        existingRecord.setWork_hours(hoursWorked + "H " + minutesWorked + "M");

        dao.endAtd(existingRecord);
    }
}
