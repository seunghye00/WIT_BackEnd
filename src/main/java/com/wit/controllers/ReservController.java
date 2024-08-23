package com.wit.controllers;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.wit.dto.MeetingRoomDTO;
import com.wit.dto.RoomBookingDTO;
import com.wit.dto.VehicleBookingDTO;
import com.wit.dto.VehiclesDTO;
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
	@RequestMapping(value = { "admin/home", "home" })
	public String home(String type, @RequestParam(required = false) String keyword, int cPage,
			HttpServletRequest request, Model model) throws Exception {

		// 세션에 저장된 사번을 변수에 저장
		String empNo = (String) session.getAttribute("loginID");

		// 회의실 및 차량 목록을 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		model.addAttribute("type", type);

		if (type.equals("meetingRoom")) {
			if (keyword == null) {
				model.addAttribute("listType", "all");
				model.addAttribute("list", mServ.getAllRoomBookingByEmpNo(empNo, cPage));
				model.addAttribute("totalCount", mServ.getCountRoomBookingList(empNo));
			} else {
				model.addAttribute("listType", "search");
				model.addAttribute("list", mServ.getSearchRoomBookingByEmpNo(empNo, keyword, cPage));
				model.addAttribute("totalCount", mServ.getCountSearchRoomBookingList(empNo, keyword));
			}
		} else if (type.equals("vehicle")) {
			if (keyword == null) {
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

		// 현재 요청된 URL & 직급 정보를 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/reservation/admin/home") && eServ.getRoleCode(empNo).equals("R1")) {
			return "Admin/Reservation/home";
		} else if (currentUrl.equals("/reservation/home") && !eServ.getRoleCode(empNo).equals("R1")) {
			return "Reservation/home";
		} else {
			return "redirect:/error";
		}
	}

	// 예약 항목 관리 페이지로 이동
	@RequestMapping("admin/bookingControll")
	public String bookingControll(String type, @RequestParam(required = false) Integer seq, String purpose, Model model)
			throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 회의실 & 차량 목록을 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		model.addAttribute("controll", type);

		if (type.equals("meetingRoom")) {
			model.addAttribute("allList", mServ.getMeetingRoomList());
			if (seq != null) {
				model.addAttribute("target", mServ.getMeetingRoomInfo(seq));
			}
		} else if (type.equals("vehicle")) {
			model.addAttribute("allList", vService.getVehicleList());
			if (seq != null) {
				model.addAttribute("target", vService.getVehicleInfo(seq));
			}
		}

		model.addAttribute("purpose", purpose);
		return "Admin/Reservation/bookingControll";
	}

	// 예약 항목의 상태 변경
	@RequestMapping("admin/updateStatus")
	public String updateStatus(String target, int seq, String status) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		// 현재 항목과 항목의 상태에 따라 변경할 상태 설정 후 상태 변경
		if (status.equals("예약 가능")) {
			status = "예약 불가능";
		} else if (status.equals("예약 불가능")) {
			status = "예약 가능";
		} else {
			return "redirect:/error";
		}
		if (target.equals("meetingRoom")) {
			mServ.updateStatus(seq, status);
		} else if (target.equals("vehicle")) {
			vService.updateStatus(seq, status);
		} else {
			return "redirect:/error";
		}
		return "redirect:/reservation/admin/bookingControll?type=" + target + "&purpose=controll";
	}

	// 예약 항목의 안내 사항 변경
	@RequestMapping("admin/updateGuideLines")
	public String updateGuideLines(String target, int seq, String guideLines) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}

		if (target.equals("meetingRoom")) {
			mServ.updateGuideLines(seq, guideLines);
		} else if (target.equals("vehicle")) {
			vService.updateGuideLines(seq, guideLines);
		} else {
			return "redirect:/error";
		}
		return "redirect:/reservation/admin/bookingControll?type=" + target + "&seq= " + seq + "&purpose=notice";
	}

	// 예약 항목 삭제
	@RequestMapping("admin/deleteTarget")
	public String deleteTarget(String target, int seq) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		if (target.equals("meetingRoom")) {
			mServ.deleteBySeq(seq);
		} else if (target.equals("vehicle")) {
			vService.deleteBySeq(seq);
		} else {
			return "redirect:/error";
		}
		return "redirect:/reservation/admin/bookingControll?type=" + target + "&purpose=controll";
	}

	// 예약 항목 추가
	@RequestMapping("admin/add")
	public String addTarget(String target, MeetingRoomDTO mDTO, VehiclesDTO vDTO) throws Exception {

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 관리자 계정이 아닐 시 관리자 경로 접속 불가
		if (!eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/error";
		}
		if (target.equals("meetingRoom")) {
			mServ.addRoom(mDTO);
		} else if (target.equals("vehicle")) {
			vService.addVehicle(vDTO);
		} else {
			return "redirect:/error";
		}
		return "redirect:/reservation/admin/bookingControll?type=" + target + "&purpose=controll";
	}

	// 회의실 예약 페이지로 이동
	@RequestMapping(value = { "admin/meetingRoom", "meetingRoom" })
	public String reservMeetingRoom(int roomSeq, HttpServletRequest request, Model model) throws Exception {

		// 회의실 & 차량 목록 및 선택한 회의실의 정보를 조회해서 model 객체에 담아 JSP로 전달
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		MeetingRoomDTO dto = mServ.getMeetingRoomInfo(roomSeq);

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 현재 요청된 URL을 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/reservation/admin/meetingRoom") && eServ.getRoleCode(empNo).equals("R1")) {
			if (dto == null || dto.getStatus().equals("예약 불가능")) {
				return "redirect:/reservation/admin/home?type=meetingRoom&cPage=1";
			}
			model.addAttribute("meetingRoomInfo", dto);
			return "Admin/Reservation/meetingRoom";

		} else if (currentUrl.equals("/reservation/meetingRoom") && !eServ.getRoleCode(empNo).equals("R1")) {
			if (dto == null || dto.getStatus().equals("예약 불가능")) {
				return "redirect:/reservation/home?type=meetingRoom&cPage=1";
			}
			model.addAttribute("meetingRoomInfo", dto);
			return "Reservation/meetingRoom";

		} else {
			return "redirect:/error";
		}
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
	@RequestMapping(value = { "admin/vehicle", "vehicle" })
	public String reservVehicle(int vehicleSeq, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("meetingRooms", mServ.getMeetingRoomList("예약 가능"));
		model.addAttribute("vehicles", vService.getVehicleList("예약 가능"));
		VehiclesDTO dto = vService.getVehicleInfo(vehicleSeq);

		// 세션에서 접속자 정보를 꺼내 변수에 저장
		String empNo = (String) session.getAttribute("loginID");
		// 현재 요청된 URL을 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/reservation/admin/vehicle") && eServ.getRoleCode(empNo).equals("R1")) {
			if (dto == null || dto.getStatus().equals("예약 불가능")) {
				return "redirect:/error";
			}
			model.addAttribute("vehicleInfo", dto);
			return "Admin/Reservation/vehicle";

		} else if (currentUrl.equals("/reservation/vehicle") && !eServ.getRoleCode(empNo).equals("R1")) {
			if (dto == null || dto.getStatus().equals("예약 불가능")) {
				return "redirect:/error";
			}
			model.addAttribute("vehicleInfo", dto);
			return "Reservation/vehicle";

		} else {
			return "redirect:/error";
		}
	}
	
	// 차량 예약 데이터 등록
	@RequestMapping(value = { "admin/saveVehicle", "saveVehicle" })
	public String saveVehicle(VehicleBookingDTO dto, @RequestParam("vehicleStartAt") long startDate,
			@RequestParam("vehicleEndAt") long endDate, HttpServletRequest request, Model model) {

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
		if (result < 1) {
			return "redirect:/error";
		}
		// 현재 요청된 URL & 직급 정보를 확인 후 이동 경로 설정
		String currentUrl = request.getRequestURI();
		if (currentUrl.equals("/reservation/admin/saveVehicle") && eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/reservation/admin/vehicle?vehicleSeq=" + dto.getVehicle_seq();
		} else if (currentUrl.equals("/reservation/saveVehicle") && !eServ.getRoleCode(empNo).equals("R1")) {
			return "redirect:/reservation/vehicle?vehicleSeq=" + dto.getVehicle_seq();
		} else {
			return "redirect:/error";
		}
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
		return "redirect:/error";
	}
}