package com.questionnaire.service.impl;

import com.questionnaire.dao.UserMapper;
import com.questionnaire.model.User;
import com.questionnaire.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserMapper userMapper, PasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * This method is the core of Spring Security integration.
     * It loads a user by their username and returns a UserDetails object.
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("Username not found: " + username);
        }
        return user;
    }
    
    @Override
    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    /**
     * Registers a new user, ensuring the password is encoded.
     */
    @Override
    public boolean register(User user) {
        if (usernameExists(user.getUsername())) {
            return false;
        }
        
        // Encode the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        
        // Set a default role if none is provided
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
