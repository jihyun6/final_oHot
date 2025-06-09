package com.ohot.api.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TranslationServiceImpl {

	@Value("${google.api.key}")
	private String apiKey;
	
	public String translateText(String text, String target) {
		String url = "https://translation.googleapis.com/language/translate/v2?key=" + apiKey;
		
		Map<String, String> body = new HashMap<>();
		body.put("q", text);
		body.put("target", target);
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
		
		JsonObject json = JsonParser.parseString(response.getBody()).getAsJsonObject();
		String translatedText = json.getAsJsonObject("data")
									.getAsJsonArray("translations")
									.get(0).getAsJsonObject()
									.get("translatedText").getAsString();
		
		return translatedText.replaceAll("&#39;", "'");
	}
}
