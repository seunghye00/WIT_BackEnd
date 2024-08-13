package com.wit.controllers;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.wit.services.FileService;

@Controller
@RequestMapping("/uploadImage")
public class FileUploadController {
	@Autowired
	private FileService fserv;
    private static final String UPLOAD_DIR = "C:/Users/타리/Desktop/UploadServerFile/";
    
    @PostMapping
    @ResponseBody
    public Map<String, Object> uploadImage(MultipartHttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            MultipartFile file = request.getFile("file");
            if (file != null && !file.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                Path uploadPath = Paths.get(UPLOAD_DIR, fileName);
                Files.copy(file.getInputStream(), uploadPath);

                String fileUrl = "/uploads/" + fileName; // Adjusted this based on your URL structure
                response.put("success", true);
                response.put("url", fileUrl);
            } else {
                response.put("success", false);
                response.put("message", "File is empty or not found");
            }
        } catch (IOException e) {
            response.put("success", false);
            response.put("message", "File upload error: " + e.getMessage());
        }
        return response;
    }
    
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(String files_seq) throws Exception{
//    	역직렬화 string을 object로 바꾸기
    	Gson gson = new Gson();
    	int[] filesSeq = gson.fromJson(files_seq, int[].class);
    	for (int i : filesSeq) {
			System.out.println(i);
		}
    	fserv.delete(filesSeq);
    	return null;
    }
    
}
