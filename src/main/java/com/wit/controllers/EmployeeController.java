package com.wit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wit.dto.EmployeeDTO;
import com.wit.services.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private EmployeeService service;

    @Autowired
    private HttpSession session;

    // 관리자 회원가입 폼으로 이동
    @RequestMapping("/register_form")
    public String registerForm() {
        return "register";
    }

    // ID 찾기 폼으로 이동
    @RequestMapping("/find_ID")
    public String findID() {
        return "findID";
    }

    // 회원가입
    @RequestMapping(value = "/register")
    public String register(EmployeeDTO dto) {
        int result = service.register(dto);
        if (result == 1) {
            return "redirect:/";
        } else {
            return "register";
        }
    }

    // 로그인
    @RequestMapping("/login")
    public String login(@RequestParam("emp_no") String empNo, @RequestParam("pw") String pw, HttpSession session,
            Model model) {
        EmployeeDTO employee = service.login(empNo, pw);
        if (employee != null) {
            session.setAttribute("loginID", empNo);
            boolean isFirstLogin = service.isFirstLogin(empNo);
            model.addAttribute("isFirstLogin", isFirstLogin);
            return "home"; // 로그인 성공 시 리다이렉트할 페이지
        } else {
            model.addAttribute("error", "Invalid ID or Password");
            return "login"; // 로그인 페이지로 다시 이동
        }
    }

    // 로그아웃
    @RequestMapping("/logout")
    public String logout() throws Exception {
        session.invalidate();
        return "redirect:/";
    }

    // 회원탈퇴
    @RequestMapping("/delete")
    public String delete() throws Exception {
        String empNo = (String) session.getAttribute("loginID");
        if (empNo != null) {
            service.delete(empNo);
            session.invalidate();
        }
        return "redirect:/";
    }

    // 추가 정보 업데이트
    @RequestMapping("/update_info")
    public String updateInfo(EmployeeDTO dto, HttpSession session) {
        String empNo = (String) session.getAttribute("loginID"); //세션
        dto.setEmp_no(empNo); //사원
        service.updateInfo(dto); 
        session.setAttribute("isFirstLogin", false);
        return "redirect:/";
    }

    // 예외를 담당하는 메서드 생성
    @ExceptionHandler(Exception.class)
    public String exceptionHandler(Exception e) {
        e.printStackTrace();
        return "error";
    }
}
