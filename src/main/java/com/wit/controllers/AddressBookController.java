package com.wit.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.commons.BoardConfig;
import com.wit.dto.AddressBookDTO;
import com.wit.services.AddressBookService;

@Controller
@RequestMapping("/addressbook")
public class AddressBookController {

	@Autowired
	private AddressBookService serv;

	@Autowired
	private HttpSession session;

	@RequestMapping("/addressbook")
    public String attendance(Model model, @RequestParam(required = false) String chosung, @RequestParam(required = false) String cpage) {
        String emp_no = (String) session.getAttribute("loginID");
        if (cpage == null) {
            cpage = "1";
        }
        int cpage_num = Integer.parseInt(cpage);

        if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
            chosung = "전체";
        }
        List<AddressBookDTO> list = serv.selectByChosung(cpage_num, emp_no, chosung);
        int totPage = serv.totalCountPage();

        model.addAttribute("totPage", totPage);
        model.addAttribute("cpage", cpage_num);
        model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);
        model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
        model.addAttribute("addressBookList", list);
        return "AddressBook/addressBook";
    }
	
	@RequestMapping("/addressTool")
	@ResponseBody
	public Map<String, Object> addressBookAjax(String chosung, String cpage) {
	    String emp_no = (String) session.getAttribute("loginID");
	    if (cpage == null) {
	        cpage = "1";
	    }
	    int cpage_num = Integer.parseInt(cpage);

	    if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
	        chosung = "";
	    }
	    List<AddressBookDTO> list = serv.selectByChosung(cpage_num, emp_no, chosung);
	    int totPage = serv.totalCountPage();

	    Map<String, Object> response = new HashMap<>();
	    response.put("totPage", totPage);
	    response.put("cpage", cpage_num);
	    response.put("naviCountPerPage", BoardConfig.naviCountPerPage);
	    response.put("recordCountPerPage", BoardConfig.recordCountPerPage);
	    response.put("addressBookList", list);
	    return response;
	}
}
