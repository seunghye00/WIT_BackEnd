package com.wit.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping("/")
	public String home() {
		System.out.println("HOME 요청 확인");
		return "home";
	}

	@RequestMapping("/error")
	public String error() {
		return "error";
	}

}
