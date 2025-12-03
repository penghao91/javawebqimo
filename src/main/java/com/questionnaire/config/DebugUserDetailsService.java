package com.questionnaire.config;

import com.questionnaire.model.User;
import com.questionnaire.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

// @Service
public class DebugUserDetailsService implements UserDetailsService {
    
    private static final Logger logger = LoggerFactory.getLogger(DebugUserDetailsService.class);
    
    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        logger.info("Attempting to load user: {}", username);
        
        User user = userService.findByUsername(username);
        
        if (user == null) {
            logger.error("User not found: {}", username);
            throw new UsernameNotFoundException("User not found: " + username);
        }
        
        logger.info("User found: {}", username);
        logger.info("User ID: {}", user.getId());
        logger.info("User role: {}", user.getRole());
        logger.info("Password from DB: {}", user.getPassword());
        logger.info("Password length: {}", user.getPassword() != null ? user.getPassword().length() : 0);
        logger.info("Password starts with $2a$: {}", user.getPassword() != null && user.getPassword().startsWith("$2a$"));
        
        return user;
    }
}
