package com.ohot.api.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/ckEditor")
@RestController
public class CkEditorFileController {

	private final String uploadDir = "C:/workspace/tempUpload/";
	
	@PostMapping("/tempUpload")
    public Map<String, Object> uploadTempImage(@RequestParam("upload") MultipartFile file) {
		log.info("uploadTempImage -> file : " + file);
		
        Map<String, Object> response = new HashMap<>();
        try {
            String originalName = file.getOriginalFilename();
            String uuid = UUID.randomUUID().toString();
            String newName = uuid + "_" + originalName;

            File uploadPath = new File(uploadDir);
            if (!uploadPath.exists()) uploadPath.mkdirs();

            File dest = new File(uploadDir + newName);
            file.transferTo(dest);

            response.put("url", "/images/temp/" + newName); // 웹에서 접근 가능한 URL 경로
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }
	
}
