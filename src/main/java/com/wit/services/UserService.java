package com.wit.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.UserDAO;

@Service
public class UserService {

    @Autowired
    private UserDAO dao;

    public String getUserNameByLoginID(String loginID) {
        return dao.getUserNameByLoginID(loginID);
    }
}