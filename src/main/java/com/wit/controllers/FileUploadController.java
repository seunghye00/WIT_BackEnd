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
    private static final String UPLOAD_DIR = "C:/Users/Administrator/Desktop/UploadServerFile/";
    
    // 파일 업로드를 처리하는 메서드입니다. POST 요청을 처리합니다.
    @PostMapping
    @ResponseBody
    public Map<String, Object> uploadImage(MultipartHttpServletRequest request) {
        Map<String, Object> response = new HashMap<>(); // 클라이언트에게 반환할 응답 데이터를 저장할 맵을 생성합니다.

        try {
            // 클라이언트로부터 전달된 파일을 가져옵니다. "file"은 클라이언트 측에서 전달한 파일의 파라미터 이름입니다.
            MultipartFile file = request.getFile("file");

            // 파일이 비어 있지 않고 null이 아닌지 확인합니다.
            if (file != null && !file.isEmpty()) {
                // 파일명을 현재 시간(밀리초 단위)과 원본 파일명을 조합하여 생성합니다. 이를 통해 파일명이 중복되지 않도록 합니다.
                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

                // 파일이 저장될 경로를 설정합니다.
                Path uploadPath = Paths.get(UPLOAD_DIR, fileName);

                // 파일을 지정된 경로에 저장합니다.
                Files.copy(file.getInputStream(), uploadPath);

                // 클라이언트에게 반환할 파일 URL을 생성합니다. 이 URL은 클라이언트가 해당 파일에 접근할 수 있는 경로를 나타냅니다.
                String fileUrl = "/uploads/" + fileName; // 실제 URL 구조에 맞게 수정된 경로입니다.

                // 업로드가 성공했음을 알리고, 파일의 URL을 응답 데이터에 추가합니다.
                response.put("success", true);
                response.put("url", fileUrl);
            } else {
                // 파일이 비어있거나 null인 경우, 실패 메시지를 응답 데이터에 추가합니다.
                response.put("success", false);
                response.put("message", "File is empty or not found");
            }
        } catch (IOException e) {
            // 파일 업로드 중 예외가 발생한 경우, 에러 메시지를 응답 데이터에 추가합니다.
            response.put("success", false);
            response.put("message", "File upload error: " + e.getMessage());
        }

        // 최종적으로 클라이언트에게 응답 데이터를 반환합니다.
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
