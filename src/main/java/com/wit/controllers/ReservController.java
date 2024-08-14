package com.wit.controllers;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.VehicleBookingDTO;
import com.wit.services.VehicleBookingService;

@Controller
@RequestMapping("/reservation/")
public class ReservController {

	@Autowired
	private VehicleBookingService vService;
	@Autowired
	private HttpSession session;

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
	public String reservVehicle(int vehicleSeq, Model model) throws Exception {
		model.addAttribute("vehicle", vService.reservVehicle(vehicleSeq));
		return "Reservation/vehicle";
	}

	// 차량 예약 추가
	@RequestMapping("saveVehicle")
	public String saveVehicle(VehicleBookingDTO dto, @RequestParam("vehicleStartAt") long startDate,
			@RequestParam("vehicleEndAt") long endDate) {
		String emp_no = (String) session.getAttribute("loginID");
		dto.setEmp_no(emp_no);
		
		System.out.println(dto.getVehicle_seq());
		System.out.println(dto.getPurpose());
		dto.setStart_date(new Timestamp(startDate));
		dto.setEnd_date(new Timestamp(endDate));
		int result = vService.saveVehicle(dto);

		if (result == 1) {
			return "redirect:/reservation/vehicle?vehicleSeq=" + dto.getVehicle_seq();
		}
		return "redirect:/reservation/vehicle?vehicleSeq=" + dto.getVehicle_seq();
	}

	// 차량 예약 조회
	@ResponseBody
	@RequestMapping("/vehicleEvent")
	public List<VehicleBookingDTO> getAll(String vehicleSeq) throws Exception {
		return vService.getAll(vehicleSeq);
	}
}
