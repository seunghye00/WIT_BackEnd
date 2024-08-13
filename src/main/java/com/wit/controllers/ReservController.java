package com.wit.controllers;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.RoomBookingDTO;
import com.wit.services.EmployeeService;
import com.wit.services.MeetingRoomService;

@Controller
@RequestMapping("/reservation/")
public class ReservController {
	
	@Autowired
	private HttpSession session;

	@Autowired
	private MeetingRoomService mServ;
	
	@Autowired
	private EmployeeService eServ;

	// 예약 메인페이지로 이동
	@RequestMapping("home")
	public String home(Model model) throws Exception {
		// 회의실 목록을 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList());
		return "Reservation/home";
	}

	// 회의실 예약 페이지로 이동
	@RequestMapping("meetingRoom")
	public String reservMeetingRoom(int roomSeq, Model model) throws Exception {
		// 회의실 목록 및 선택한 회의실의 정보를 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList());
		model.addAttribute("meetingRoomInfo", mServ.getMeetingRoomInfo(roomSeq));
		return "Reservation/meetingRoom";
	}

	// 회의실 예약 데이터 등록
	@RequestMapping("meetingRoom/addEvent")
	public String addMeetingRoomEvent(RoomBookingDTO dto, long startDate, long endDate) throws Exception {
		// 세션에 저장된 사번으로 예약자 정보 설정
		String empNo = (String)session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		dto.setDept_title(eServ.getDept(empNo));
		
		// 클라이언트에서 받아온 long 타입 값으로 예약 날짜 및 시간 설정 
		dto.setStart_date(new Timestamp(startDate));
		dto.setEnd_date(new Timestamp(endDate));
		
		// 클라이언트에서 받아온 정보와 위에서 설정한 정보들을 DB에 저장
		mServ.addMeetingRoomEvent(dto);
		
		// 해당 회의실 예약 페이지로 다시 이동 
		return "redirect:/reservation/meetingRoom?roomSeq=" + dto.getRoom_seq();
	}
	
	//회의실 예약 페이지 로드 시 해당 회의실의 모든 예약 정보를 AJAX로 넘겨주기 위한 메서드
	@ResponseBody
	@RequestMapping("allRoomBooking")
	public List<RoomBookingDTO> getAllRoomBooking(String roomSeq) throws Exception {
		// 해당 회의실의 모든 예약 정보를 조회 후 데이터 전송 
		return mServ.getAllRoomBooking(Integer.parseInt(roomSeq));
	}

	// 차량 예약 페이지로 이동
	@RequestMapping("vehicle")
	public String reservVehicle() throws Exception {
		return "Reservation/vehicle";
	}
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/";
	}
}