package com.ohot.config;

import org.springframework.stereotype.Component;

//스프링에서 자바빈으로 미리 등록해줌
@Component
//BeanController.java
public class BeanController {
	
	//파일이 업로드 되는 윈도 경로
	private String uploadFolder = "C:\\workspace\\upload";
	
	// 윈도우, Linux파일 경로 분류
    public BeanController() {
        String os = System.getProperty("os.name").toLowerCase();
        
        if (os.contains("win")) {
            // Windows 환경
            uploadFolder = "C:\\workspace\\upload";
        } else {
             // Linux/Ubuntu
        	     // 환경 임시방편이라 다른 사용자는 못 씀
        	//uploadFolder = "/home/{사용자명}/workspace/upload";
            uploadFolder = "/home/by0/Dev/ddit/finalproj/workspace/upload";
            // 웹서버 경로 필요할 수도 있음: "/var/www/html/workspace/upload"
        }
    }
    
	public String getUploadFolder() {
		return uploadFolder;
	}
	
}

