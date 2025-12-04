package com.questionnaire.service;

import com.questionnaire.dao.UserMapper;
import com.questionnaire.model.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.annotation.Resource;

@Service
@Transactional
public class UserService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private PasswordEncoder passwordEncoder;

    /**
     * 加载用户信息（Spring Security 登录验证）
     */
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("用户名不存在：" + username);
        }
        return user;
    }

    /**
     * 根据用户名查询用户
     */
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    /**
     * 根据ID查询用户
     */
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    /**
     * 注册新用户（自动加密密码、设置默认角色）
     */
    public boolean register(User user) {
        if (usernameExists(user.getUsername())) {
            return false;
        }

        // 加密密码
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // 设置默认角色
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("user");
        }

        return userMapper.insert(user) > 0;
    }

    /**
     * 判断用户名是否已存在
     */
    public boolean usernameExists(String username) {
        return userMapper.countByUsername(username) > 0;
    }
}