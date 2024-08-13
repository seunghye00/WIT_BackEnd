package com.wit.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reservation/")
public class ReservController {

	// 예약 메인페이지로 이동
	@RequestMapping("home")
	public String home() throws Exception {
		return "Reservation/home";
	}

	// 회의실 예약 페이지로 이동
	@RequestMapping("meetingRoom")
	public String reservMeetingRoom() throws Exception {
		return "Reservation/meetingRoom";
	}

	// 차량 예약 페이지로 이동
	@RequestMapping("vehicle")
	public String reservVehicle() throws Exception {
		return "Reservation/vehicle";
	}
}
