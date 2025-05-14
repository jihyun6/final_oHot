package com.ohot.home.groupProfile.service.impl;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class SpotiryApiServiceImpl {
	
	public String search(String accessToken, String q){ //q는 검색어

        RestTemplate rest = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);;
        headers.add("Host", "api.spotify.com");
        headers.add("Content-type", "application/json");

        String url = UriComponentsBuilder.newInstance()
                .scheme("https")
                .host("api.spotify.com")
                .path("/v1/search")
                .queryParam("type", "track")
                .queryParam("q","artist:" + q)
                .build()
                .toUriString();
        
        HttpEntity<String> requestEntity = new HttpEntity<>("", headers);
        ResponseEntity<String> responseEntity = rest.exchange(url, HttpMethod.GET, requestEntity, String.class);

        return responseEntity.getBody();
    }
}
