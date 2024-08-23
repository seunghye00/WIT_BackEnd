package com.wit.controllers;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        String emp_no = (String) session.getAttribute("loginID");
        
        if (cpage == null) {
            cpage = "1";
        }
        
        int cpage_num = Integer.parseInt(cpage);
        
        if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
            chosung = "";
        }
        
        if (category == null || category.isEmpty() || "전체".equals(category)) {
            category = "";
        }
        
        List<Map<String, Object>> list = serv.selectByChosungAndCategory(cpage_num, emp_no, chosung, category);
        int totPage = serv.toolCountPageByCategory(emp_no, chosung, category);
        List<Map<String, Object>> categoryList = serv.getCategories(emp_no);
        
        model.addAttribute("totPage", totPage);
        model.addAttribute("cpage", cpage_num);
        model.addAttribute("addressBookList", list);
        model.addAttribute("categoryList", categoryList);
        
        return "AddressBook/addressBook";
    }

    @RequestMapping("addressTool")
    @ResponseBody
    public Map<String, Object> addressBookAjax(String chosung, String cpage, String category) {
        String emp_no = (String) session.getAttribute("loginID");
        
        if (cpage == null) {
            cpage = "1";
        }
        
        int cpage_num = Integer.parseInt(cpage);
        
        if (chosung == null || chosung.isEmpty() || "전체".equals(chosung)) {
            chosung = "";
        }
        
        if (category == null || category.isEmpty() || "전체".equals(category)) {
            category = "";
        }
        
        List<Map<String, Object>> list = serv.selectByChosungAndCategory(cpage_num, emp_no, chosung, category);
        int totPage = serv.toolCountPageByCategory(emp_no, chosung, category);
        
        Map<String, Object> response = new HashMap<>();
        response.put("totPage", totPage);
        response.put("cpage", cpage_num);
        response.put("addressBookList", list);
        return response;
    }

    @RequestMapping("search")
    @ResponseBody
    public Map<String, Object> search(String keyword, String cpage, String category_id) {
    	String emp_no = (String) session.getAttribute("loginID");
    	System.out.println(keyword);
    	System.out.println(category_id);
        if (cpage == null) {
            cpage = "1";
        }
        int cpage_num = Integer.parseInt(cpage);
        int categoryId = 0;
        if (category_id != null && !category_id.isEmpty()) {
            try {
            	categoryId = Integer.parseInt(category_id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid category_id, setting it to null");
            }
        }

        List<Map<String, Object>> list = serv.selectByCon(keyword, cpage_num, emp_no, categoryId);
        int totPage = serv.totalCountPageSearch(keyword);

        Map<String, Object> response = new HashMap<>();
        response.put("totPage", totPage);
        response.put("cpage", cpage_num);
        response.put("addressBookList", list);
        return response;
    }
    
    @RequestMapping("addContact")
    public String addContact(String name, String email, String phone, String address, Integer category_id, String company, String position, MultipartFile photo, RedirectAttributes redirectAttributes) {
        String emp_no = (String) session.getAttribute("loginID");
        String realPath = "C:/UploadServerFile/"; 
        String fileName = null;

        if (photo != null && !photo.isEmpty()) {
            fileName = UUID.randomUUID().toString() + "_" + photo.getOriginalFilename();
            File uploadFile = new File(realPath, fileName);

            try {
                photo.transferTo(uploadFile);
                System.out.println("Uploaded file: " + uploadFile.getAbsolutePath());
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("message", "파일 업로드 실패!");
                return "redirect:/addressbook/addressbook";
            }
        }

        AddressBookDTO newContact = new AddressBookDTO();
        newContact.setEmp_no(emp_no);
        newContact.setName(name != null ? name : "-");
        newContact.setEmail(email != null ? email : "-");
        newContact.setPhone(phone != null ? phone : "010-0000-0000");
        newContact.setAddress(address != null ? address : "-");
        newContact.setCategory_id(category_id != null ? category_id : 0);
        newContact.setPhoto(fileName != null ? fileName : "default.jpg");
        newContact.setCompany(company != null ? company : "-");
        newContact.setPosition(position != null ? position : "-");

        serv.addContact(newContact);
        return "redirect:/addressbook/addressbook";
    }
    
    @RequestMapping("updateContact")
    public String updateContact(int addr_book_seq, String name, String email, String phone, String address, Integer category_id, String company, String position, MultipartFile photo, RedirectAttributes redirectAttributes) {
        String emp_no = (String) session.getAttribute("loginID");
        String realPath = "C:/UploadServerFile/"; 
        String fileName = null;

        if (photo != null && !photo.isEmpty()) {
            fileName = UUID.randomUUID().toString() + "_" + photo.getOriginalFilename();
            File uploadFile = new File(realPath, fileName);

            try {
                photo.transferTo(uploadFile);
                System.out.println("Uploaded file: " + uploadFile.getAbsolutePath());
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("message", "파일 업로드 실패!");
                return "redirect:/addressbook/addressbook";
            }
        }

        AddressBookDTO contact = new AddressBookDTO();
        contact.setAddr_book_seq(addr_book_seq);
        contact.setEmp_no(emp_no);
        contact.setName(name != null ? name : "-");
        contact.setEmail(email != null ? email : "-");
        contact.setPhone(phone != null ? phone : "010-0000-0000");
        contact.setAddress(address != null ? address : "-");
        contact.setCategory_id(category_id != null ? category_id : 0);
        contact.setPhoto(fileName != null ? fileName : "default.jpg");
        contact.setCompany(company != null ? company : "-");
        contact.setPosition(position != null ? position : "-");

        try {
            serv.updateContact(contact);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/addressbook/addressbook";
    }
    
    @RequestMapping("getContactDetails")
    @ResponseBody
    public Map<String, Object> getContactDetails(int addr_book_seq) {
        AddressBookDTO contact = serv.getContactBySeq(addr_book_seq);
        String category_name = serv.getCategoryNameById(contact.getCategory_id());
        
        String photoFileName = contact.getPhoto() != null ? contact.getPhoto() : "default.jpg";
        System.out.println("Photo file name: " + photoFileName);

        Map<String, Object> response = new HashMap<>();
        response.put("addr_book_seq", contact.getAddr_book_seq());
        response.put("name", contact.getName());
        response.put("phone", contact.getPhone());
        response.put("email", contact.getEmail());
        response.put("company", contact.getCompany());
        response.put("position", contact.getPosition());
        response.put("address", contact.getAddress());
        response.put("photo", photoFileName);
        response.put("category_name", category_name);
        return response;
    }
    
    @RequestMapping("deleteContact")
    @ResponseBody
    public Map<String, Object> deleteContact(@RequestParam("addr_book_seq") List<Integer> addr_book_seqs) {
        Map<String, Object> response = new HashMap<>();
        try {
            for (int addr_book_seq : addr_book_seqs) {
                serv.deleteContact(addr_book_seq);
            }
            response.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
        }
        return response;
    }

    @RequestMapping("getCategories")
    @ResponseBody
    public List<Map<String, Object>> getCategories() {
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
    
	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String execptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/error";
	}
}
