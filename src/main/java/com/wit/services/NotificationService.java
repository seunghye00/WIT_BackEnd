package com.wit.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.NotificationDAO;
import com.wit.dto.NotificationDTO;

@Service
public class NotificationService {
	@Autowired
	private NotificationDAO dao;

	// 사용자별 알림 목록 조회
	public List<NotificationDTO> getNotifications(String empNo) {
		return dao.getNotifications(empNo);
	}
	
    // 사용자별 알림 개수 조회
    public int getNotificationCount(String empNo) {
        return dao.countNotifications(empNo);
    }
}
