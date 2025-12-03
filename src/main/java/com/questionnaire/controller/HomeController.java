package com.questionnaire.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String homePage(Model model) {
        // 添加一些统计数据或系统信息
        model.addAttribute("pageTitle", "在线问卷系统 - 轻松创建专业问卷");
        return "home/index";
    }
}