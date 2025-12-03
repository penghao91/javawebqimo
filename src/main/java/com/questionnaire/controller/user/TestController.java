package com.questionnaire.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
    
    @GetMapping("/test-login")
    public String testLogin() {
        return "user/test-login";
    }
}
