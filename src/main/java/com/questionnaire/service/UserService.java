package com.questionnaire.service;

import com.questionnaire.model.User;

public interface UserService {
    
    User findByUsername(String username);
    
    User findById(Integer id);
    
    boolean register(User user);
    
    boolean usernameExists(String username);
}