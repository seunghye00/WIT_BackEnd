package com.wit.configurators;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

public class WSHttpSessionConfigurator extends Configurator {
	
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		
		HttpSession hSession = (HttpSession)request.getHttpSession();
		sec.getUserProperties().put("hSession", hSession);
		super.modifyHandshake(sec, request, response);
	}
	
}
