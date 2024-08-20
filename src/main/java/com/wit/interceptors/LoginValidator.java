package com.wit.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginValidator implements HandlerInterceptor {

	@Autowired
	private HttpSession session;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String loginID = (String) session.getAttribute("loginID");
		if (loginID != null) {
			return true;
		}
		response.sendRedirect("/error");
		return false;
	}
}
