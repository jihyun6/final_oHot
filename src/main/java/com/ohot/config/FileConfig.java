package com.ohot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

//스프링에게 설정 파일임을 알려주자
@Slf4j
@Configuration
public class FileConfig implements WebMvcConfigurer {
	/*	웹 주소와 파일의 위치 매핑
	 *  주소줄에 이렇게 쓰면 /upload/2025/02/20/개똥이.jpg
	 *  윈도우 => C:/workspace/upload/2025/02/20/개똥이.jpg
	 *  리눅스 경로 임시 방편입니다
	 *  리눅스 => /home/[username]/workspace/upload/2025/02/20/개똥이
	 * */
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		String uploadPath = "";
		String os = System.getProperty("os.name").toLowerCase();
		
		log.debug("OS 시스템: " + os);
		
		if(os.contains("win")) {
			// window 경로
			uploadPath = "file:///C:/workspace/upload/";
		} else {
			// Linux, Mac 경로
			uploadPath = "file:///home/by0/Dev/ddit/finalproj/workspace/upload/";
		}
		
		log.debug("addResourceHandlers실행! Upload Path: " + uploadPath);
		
		registry.addResourceHandler("/upload/**")
				.addResourceLocations(uploadPath);
		
	}
}



