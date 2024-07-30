package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.services.AttendanceService;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceService service;

    @Autowired
    private HttpSession session;

    // 출근시간
    @RequestMapping(value = "/start", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String startAttendance() {
        String empNo = (String) session.getAttribute("loginID");
        try {
            service.startAtd(empNo);
            return "출근 처리 완료";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    // 퇴근시간
    @RequestMapping(value = "/end", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String endAttendance() {
        String empNo = (String) session.getAttribute("loginID");
        try {
            service.endAtd(empNo);
            return "퇴근 처리 완료";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
