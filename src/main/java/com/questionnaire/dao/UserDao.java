package com.questionnaire.dao;

import com.questionnaire.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {
    
    User findByUsername(@Param("username") String username);
    
    User findById(@Param("id") Integer id);
    
    int insert(User user);
    
    int countByUsername(@Param("username") String username);
}