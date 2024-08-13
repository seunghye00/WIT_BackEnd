package com.wit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.dto.NotificationDTO;

@Repository
public class NotificationDAO {
	@Autowired
    private SqlSession mybatis;

    // 사용자별 알림 목록 조회
    public List<NotificationDTO> getNotifications(String empNo) {
        return mybatis.selectList("notification.getNotifications", empNo);
    }
    
    // 새로운 알림 삽입
    public void insertNotification(String empNo, int chatSeq) {
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("chatSeq", chatSeq);
        mybatis.insert("notification.insertNotification", params);
    }

    // 사용자별 알림 개수 조회
    public int countNotifications(String empNo) {
        return mybatis.selectOne("notification.countNotifications", empNo);
    }

    // 알림 삭제
    public void deleteNotifications(int chatRoomSeq, String empNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomSeq", chatRoomSeq);
        params.put("empNo", empNo);
        mybatis.delete("notification.deleteNotifications", params);
    }

}
