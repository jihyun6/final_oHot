package com.ohot.api.controller;

import java.io.IOException;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.credentials.ClientCredentials;
import se.michaelthelin.spotify.requests.authorization.client_credentials.ClientCredentialsRequest;

@Slf4j
@Component
public class SpotifyApiCreateToken {
	@Value("${spotify.client.id}")
	private String clientId;
	@Value("${spotify.client.secret}")
	private String clientSecret;
	
	 public String accesstoken() throws ParseException, SpotifyWebApiException {
		 
		 SpotifyApi spotifyApi = new SpotifyApi.Builder()
		            .setClientId(clientId)
		            .setClientSecret(clientSecret)
		            .build();
		 
        ClientCredentialsRequest clientCredentialsRequest = spotifyApi.clientCredentials().build();
        try {
            final ClientCredentials clientCredentials = clientCredentialsRequest.execute();
            spotifyApi.setAccessToken(clientCredentials.getAccessToken());
            
            return spotifyApi.getAccessToken();

        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
            return "error";
        }
    }

}
