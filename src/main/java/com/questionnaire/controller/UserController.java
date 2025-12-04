package com.questionnaire.controller;

import com.questionnaire.model.User;
import com.questionnaire.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(String username, String password, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        User user = userService.findByUsername(username);

        if (user == null || !user.getPassword().equals(password)) {
            redirectAttributes.addFlashAttribute("error", "用户名或密码错误");
            return "redirect:/user/login";
        }

        request.getSession().setAttribute("user", user);
        return "redirect:/questionnaire/list";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate(); // 清除session
        return "redirect:/user/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "user/register";
    }

    @PostMapping("/register")
    public String register(User user, RedirectAttributes redirectAttributes) {
        if (userService.usernameExists(user.getUsername())) {
            redirectAttributes.addFlashAttribute("error", "用户名已存在");
            return "redirect:/user/register";
        }

        boolean success = userService.register(user);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "注册成功，请登录");
            return "redirect:/user/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "注册失败，请重试");
            return "redirect:/user/register";
        }
    }
}