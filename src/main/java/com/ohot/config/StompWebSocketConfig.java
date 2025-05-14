package com.ohot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class StompWebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override public void configureMessageBroker(MessageBrokerRegistry registry){ 
		registry.enableSimpleBroker("/toFan", "/toArtist","/toAll"); //(서버->클라이언트) 
		//클라이언트에서 send로 메세지 전송 (클라이언트->서버) }
		registry.setApplicationDestinationPrefixes("/app");
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) { // STOMP용 엔드포인트 (프론트 접속용) //
//		registry.addEndpoint("/ws/dm").setAllowedOrigins("http://localhost:28080").withSockJS(); //
		registry.addEndpoint("/ws/dm").setAllowedOriginPatterns("*").withSockJS();
//		registry.addEndpoint("/ws/dm").withSockJS();
		
		registry.addEndpoint("/ws/alarm").setAllowedOriginPatterns("*").withSockJS();
	}
}
