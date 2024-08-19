package com.wit.controllers;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.commons.BoardConfig;
import com.wit.dto.EmployeeInfoDTO;
import com.wit.dto.RoomBookingDTO;
import com.wit.dto.VehicleBookingDTO;
import com.wit.services.EmployeeService;
import com.wit.services.MeetingRoomService;
import com.wit.services.VehicleBookingService;

@Controller
@RequestMapping("/reservation/")
public class ReservController {

	@Autowired
	private HttpSession session;

	@Autowired
	private MeetingRoomService mServ;

	@Autowired
	private EmployeeService eServ;

	@Autowired
	private VehicleBookingService vService;

	// 예약 메인페이지로 이동
	@RequestMapping("home")
	public String home(String type, @RequestParam(required = false) String keyword, int cPage, Model model) throws Exception {
		
		// 세션에 저장된 사번을 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		
		// 회의실 및 차량 목록을 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		model.addAttribute("type", type);
		
		if (type.equals("meetingRoom")) {
			if(keyword == null) {
				model.addAttribute("listType", "all");
				model.addAttribute("list", mServ.getAllRoomBookingByEmpNo(empNo, cPage));
				model.addAttribute("totalCount", mServ.getCountRoomBookingList(empNo));
			} else {
				model.addAttribute("listType", "search");
				model.addAttribute("list", mServ.getSearchRoomBookingByEmpNo(empNo, keyword, cPage));
				model.addAttribute("totalCount", mServ.getCountSearchRoomBookingList(empNo, keyword));
			}
		} else if (type.equals("vehicle")) {
			if(keyword == null) {
				model.addAttribute("listType", "all");
				model.addAttribute("list", vService.getAllVehicleBookingByEmpNo(empNo, cPage));
				model.addAttribute("totalCount", vService.getCountVehicleList(empNo));
			} else {
				model.addAttribute("listType", "search");
				model.addAttribute("list", vService.getSearchVehicleBookingByEmpNo(empNo, keyword, cPage));
				model.addAttribute("totalCount", vService.getCountSearchVehicleList(empNo, keyword));
			}
			model.addAttribute("totalCount", vService.getCountVehicleList(empNo));
		}
		model.addAttribute("cPage", cPage);
		model.addAttribute("recordCountPerPage", BoardConfig.recordCountPerPage);
		model.addAttribute("naviCountPerPage", BoardConfig.naviCountPerPage);
		return "Reservation/home";
	}

	// 회의실 예약 페이지로 이동
	@RequestMapping("meetingRoom")
	public String reservMeetingRoom(int roomSeq, Model model) throws Exception {
		// 회의실 목록 및 선택한 회의실의 정보를 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		model.addAttribute("meetingRoomInfo", mServ.getMeetingRoomInfo(roomSeq));
		return "Reservation/meetingRoom";
	}

	// 회의실 예약 데이터 등록
	@ResponseBody
	@RequestMapping(value = "meetingRoom/addEvent")
	public Map<String, String> addMeetingRoomEvent(RoomBookingDTO dto, long startDate, long endDate) throws Exception {
		
		// 세션에 저장된 사번으로 예약자 정보 설정
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);
		dto.setDept_title(eServ.getDept(empNo));

		// 클라이언트에서 받아온 long 타입 값으로 예약 날짜 및 시간 설정
		dto.setStart_date(new Timestamp(startDate));
		dto.setEnd_date(new Timestamp(endDate));
		
		Map<String, String> resp = new HashMap<>();
		
		// 예약을 원하는 시간과 겹치는 데이터가 존재한다면 데이터를 저장하지 않고 클라이언트로 이동
		int result = mServ.checkBooking(dto);
		if (result > 0) {
			resp.put("result", "불가능");
			return resp;
		}
		// 클라이언트에서 받아온 정보와 위에서 설정한 정보들을 DB에 저장
		mServ.addMeetingRoomEvent(dto);
		resp.put("result", "등록 완료");
		return resp;
	}

	// 회의실 예약 페이지 로드 시 해당 회의실의 모든 예약 정보를 AJAX로 넘겨주기 위한 메서드
	@ResponseBody
	@RequestMapping("allRoomBooking")
	public List<RoomBookingDTO> getAllRoomBooking(String roomSeq) throws Exception {
		// 해당 회의실의 모든 예약 정보를 조회 후 데이터 전송
		return mServ.getAllRoomBooking(Integer.parseInt(roomSeq));
	}

	// 차량 예약 페이지로 이동
	@RequestMapping("vehicle")
	public String reservVehicle(int vehicleSeq, Model model) throws Exception {
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		model.addAttribute("vehicleInfo", vService.getVehicleInfo(vehicleSeq));
		return "Reservation/vehicle";
	}

	// 차량 예약 데이터 등록
	@RequestMapping("saveVehicle")
	public String saveVehicle(VehicleBookingDTO dto, @RequestParam("vehicleStartAt") long startDate,
			@RequestParam("vehicleEndAt") long endDate, Model model) {
		
		String empNo = (String) session.getAttribute("loginID");
		dto.setEmp_no(empNo);	

	    // name 값을 모델에 추가하여 JSP에서 사용 가능하게 함
	    // model.addAttribute("name", name);
		EmployeeInfoDTO eDTO = eServ.getNameNDept(empNo);
		dto.setDept_title(eDTO.getDept_title());
		dto.setName(eDTO.getName());
		dto.setStart_date(new Timestamp(startDate));
		dto.setEnd_date(new Timestamp(endDate));
		
		int result = vService.saveVehicle(dto);

		if (result == 1) {
			return "redirect:/reservation/vehicle?vehicleSeq=" + dto.getVehicle_seq();
		}
		// 추후 오류 페이지로 수정
		return "redirect:/reservation/vehicle?vehicleSeq=" + dto.getVehicle_seq();
	}

	// 차량 예약 조회
	@ResponseBody
	@RequestMapping("/allVehicleBooking")
	public List<VehicleBookingDTO> getAllVehicleBooking(String vehicleSeq) throws Exception {
		return vService.getAllVehicleBooking(vehicleSeq);
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/";
	}
}