package com.ohot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import com.ohot.util.AlarmWebSocketHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig  implements WebSocketConfigurer{

	@Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        

     
        // 알림
//        registry.addHandler(new AlarmWebSocketHandler(), "/ws/alarm").setAllowedOrigins("*");
        
        // 라이브스트리밍 핸들러 추가
        //registry.addHandler(streamingWebSocketHandler, "/ws/streaming").setAllowedOrigins("*");
    }
	
	@Bean
    public ServletServerContainerFactoryBean createWebSocketContainer() {
        ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
        container.setMaxTextMessageBufferSize(8192);
        container.setMaxBinaryMessageBufferSize(1024 * 1024);
        return container;
    }
}
