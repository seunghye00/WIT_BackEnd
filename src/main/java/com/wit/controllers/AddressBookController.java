package com.wit.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.commons.BoardConfig;
import com.wit.dto.AddressBookDTO;
import com.wit.services.AddressBookService;

@Controller
@RequestMapping("/addressbook/")
public class AddressBookController {

    @Autowired
    private AddressBookService serv;

    @Autowired
    private HttpSession session;

    @RequestMapping("addressbook")
    public String attendance(Model model, String chosung, String cpage, String category) {
        // 세션으로 부터 사원 번호 출력
        String emp_no = (String) session.getAttribute("loginID");
        
        // 현재 페이지값 널값이면 1로 반환시킴  
        if (cpage == null) {
            cpage = "1";
        }
        
        // 현재 페이지값 데이터 타입 int로 변환  
        int cpage_num = Integer.parseInt(cpage);

        // 초성 값이 널값이거나 빈값이거나 전체와 같다면 전체로 반환
        // 그외 초성 값은 통과
        if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
            chosung = "";
        }

        // 카테고리 값이 널값이거나 빈값이면 전체로 반환
        if (category == null || category.isEmpty() || "전체".equals(category)) {
            category = "";
        }

        // 주소록 출력을 위해 list 배열에 담아서 전송 
        List<Map<String, Object>> list = serv.selectByChosungAndCategory(cpage_num, emp_no, chosung, category);
        int totPage = serv.toolCountPageByCategory(emp_no, chosung, category);
        
        // 모델을 통해 값을 주소록 jsp에 전달
        model.addAttribute("totPage", totPage);
        model.addAttribute("cpage", cpage_num);
        model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);
        model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
        model.addAttribute("addressBookList", list);
        return "AddressBook/addressBook";
    }

    @RequestMapping("addressTool")
    @ResponseBody
    public Map<String, Object> addressBookAjax(String chosung, String cpage, String category) {
        // 세션으로 부터 사원 번호 출력
        String emp_no = (String) session.getAttribute("loginID");
        
        // 현재 페이지값 널값이면 1로 반환시킴  
        if (cpage == null) {
            cpage = "1";
        }
        
        // 현재 페이지값 데이터 타입 int로 변환  
        int cpage_num = Integer.parseInt(cpage);
        
        // 초성 값이 널값이거나 빈값이거나 전체와 같다면 전체로 반환
        // 그외 초성 값은 통과
        if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
            chosung = "";
        }
        
        // 카테고리 값이 널값이거나 빈값이면 전체로 반환
        if (category == null || category.isEmpty() || "전체".equals(category)) {
            category = "";
        }
        System.out.println(chosung+" / " +category);
        // 주소록 출력을 위해 list 배열에 담아서 전송 
        List<Map<String, Object>> list = serv.selectByChosungAndCategory(cpage_num, emp_no, chosung, category);
        int totPage = serv.toolCountPageByCategory(emp_no, chosung, category);
        
        // 모델을 통해 값을 주소록 ajax 요청에 전달
        Map<String, Object> response = new HashMap<>();
        response.put("totPage", totPage);
        response.put("cpage", cpage_num);
        response.put("naviCountPerPage", BoardConfig.naviCountPerPage);
        response.put("recordCountPerPage", BoardConfig.recordCountPerPage);
        response.put("addressBookList", list);
        return response;
    }

    // 게시글 검색
    @RequestMapping("search")
    @ResponseBody
    public Map<String, Object> search(String keyword, String cpage) throws Exception {
        if (cpage == null) {
            cpage = "1";
        }
        int cpage_num = Integer.parseInt(cpage);
        List<Map<String, Object>> list = serv.selectByCon(keyword, cpage_num);
        int totPage = serv.totalCountPageSearch(keyword);

        Map<String, Object> response = new HashMap<>();
        response.put("totPage", totPage);
        response.put("cpage", cpage_num);
        response.put("naviCountPerPage", BoardConfig.naviCountPerPage);
        response.put("recordCountPerPage", BoardConfig.recordCountPerPage);
        response.put("addressBookList", list);
        return response;
    }

    // 카테고리
    @RequestMapping("getCategories")
    @ResponseBody
    public List<String> getCategories() {
        String emp_no = (String) session.getAttribute("loginID");
        return serv.getCategories(emp_no);
    }

    @RequestMapping("addCategory")
    @ResponseBody
    public boolean addCategory(String category) {
        String emp_no = (String) session.getAttribute("loginID");
        return serv.addCategory(emp_no, category);
    }

    @RequestMapping("editCategory")
    @ResponseBody
    public boolean editCategory(String oldCategory, String newCategory) {
        String emp_no = (String) session.getAttribute("loginID");
        return serv.editCategory(emp_no, oldCategory, newCategory);
    }

    @RequestMapping("deleteCategory")
    @ResponseBody
    public boolean deleteCategory(String category) {
        String emp_no = (String) session.getAttribute("loginID");
        return serv.deleteCategory(emp_no, category);
    }
}
