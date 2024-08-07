package com.wit.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/messenger/")
public class MessengerController {

    @RequestMapping("messenger")
    public String messenger() {
        return "Messenger/messenger";
    }

}
