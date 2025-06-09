package com.ohot.api.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.api.service.impl.TranslationServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TranslateController {
	
	@Autowired
	TranslationServiceImpl translationService;
	
	@ResponseBody
	@PostMapping("/api/translate")
	public String translate(@RequestBody Map<String, Object> data) {
		String text = (String) data.get("text");
		String target = (String) data.get("target"); // 언어설정
		
		String translated = this.translationService.translateText(text, target);
		
		return translated;
	}
}
