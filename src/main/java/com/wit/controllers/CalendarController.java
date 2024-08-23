package com.wit.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.CompanyCalendarDTO;
import com.wit.dto.DepartmentCalendarDTO;
import com.wit.dto.EmployeeDTO;
import com.wit.dto.ExecutiveCalendarDTO;
import com.wit.dto.PersonalCalendarDTO;
import com.wit.services.CalendarService;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

	@Autowired
	private CalendarService service;

	@Autowired
	private HttpSession session;

	// 캘린더 이동
	@RequestMapping("/calendar")
	public String calendar(Model model) {
		String empNo = (String) session.getAttribute("loginID");		
		EmployeeDTO employee = service.employeeInfo(empNo);		
		String roleCode = employee.getRole_code();
		
		List<DepartmentCalendarDTO> dlist = service.depCalendarList(empNo,roleCode);
		List<PersonalCalendarDTO> plist = service.perCalendarList(empNo);
		List<CompanyCalendarDTO> clist = service.comCalendarList();
		List<ExecutiveCalendarDTO> elist = service.exCalendarList();
		
		System.out.println("clist size: " + clist.get(0).getCalendar_name());
		System.out.println("elist size: " + elist.get(0).getCalendar_name());
		model.addAttribute("plist", plist);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("elist", elist);
		model.addAttribute("employee", employee);
		return "/Calendar/calendar";
	}

	// 개인 캘린더 추가
	@RequestMapping("/insertPerCalendar")
	public String insertPerCalendar(PersonalCalendarDTO dto) {
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		service.insertPerCalendar(dto);
		return "redirect:/calendar/calendar";
	}

	
	// 개인 캘린더 삭제
	@PostMapping("/deletePerCalendar")
    @ResponseBody
    public Map<String, Object> deletePerCalendar(@RequestParam("calendarSeq") String calendarSeq) {
        Map<String, Object> response = new HashMap<>();
        try {        	
            boolean success = service.deletePerCalendar(Integer.parseInt(calendarSeq));
            response.put("success", success);
            response.put("message", success ? "삭제 성공" : "삭제 실패");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "삭제 요청 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        return response;
	}

	// 부서 캘린더 추가(각 부서 부장만 가능)
	@RequestMapping("/insertDepCalendar")
	public String insertDepCalendar(DepartmentCalendarDTO dto) {
		service.insertDepCalendar(dto);
		return "redirect:/calendar/calendar";
	}

	// 부서 캘린더 삭제(각 부서 부장만 가능)
	@PostMapping("/deleteDepCalendar")
    @ResponseBody
    public Map<String, Object> deleteDepCalendar(@RequestParam("calendarSeq") String calendarSeq) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean success = service.deleteDepCalendar(Integer.parseInt(calendarSeq));
            response.put("success", success);
            response.put("message", success ? "삭제 성공" : "삭제 실패");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "삭제 요청 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        return response;
	}

	// 캘린더 타입 조회
	@ResponseBody
	@RequestMapping(value = "/getCalendarType", produces = "application/json;charset=utf8")
	public String getCalendarType(int calendarSeq) {
		String calendarType = service.getCalendarType(calendarSeq);
		String jsonResponse = "{\"type\": \"" + calendarType + "\"}";
		return jsonResponse;
	}
}
