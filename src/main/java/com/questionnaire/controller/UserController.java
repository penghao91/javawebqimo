package com.questionnaire.controller;

import com.questionnaire.model.User;
import com.questionnaire.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    private User getCurrentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("user");
    }

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(String username, String password, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        User user = userService.findByUsername(username);

        if (user == null || !user.getPassword().equals(password)) {
            result.put("success", false);
            result.put("message", "用户名或密码错误");
            return result;
        }

        request.getSession().setAttribute("user", user);
        result.put("success", true);
        result.put("redirectUrl", "/questionnaire/list");
        return result;
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate(); // 清除session
        return "redirect:/?logout=success";
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

    /** 显示账号信息 */
    @GetMapping("/profile")
    public String profile(HttpServletRequest request, Model model) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        // 从数据库重新查一遍，保证信息是最新的
        User dbUser = userService.findById(user.getId());
        model.addAttribute("user", dbUser);
        model.addAttribute("pageTitle", "账号信息");
        return "user/profile";
    }

    /** 更新账号信息（整合邮箱和密码修改） */
    @PostMapping("/profile")
    public String updateProfile(@RequestParam String email,
                                @RequestParam(required = false) String oldPassword,
                                @RequestParam(required = false) String newPassword,
                                @RequestParam(required = false) String confirmPassword,
                                HttpServletRequest request,
                                RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }

        try {
            boolean passwordModified = false;
            
            // 处理邮箱更新
            String trimmedEmail = email == null ? null : email.trim();
            if (trimmedEmail != null && !trimmedEmail.isEmpty()) {
                // 校验邮箱是否已被其它账号占用
                if (userService.existsByEmailExceptUser(trimmedEmail, user.getId())) {
                    redirectAttributes.addFlashAttribute("error", "该邮箱已被其它账号绑定！");
                    return "redirect:/user/profile";
                }
                user.setEmail(trimmedEmail);
            } else {
                user.setEmail(null);
            }
            
            // 处理密码更新（如果填写了原密码）
            if (oldPassword != null && !oldPassword.trim().isEmpty()) {
                // 验证原密码
                boolean ok = userService.checkPassword(user.getId(), oldPassword);
                if (!ok) {
                    redirectAttributes.addFlashAttribute("error", "原密码不正确！");
                    return "redirect:/user/profile";
                }
                
                // 验证新密码
                if (newPassword == null || newPassword.length() < 6) {
                    redirectAttributes.addFlashAttribute("error", "新密码至少6位！");
                    return "redirect:/user/profile";
                }
                
                if (!newPassword.equals(confirmPassword)) {
                    redirectAttributes.addFlashAttribute("error", "两次输入的新密码不一致！");
                    return "redirect:/user/profile";
                }
                
                // 更新密码
                userService.updatePassword(user.getId(), newPassword);
                passwordModified = true;
            }
            
            // 更新邮箱信息
            userService.updateProfile(user);
            
            // 更新 session 里的用户信息
            request.getSession().setAttribute("user", user);
            
            if (passwordModified) {
                // 修改密码后强制重新登录更安全
                request.getSession().invalidate();
                redirectAttributes.addFlashAttribute("message", "账号信息及密码已更新，请重新登录！");
                return "redirect:/user/login";
            } else {
                redirectAttributes.addFlashAttribute("message", "账号信息已保存");
                return "redirect:/user/profile";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "保存失败：" + e.getMessage());
            return "redirect:/user/profile";
        }
    }

    /** 显示修改密码页面（已整合，保留用于直接访问） */
    @GetMapping("/password")
    public String passwordForm(HttpServletRequest request, Model model) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("pageTitle", "修改密码");
        return "user/password";
    }
}