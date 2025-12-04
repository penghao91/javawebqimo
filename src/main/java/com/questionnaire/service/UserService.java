package com.questionnaire.service;

import com.questionnaire.dao.UserDao;
import com.questionnaire.model.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UserService {

    @Resource
    private UserDao userDao;

    /**
     * 根据用户名查询用户
     */
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    /**
     * 根据ID查询用户
     */
    public User findById(Integer id) {
        return userDao.findById(id);
    }

    /**
     * 注册新用户（明文密码、设置默认角色）
     */
    public boolean register(User user) {
        if (usernameExists(user.getUsername())) {
            return false;
        }

        // 设置默认角色
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("user");
        }

        return userDao.insert(user) > 0;
    }

    /**
     * 判断用户名是否已存在
     */
    public boolean usernameExists(String username) {
        return userDao.countByUsername(username) > 0;
    }
}