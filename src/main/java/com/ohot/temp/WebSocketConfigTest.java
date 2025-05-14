package com.ohot.temp;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
/*
 * @Configuration
 * 
 * @EnableWebSocketMessageBroker public class WebSocketConfigTest implements
 * WebSocketMessageBrokerConfigurer {
 * 
 * @Override public void registerStompEndpoints(StompEndpointRegistry registry)
 * { registry.addEndpoint("/ws/dm") // 웹소켓 연결 엔드포인트
 * .setAllowedOriginPatterns("*") .withSockJS(); // SockJS fallback 사용 }
 * 
 * @Override public void configureMessageBroker(MessageBrokerRegistry registry)
 * { registry.enableSimpleBroker("/topic"); // 메시지 구독 주소 prefix
 * registry.setApplicationDestinationPrefixes("/app"); // 메시지 송신 주소 prefix } }
 */