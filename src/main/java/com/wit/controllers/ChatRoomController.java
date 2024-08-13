package com.wit.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.dto.NotificationDTO;
import com.wit.services.ChatRoomService;
import com.wit.services.ChatService;
import com.wit.services.NotificationService;

@Controller
@RequestMapping("/chatroom/")
public class ChatRoomController {
	@Autowired
	private ChatRoomService serv;
	
	@Autowired
	private ChatService chatServ;

	@Autowired
	private HttpSession session;

	@Autowired
    private NotificationService notiServ;
	
	// 개인 채팅방 생성
	@RequestMapping("create")
	@ResponseBody
	public String createPrivateChat(String emp_no1, String chat_room_name) {
		String emp_no2 = (String) session.getAttribute("loginID");
		String result = serv.createPrivateChat(emp_no1, emp_no2, chat_room_name);
		if (result.equals("success")) {
			return "success";
		}
		return "false";
	}

	// 그룹 채팅방 생성
	@RequestMapping("createGroup")
	@ResponseBody
	public String createGroupChat(String chatRoomName, @RequestParam("empNos") List<String> empNos) {
		String emp_no = (String) session.getAttribute("loginID");
		serv.createGroupChat(chatRoomName, empNos, emp_no);
		return "success";
	}

	// 채팅방 목록 조회
	@RequestMapping("myChatRooms")
	@ResponseBody
	public List<Map<String, Object>> getMyChatRooms() {
	    String empNo = (String) session.getAttribute("loginID");
	    List<Map<String, Object>> chatRooms = serv.getChatRoomsByUserId(empNo);
	    return chatRooms;
	}

	// 채팅방 목록 상세
	@RequestMapping("details")
	@ResponseBody
	public List<Map<String, Object>> getDetailChatRooms(int chat_room_seq) {
		String emp_no = (String) session.getAttribute("loginID");
		return serv.getDetailChatRooms(chat_room_seq, emp_no);
	}

	// 채팅방 제목 수정
	@RequestMapping("updateTitle")
	@ResponseBody
	public String updateChatRoomTitle(int chat_room_seq, String new_title) {
		serv.updateChatRoomTitle(chat_room_seq, new_title);
		return "Title updated";
	}

	// 채팅방 나가기
	@RequestMapping("exit")
	@ResponseBody
	public String exitChatRoom(int chat_room_seq) {
		String emp_no = (String) session.getAttribute("loginID");
		System.out.println(chat_room_seq + " / " + emp_no);
		String result = serv.exitChatRoom(chat_room_seq, emp_no);
		return result;
	}


    // 알림 목록 조회
    @RequestMapping("getNotifications")
    @ResponseBody
    public List<NotificationDTO> getNotifications() {
    	String emp_no = (String) session.getAttribute("loginID");
        return notiServ.getNotifications(emp_no);
    }
    
    // 새로운 메시지가 도착했을 때
    @RequestMapping("newMessage")
    @ResponseBody
    public String handleNewMessage(int chatRoomSeq, String empNo, int chatSeq) {
    	chatServ.handleNewMessage(chatRoomSeq, empNo, chatSeq);
        return "success";
    }

    // 채팅방을 확인했을 때
    @RequestMapping("markAsRead")
    @ResponseBody
    public String markAsRead(int chatRoomSeq, String empNo) {
    	chatServ.markMessagesAsRead(chatRoomSeq, empNo);
        return "success";
    }

    // 알림 개수 조회 (JSP에서 활용)
    @RequestMapping("notificationCount")
    @ResponseBody
    public int getNotificationCount() {
    	String emp_no = (String) session.getAttribute("loginID");
        return notiServ.getNotificationCount(emp_no);
    }
    
    @RequestMapping("broadcastUserLeft")
    @ResponseBody
    public String broadcastUserLeft(int chat_room_seq) {
        String empNo = (String) session.getAttribute("loginID");
        String userName = chatServ.getUserNameByLoginID(empNo);

        chatServ.broadcastUserLeft(chat_room_seq, userName);

        return "success";
    }
	// 예외를 담당하는 메서드 생성
	@ExceptionHandler(Exception.class)
	public String execptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
