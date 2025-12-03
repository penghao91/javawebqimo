package com.questionnaire.dao;

import com.questionnaire.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    
    User findByUsername(@Param("username") String username);
    
    User findById(@Param("id") Integer id);
    
    int insert(User user);
    
    int countByUsername(@Param("username") String username);
}