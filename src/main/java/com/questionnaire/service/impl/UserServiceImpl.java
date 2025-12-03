package com.questionnaire.service.impl;

import com.questionnaire.dao.UserMapper;
import com.questionnaire.model.User;
import com.questionnaire.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public boolean register(User user) {
        if (usernameExists(user.getUsername())) {
            return false;
        }
        
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("user");
        }
        
        return userMapper.insert(user) > 0;
    }

    @Override
    public boolean usernameExists(String username) {
        return userMapper.countByUsername(username) > 0;
    }
}