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

    /**
     * 更新账号信息（主要是邮箱）
     */
    int updateProfile(User user);

    /**
     * 查询除当前用户外是否有同邮箱
     */
    Integer countByEmailExceptUser(@Param("email") String email, @Param("userId") Integer userId);

    /**
     * 更新密码
     */
    int updatePassword(@Param("userId") Integer userId, @Param("password") String password);
}