package com.questionnaire.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @GetMapping("/")
    public String homePage(@RequestParam(value = "logout", required = false) String logout, Model model) {
        // 添加一些统计数据或系统信息
        model.addAttribute("pageTitle", "在线问卷系统 - 轻松创建专业问卷");
        
        // 如果 logout=success，显示退出登录提示
        if ("success".equals(logout)) {
            model.addAttribute("showLogoutAlert", true);
        }
        
        return "home/index";
    }
}