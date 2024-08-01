package com.wit.dto;

import java.sql.Date;

public class AttendanceDTO {

    private int atd_seq;
    private Date work_date;
    private String start_time;
    private String end_time;
    private String work_hours;
    private String start_status;
    private String end_status;
    private String emp_no;

    public AttendanceDTO() {}

    public AttendanceDTO(int atd_seq, Date work_date, String start_time, String end_time, String work_hours,
                         String start_status, String end_status, String emp_no) {
        this.atd_seq = atd_seq;
        this.work_date = work_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.work_hours = work_hours;
        this.start_status = start_status;
        this.end_status = end_status;
        this.emp_no = emp_no;
    }

    // Getters and Setters
    public int getAtd_seq() {
        return atd_seq;
    }

    public void setAtd_seq(int atd_seq) {
        this.atd_seq = atd_seq;
    }

    public Date getWork_date() {
        return work_date;
    }

    public void setWork_date(Date work_date) {
        this.work_date = work_date;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getWork_hours() {
        return work_hours;
    }

    public void setWork_hours(String work_hours) {
        this.work_hours = work_hours;
    }

    public String getStart_status() {
        return start_status;
    }

    public void setStart_status(String start_status) {
        this.start_status = start_status;
    }

    public String getEnd_status() {
        return end_status;
    }

    public void setEnd_status(String end_status) {
        this.end_status = end_status;
    }

    public String getEmp_no() {
        return emp_no;
    }

    public void setEmp_no(String emp_no) {
        this.emp_no = emp_no;
    }
}
